//
//  OnboardingViewController.m
//  BabysFirstYear
//
//  Created by James Oey on 5/16/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "OnboardingViewController.h"
#import "OnboardingView.h"
#import "Project.h"
#import "MainViewController.h"
#import "SflyData.h"

@interface OnboardingViewController () {
    OnboardingView *onboardingView;
}

@end

@implementation OnboardingViewController

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
    onboardingView = [[OnboardingView alloc] initWithFrame:bounds];
    
    [onboardingView.submitButton addTarget:self action:@selector(submitProject) forControlEvents:UIControlEventTouchUpInside];
   
    [onboardingView.boyButton setSelected:NO];
    [onboardingView.girlButton setSelected:NO];
    
    [onboardingView.boyButton addTarget:self action:@selector(touchedBoyButton) forControlEvents:UIControlEventTouchUpInside];
    [onboardingView.girlButton addTarget:self action:@selector(touchedGirlButton) forControlEvents:UIControlEventTouchUpInside];
    
    onboardingView.nameField.delegate = self;
    onboardingView.dateField.delegate = self;
    
    
    // single tap gesture recognizer
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker)];
    tapGestureRecognize.numberOfTapsRequired = 1;
    [onboardingView addGestureRecognizer:tapGestureRecognize];

    self.view = onboardingView;
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


- (void) submitProject {
    if ([onboardingView.nameField.text isEqualToString:@""] ||
        (onboardingView.girlButton.selected == NO &&
         onboardingView.boyButton.selected == NO)) {
    } else {
        [Project project];

        NSString *name = onboardingView.nameField.text;
        Project *project = [SflyData project];
        project.name = onboardingView.nameField.text;
        project.startTime = onboardingView.birthdatePicker.date;
        if (onboardingView.girlButton.selected) {
            project.isBoy = @NO;
        } else {
            project.isBoy = @YES;
        }
        MainViewController *mvController = [[MainViewController alloc] initWithProject:project];
        [self presentViewController:mvController animated:YES completion:nil];
    }
}

#pragma mark - buttons

- (void)touchedBoyButton {
    onboardingView.boyButton.selected = YES;
    onboardingView.girlButton.selected = NO;
}

- (void)touchedGirlButton {
    onboardingView.girlButton.selected = YES;
    onboardingView.boyButton.selected = NO;
}

#pragma mark - text fields

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == onboardingView.nameField) {
        return YES;
    } else if (textField == onboardingView.dateField) {
        [onboardingView.birthdatePicker setHidden:NO];
        return NO;
    } else {
        return NO;
    }
}

#pragma mark - date picker


- (void)dismissDatePicker {
    if (onboardingView.birthdatePicker.hidden == NO) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMMM d, y"];
        NSString *dateString = [dateFormatter stringFromDate:onboardingView.birthdatePicker.date];
        onboardingView.dateField.text = dateString;
        onboardingView.birthdatePicker.hidden = YES;
    }
}


@end
