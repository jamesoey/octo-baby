//
//  MainViewController.m
//  BabysFirstYear
//
//  Created by James Oey on 5/16/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "MainViewController.h"
#import "Project.h"
#import "MainView.h"
#import "TaskTableViewCell.h"
#import "SflyData.h"
#import "CaptureMomentViewController.h"
#import "FullMomentViewController.h"
#import "Task.h"
#import "Moment.h"
#import "FullMomentViewController.h"

@interface MainViewController () {
    Project *project;
    MainView *mainView;
    NSArray *tasks;
}
@end

@implementation MainViewController

- (id)initWithProject:(Project*)p {
    self = [super init];
    if (self) {
        project = p;
        NSSortDescriptor *weekSort = [[NSSortDescriptor alloc] initWithKey:@"weeksFromStart" ascending:YES];
        tasks = [project.tasks sortedArrayUsingDescriptors:@[weekSort]];
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

/*
- (void) loadView {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    mainView = [[MainView alloc] initWithFrame:bounds project:project];
    
    self.view = mainView;
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    
    //Step 1
    //Instantiate the UIPageViewController.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    //Step 2:
    //Assign the delegate and datasource as self.
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    //Step 3:
    //Set the initial view controllers.
    FullMomentViewController *contentViewController = [[FullMomentViewController alloc] initWithTask:[tasks objectAtIndex:0]];
    NSArray *viewControllers = [NSArray arrayWithObject:contentViewController];
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    //Step 4:
    //ViewController containment steps
    //Add the pageViewController as the childViewController
    [self addChildViewController:self.pageViewController];
    
    //Add the view of the pageViewController to the current view
    [self.view addSubview:self.pageViewController.view];
    
    //Call didMoveToParentViewController: of the childViewController, the UIPageViewController instance in our case.
    [self.pageViewController didMoveToParentViewController:self];
    
    //Step 5:
    // set the pageViewController's frame as an inset rect.
    CGRect pageViewRect = self.view.bounds;
    pageViewRect = CGRectInset(pageViewRect, 20.0, 40.0);
    self.pageViewController.view.frame = pageViewRect;
    
    //Step 6:
    //Assign the gestureRecognizers property of our pageViewController to our view's gestureRecognizers property.
    //self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewControllerDataSource Methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    FullMomentViewController *currentViewController = (FullMomentViewController*)viewController;
    int currentTaskIndex = [tasks indexOfObject:currentViewController.task];
    
    if(currentTaskIndex == 0) return nil;
    
    FullMomentViewController *contentViewController = [[FullMomentViewController alloc] initWithTask:[tasks objectAtIndex:currentTaskIndex-1]];
    return contentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    FullMomentViewController *currentViewController = (FullMomentViewController*)viewController;
    int currentTaskIndex = [tasks indexOfObject:currentViewController.task];
    
    if(currentTaskIndex == [tasks count]-1) return nil;
    FullMomentViewController *contentViewController = [[FullMomentViewController alloc] initWithTask:[tasks objectAtIndex:currentTaskIndex+1]];
    return contentViewController;
}

#pragma mark - UIPageViewControllerDelegate Methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController
                   spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if(UIInterfaceOrientationIsPortrait(orientation))
    {
        //Set the array with only 1 view controller
        UIViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
        NSArray *viewControllers = [NSArray arrayWithObject:currentViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        //Important- Set the doubleSided property to NO.
        self.pageViewController.doubleSided = NO;
        //Return the spine location
        return UIPageViewControllerSpineLocationMin;
    }
    else
    {
        NSArray *viewControllers = nil;
        self.pageViewController.doubleSided = YES;
        FullMomentViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
        
        int currentTaskIndex = [tasks indexOfObject:currentViewController.task];
        if(currentTaskIndex == 0 || currentTaskIndex %2 == 0)
        {
            UIViewController *nextViewController = [self pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
            viewControllers = [NSArray arrayWithObjects:currentViewController, nextViewController, nil];
        }
        else
        {
            UIViewController *previousViewController = [self pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
            viewControllers = [NSArray arrayWithObjects:previousViewController, currentViewController, nil];
        }
        //Now, set the viewControllers property of UIPageViewController
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        return UIPageViewControllerSpineLocationMid;
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    /*
    if (completed) {
        FullMomentViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
        currentTaskIndex = [tasks indexOfObject:currentViewController.task];
        NSLog(@"current index = %d", currentTaskIndex);
    }
    */
}


@end
