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
#import "SflyCore.h"
#import "CaptureMomentViewController.h"

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
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
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


- (BOOL)validateForm {
    if ([onboardingView.nameField.text isEqualToString:@""] ||
        (onboardingView.girlButton.selected == NO &&
         onboardingView.boyButton.selected == NO) ||
        [onboardingView.dateField.text isEqualToString:@""]) {
            onboardingView.submitButton.alpha = 0.4;
            return NO;
        } else {
            onboardingView.submitButton.alpha = 1.0;
            return YES;
        }
}

- (void) submitProject {
    if (![self validateForm]) {
    } else {
        [Project projectWithName:onboardingView.nameField.text isBoy:onboardingView.boyButton.selected];

        Project *project = [SflyData project];
        project.startTime = onboardingView.birthdatePicker.date;
        [self performSelector:@selector(presentNextView:) withObject:project afterDelay:3];
    }
}

- (void)presentNextView:(Project*)project {
    [SflyCore saveContext];

    NSSortDescriptor *weekSort = [[NSSortDescriptor alloc] initWithKey:@"weeksFromStart" ascending:YES];
    NSArray *tasks = [project.tasks sortedArrayUsingDescriptors:@[weekSort]];

    MainViewController *mvController = [[MainViewController alloc] initWithProject:project];
    [SflyCore storeMainViewController:mvController];
    [self presentViewController:mvController animated:YES completion:^{
            CaptureMomentViewController *cmViewController =
            [[CaptureMomentViewController alloc] initWithTask:[tasks objectAtIndex:0]];
            [mvController presentViewController:cmViewController animated:YES completion:nil];
        }];
}

#pragma mark - buttons

- (void)touchedBoyButton {
    onboardingView.boyButton.selected = YES;
    onboardingView.girlButton.selected = NO;
    [self validateForm];
}

- (void)touchedGirlButton {
    onboardingView.girlButton.selected = YES;
    onboardingView.boyButton.selected = NO;
    [self validateForm];
}

#pragma mark - text fields

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self validateForm];
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == onboardingView.nameField) {
        [onboardingView.birthdatePicker resignFirstResponder];
        [self dismissDatePicker];
        return YES;
    } else if (textField == onboardingView.dateField) {
        [self invokeDatePicker];
        [onboardingView.nameField resignFirstResponder];
        return NO;
    } else {
        return NO;
    }
}

#pragma mark - date picker

- (void) dismiss {
    [self dismissDatePicker];
    [self dismissKeyboard];
}

- (void)invokeDatePicker {
    onboardingView.birthdatePicker.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        onboardingView.birthdatePicker.frame = CGRectMake(0,self.view.frame.size.height-onboardingView.birthdatePicker.frame.size.height,
                                                          onboardingView.birthdatePicker.frame.size.width,onboardingView.birthdatePicker.frame.size.height);
    } completion:^(BOOL finished) {
        
        [self validateForm];
    }];
    
}

- (void)dismissDatePicker {
    if (onboardingView.birthdatePicker.hidden == NO) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMMM d, y"];
        NSString *dateString = [dateFormatter stringFromDate:onboardingView.birthdatePicker.date];
        onboardingView.dateField.text = dateString;
        
        
        [UIView animateWithDuration:0.3 animations:^{
            onboardingView.birthdatePicker.frame = CGRectMake(0,self.view.frame.size.height,onboardingView.birthdatePicker.frame.size.width,onboardingView.birthdatePicker.frame.size.height);
        } completion:^(BOOL finished) {
            onboardingView.birthdatePicker.hidden = YES;
            [self validateForm];
        }];
    }
}

- (void)dismissKeyboard {
    [onboardingView.nameField resignFirstResponder];
}

@end
