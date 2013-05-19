//
//  FullMomentViewController.m
//  BabysFirstYear
//
//  Created by James Oey on 5/17/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "FullMomentViewController.h"
#import "FullMomentView.h"
#import "AssetsLibraryController.h"
#import "Task.h"

@interface FullMomentViewController () {
    FullMomentView *fullMomentView;
}
@end

@implementation FullMomentViewController

@synthesize task;

- (id)initWithTask:(Task*)t andIndex:(int)index {
    self = [super init];
    if (self) {
        task = t;
        self.index = index;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self layoutPage];
    
    

	// Do any additional setup after loading the view.
}

- (void)layoutPage {
    
    // On orientation change we call layoutPage again so make sure to clear out previously
    // layed out items
    if (self.bg.superview) {
        [self.bg removeFromSuperview];
    }
    if (self.spine.superview) {
        [self.spine removeFromSuperview];
    }
    if (self.photo.superview) {
        [self.photo removeFromSuperview];
    }
    if (self.specialBg.superview) {
        [self.specialBg removeFromSuperview];
        self.specialBg.image = nil;
    }
    
    self.bg = [[UIImageView alloc] init];
    self.bg.frame = CGRectMake(0,0,270,268);
    self.bg.backgroundColor = [UIColor whiteColor];
    
    self.photo = [[UIImageView alloc] init];
    
    if (UIDeviceOrientationIsLandscape(self.interfaceOrientation)) {
        
        
        // Odd page since we start at index of 0 not 1
        // LEFT SIDE
        if (self.index % 2 == 0) {
            UIImage *bookOverLayLeft = [UIImage imageNamed:@"imgLeftSpineShadow.png"];
            self.spine = [[UIImageView alloc] initWithImage:bookOverLayLeft];
            self.spine.frame = CGRectMake(270-bookOverLayLeft.size.width,0,bookOverLayLeft.size.width,
                                          bookOverLayLeft.size.height-1);

            // Special case for the first task image
            if (self.index == 0) {
                self.specialBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
                self.specialBg.frame = CGRectMake(9,18,230,230);
                self.photo.frame = CGRectMake(25,35,200,200);
            } else {
                self.photo.frame = CGRectMake(9,18,230,230);
            }
        } else {
            UIImage *bookOverLayRight = [UIImage imageNamed:@"imgRightSpineShadow.png"];
            self.spine = [[UIImageView alloc] initWithImage:bookOverLayRight];
            self.spine.frame = CGRectMake(0,0,bookOverLayRight.size.width, bookOverLayRight.size.height-1);
            self.photo.frame = CGRectMake(30,18,230,230);
        }
    } else {
        UIImage *bookOverLayRight = [UIImage imageNamed:@"imgRightSpineShadow.png"];
        self.spine = [[UIImageView alloc] initWithImage:bookOverLayRight];
        self.spine.frame = CGRectMake(0,0,bookOverLayRight.size.width, bookOverLayRight.size.height-1);

        // Special case for the first task image
        if (self.index == 0) {
            self.specialBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
            self.specialBg.frame = CGRectMake(30,18,230,230);
            self.photo.frame = CGRectMake(45,35,200,200);
        } else {
            self.photo.frame = CGRectMake(30,18,230,230);
        }
    }
    
    self.specialBg.alpha = 0;
    self.bg.alpha = 0;
    self.photo.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bg.alpha = 1;
        self.specialBg.alpha = 1;
    }];
    
    [self.view addSubview:self.bg];
    [self.view addSubview:self.spine];
    [self.view addSubview:self.specialBg];
    [self.view addSubview:self.photo];
    [self refreshPhoto];
}

- (void)refreshPhoto {
    [[AssetsLibraryController sharedController] imageForURL:task.moment.uid success:^(UIImage *image) {
        self.photo.image = image;
        [self animateIn];
    } failureBlock:^(NSError *error) {
        NSLog(@"ERROR: Cannot add image to FMV image view");
    }];
}

- (void)hideAll {
    self.bg.alpha = 0;
    self.photo.alpha = 0;
    self.spine.alpha = 0;
    self.specialBg.alpha = 0;
}

- (void)animateIn {
    [UIView animateWithDuration:1.0 animations:^{
        self.photo.alpha = 1;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self layoutPage];
}


@end
