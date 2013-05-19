//
//  RewardsViewController.m
//  BabysFirstYear
//
//  Created by James Oey on 5/19/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "RewardsViewController.h"
#import "RewardsView.h"

@interface RewardsViewController () {
    RewardsView *rewardsView;
}
@end

@implementation RewardsViewController

- (id)initWithMode:(int)mode {
    self = [super init];
    if (self) {
        self.mode = mode;
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

- (void)loadView {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    rewardsView = [[RewardsView alloc] initWithFrame:bounds mode:self.mode];

    [rewardsView.backButton addTarget:self action:@selector(touchedBackButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = rewardsView;

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


- (void)touchedBackButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
