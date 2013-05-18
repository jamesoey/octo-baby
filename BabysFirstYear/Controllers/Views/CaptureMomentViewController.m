//
//  CaptureMomentViewController.m
//  BabysFirstYear
//
//  Created by James Oey on 5/17/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "CaptureMomentViewController.h"
#import "Task.h"
#import "CaptureMomentView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "Moment.h"
#import "AssetsLibraryController.h"
#import "SflyCore.h"
#import "SflyData.h"

@interface CaptureMomentViewController () {
    Task *task;
    CaptureMomentView *captureMomentView;
    UIImagePickerController *cameraUI;
    UIImagePickerController *mediaUI;
}
@end

@implementation CaptureMomentViewController

- (id)initWithTask:(Task*)t {
    self = [super init];
    if (self) {
        task = t;
        cameraUI = nil;
        mediaUI = nil;
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) loadView {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    captureMomentView = [[CaptureMomentView alloc] initWithFrame:bounds task:task];
    [captureMomentView.cameraButton addTarget:self action:@selector(touchedCameraButton) forControlEvents:UIControlEventTouchUpInside];
    //[captureMomentView.cameraButton addTarget:self action:@selector(touchedCameraRollButton) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *cameraRollTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedCameraRollButton)];
    [captureMomentView.cameraRollView addGestureRecognizer:cameraRollTapRecognizer];
    
    
    self.view = captureMomentView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Camera functions

- (void)touchedCameraButton {
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

# pragma mark - Camera Roll functions

- (void)touchedCameraRollButton {
    [self startImagePickerControllerFromViewController:self usingDelegate:self];
}

# pragma mark - Generic Camera functions

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes = [NSArray arrayWithObjects:(NSString*)kUTTypeImage, nil];
    //[UIImagePickerController availableMediaTypesForSourceType:
    // UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [self presentViewController:cameraUI animated:YES completion:nil];
    return YES;
}

- (BOOL) startImagePickerControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    

    mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    // Displays saved pictures and movies, if both are available, from the
    // Camera Roll album.
    mediaUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = NO;
    
    mediaUI.delegate = delegate;
    
    [self presentViewController:mediaUI animated:YES completion:nil];
    return YES;
}


/*// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [[picker parentViewController] dismissModalViewControllerAnimated: YES];
    [picker release];
}*/

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    if (picker == mediaUI) {
        UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];

        Moment *moment = [Moment moment];
        Moment *momentToDel = [task moment];
        if (momentToDel != nil && [momentToDel.tasks count] == 1) {
            [[SflyCore context] deleteObject:momentToDel];
        }
        [task setMoment:moment];
        
        [[AssetsLibraryController sharedController] saveImage:image toMoment:moment completion:^(void) {
            [self dismissViewControllerAnimated:YES completion:^{
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }];
    } else {
        NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
        UIImage *originalImage, *editedImage, *imageToSave;
    
        // Handle a still image capture
        if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
            == kCFCompareEqualTo) {
        
            editedImage = (UIImage *) [info objectForKey:
                                       UIImagePickerControllerEditedImage];
            originalImage = (UIImage *) [info objectForKey:
                                         UIImagePickerControllerOriginalImage];
        
            if (editedImage) {
                imageToSave = editedImage;
            } else {
                imageToSave = originalImage;
            }
        
            // Save the new image (original or edited) to the Camera Roll
            //UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);

        
            Moment *moment = [Moment moment];
            Moment *momentToDel = [task moment];
            if (momentToDel != nil && [momentToDel.tasks count] == 1) {
                [[SflyCore context] deleteObject:momentToDel];
            }
            [task setMoment:moment];
        
            [[AssetsLibraryController sharedController] saveImage:imageToSave toMoment:moment completion:^(void) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];

        }
    
        // Handle a movie capture
        if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0)
            == kCFCompareEqualTo) {
        
            NSString *moviePath = [[info objectForKey:
                                UIImagePickerControllerMediaURL] path];
        
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
                UISaveVideoAtPathToSavedPhotosAlbum (
                                                 moviePath, nil, nil, nil);
            }
        }
    
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
