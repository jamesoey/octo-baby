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
    NSString *name = onboardingView.nameField.text;
    Project *project = [SflyData project];
    project.name = name;
    
    MainViewController *mvController = [[MainViewController alloc] initWithProject:project];
    [self presentViewController:mvController animated:YES completion:nil];
}

@end
