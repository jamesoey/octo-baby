//
//  FullMomentViewController.m
//  BabysFirstYear
//
//  Created by James Oey on 5/17/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "FullMomentViewController.h"
#import "FullMomentView.h"

@interface FullMomentViewController () {
    Task *task;
    FullMomentView *fullMomentView;
}
@end

@implementation FullMomentViewController

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
    fullMomentView = [[FullMomentView alloc] initWithFrame:bounds task:task];
    
    self.view = fullMomentView;
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
