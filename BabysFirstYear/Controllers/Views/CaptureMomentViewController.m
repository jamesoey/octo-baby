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

@interface CaptureMomentViewController () {
    Task *task;
    CaptureMomentView *captureMomentView;
}
@end

@implementation CaptureMomentViewController

- (id)initWithTask:(Task*)t {
    self = [super init];
    if (self) {
        task = t;
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

@end
