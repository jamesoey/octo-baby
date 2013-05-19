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
#import "Project.h"

@interface CaptureMomentViewController () {
    Task *task;
    CaptureMomentView *captureMomentView;
    UIImagePickerController *cameraUI;
    UIImagePickerController *mediaUI;
    UIImage *currentImage;
    NSURL *currentURL;
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
    
    [captureMomentView.tryAgainButton addTarget:self action:@selector(touchedTryAgain) forControlEvents:UIControlEventTouchUpInside];
    [captureMomentView.looksGreatButton addTarget:self action:@selector(touchedLooksGreat) forControlEvents:UIControlEventTouchUpInside];
    
    [captureMomentView.backButton addTarget:self action:@selector(touchedBackButton) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *cameraRollTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedCameraRollButton)];
    [captureMomentView.cameraRollView addGestureRecognizer:cameraRollTapRecognizer];
    
    if (task.caption && ![task.caption isEqualToString:@""]) {
        captureMomentView.taskNameTextField.text = task.caption;
    } else {
        captureMomentView.taskNameTextField.text = [[SflyData project] name];
    }
    captureMomentView.taskNameTextField.delegate = self;
    
    
    [self activateCaptureAssets:YES];
    
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tapGestureRecognize.numberOfTapsRequired = 1;
    [captureMomentView addGestureRecognizer:tapGestureRecognize];

    
    
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
        currentImage = [info valueForKey:UIImagePickerControllerOriginalImage];
        
        UIImage *croppedImage = [self cropCameraImage:currentImage];
        
        [captureMomentView.previewImageView setImage:croppedImage];
        captureMomentView.previewImageView.hidden = NO;

        [[AssetsLibraryController sharedController] saveImage:currentImage completion:^(NSURL *assetURL) {
            currentURL = assetURL;
            [self dismissViewControllerAnimated:YES completion:^{
                [self activateCaptureAssets:NO];
            }];
        }];
    } else {
        NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
        UIImage *originalImage, *editedImage;
    
        // Handle a still image capture
        if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
            == kCFCompareEqualTo) {
        
            editedImage = (UIImage *) [info objectForKey:
                                       UIImagePickerControllerEditedImage];
            originalImage = (UIImage *) [info objectForKey:
                                         UIImagePickerControllerOriginalImage];
        
            if (editedImage) {
                currentImage = editedImage;
            } else {
                currentImage = originalImage;
            }
        
            // Save the new image (original or edited) to the Camera Roll
            //UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);

            UIImage *croppedImage = [self cropCameraImage:currentImage];
            
            [captureMomentView.previewImageView setImage:croppedImage];
            captureMomentView.previewImageView.hidden = NO;

        
            [[AssetsLibraryController sharedController] saveImage:currentImage completion:^(NSURL *assetURL) {
                currentURL = assetURL;
                [self activateCaptureAssets:NO];
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

- (UIImage *)cropCameraImage:(UIImage*)img {
    CGImageRef imageToBeResized = img.CGImage;
    CGFloat w = img.size.width;
    CGFloat h = img.size.height;
    
    CGImageRef partOfImageAsCG = CGImageCreateWithImageInRect(imageToBeResized, CGRectMake(0, 0.2*h, w, w));

    return [UIImage imageWithCGImage:partOfImageAsCG scale:1.0 orientation:[img imageOrientation]];
}

#pragma mark - View Toggling

- (void)activateCaptureAssets:(BOOL)capture {
    captureMomentView.topLine.hidden = !capture;
    captureMomentView.botLine.hidden = !capture;
    captureMomentView.cameraRollIcon.hidden = !capture;
    captureMomentView.cameraRollLabel.hidden = !capture;
    captureMomentView.forwardArrow.hidden = !capture;
    captureMomentView.cameraIcon.hidden = !capture;
    
    captureMomentView.looksGreatButton.hidden = capture;
    captureMomentView.tryAgainButton.hidden = capture;
    captureMomentView.taskNameTextField.hidden = capture;
    captureMomentView.cameraButton.enabled = capture;
}

- (void)animateTextBoxWithActivate:(BOOL)activate {
    [UIView animateWithDuration:0.5 animations:^{
    if (activate) {
        captureMomentView.taskNameTextField.frame = CGRectMake(40, 60, 240, 40);
        captureMomentView.cameraButton.frame = CGRectMake((320-280)/2.0, 120, 280, 280);
        captureMomentView.previewImageView.frame = CGRectMake((320-280)/2.0+18, 120+18, 280-2*18, 280-2*18);
    } else {
        captureMomentView.taskNameTextField.frame = CGRectMake(40, 380, 240, 40);
        captureMomentView.cameraButton.frame = CGRectMake((320-280)/2.0, 74, 280, 280);
        captureMomentView.previewImageView .frame = CGRectMake((320-280)/2.0+18, 74+18, 280-2*18, 280-2*18);
    }
    } completion:nil];
        
}

#pragma mark - Button Actions

- (void)touchedLooksGreat {
    if ([captureMomentView.taskNameTextField.text isEqualToString:@""]) {
        return;
    }
    task.caption = captureMomentView.taskNameTextField.text;
    Moment *moment = [Moment moment];
    Moment *momentToDel = [task moment];
    if (momentToDel != nil && [momentToDel.tasks count] == 1) {
        [[SflyCore context] deleteObject:momentToDel];
    }
    [task setMoment:moment];
    moment.uid = [currentURL absoluteString];
    [SflyCore saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchedTryAgain {
    captureMomentView.previewImageView.hidden = YES;
    
    [self activateCaptureAssets:YES];
}

- (void)touchedBackButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Text Fields
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self animateTextBoxWithActivate:NO];
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self animateTextBoxWithActivate:YES];
    return YES;
}

- (void) dismiss {
    [captureMomentView.taskNameTextField resignFirstResponder];
    [self animateTextBoxWithActivate:NO];
}

@end
