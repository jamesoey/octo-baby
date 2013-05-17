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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *book = [[UIImageView alloc] init];
    book.frame = CGRectMake(0,0,250,350);
    book.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:book];
    
    self.photo = [[UIImageView alloc] init];
    self.photo.backgroundColor = [UIColor redColor];
    self.photo.frame = CGRectMake(25,25,200,300);
    [self.view addSubview:self.photo];
    
    [[AssetsLibraryController sharedController] imageForURL:task.moment.uid success:^(UIImage *image) {
        self.photo.image = image;
    } failureBlock:^(NSError *error) {
        NSLog(@"ERROR: Cannot add image to FMV image view");
    }];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
