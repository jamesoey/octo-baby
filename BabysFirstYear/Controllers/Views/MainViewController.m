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
#import "PopoverView.h"
#import <QuartzCore/QuartzCore.h>

@interface MainViewController () {
    Project *project;
    MainView *mainView;
    NSArray *tasks;
    PopoverView *pv;
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
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,250,200) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.bounces = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,300,70)];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(1000, 100);
    
    [self.view addSubview:self.scrollView];
    
    
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
    
    
    [self.view addSubview:self.scrollView];
    
    //Call didMoveToParentViewController: of the childViewController, the UIPageViewController instance in our case.
    [self.pageViewController didMoveToParentViewController:self];
    
    //Step 5:
    // set the pageViewController's frame as an inset rect.
    CGRect pageViewRect = self.view.bounds;
    pageViewRect = CGRectInset(pageViewRect, 20.0, 40.0);
    self.pageViewController.view.frame = pageViewRect;
    
    UIButton *temp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    temp.frame = CGRectMake(0,400, 50,50);
    [temp addTarget:self action:@selector(tempButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:temp];
    
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

- (void)tempButton {
    
    /*
    PopoverView *pv = [PopoverView showPopoverAtPoint:CGPointMake(10,400)
                                               inView:self.view
                                            withTitle:@"This Week's Moments?"
                                      withStringArray:[NSArray arrayWithObjects:@"YES", @"NO", nil]
                                             delegate:self];
    */
    
    pv = [PopoverView showPopoverAtPoint:CGPointMake(10,400) inView:self.view withContentView:self.tableView delegate:self];
    
    
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


#pragma mark - PopoverViewDelegate Methods

- (void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%s item:%d", __PRETTY_FUNCTION__, index);
    
    // Figure out which string was selected, store in "string"
    NSString *string = [[NSArray arrayWithObjects:@"YES", @"NO", nil] objectAtIndex:index];
    
    // Show a success image, with the string from the array
    [popoverView showImage:[UIImage imageNamed:@"success"] withMessage:string];
    
    // alternatively, you can use
    // [popoverView showSuccess];
    // or
    // [popoverView showError];
    
    // Dismiss the PopoverView after 0.5 seconds
    [popoverView performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
}

- (void)popoverViewDidDismiss:(PopoverView *)popoverView
{
    //[pv release], pv = nil;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"This Week's Moments";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskTableViewCell"];
    if (!cell) {
        cell = [[TaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskTableViewCell"];
    }
    
    [cell updateWithTask:[tasks objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    [pv performSelector:@selector(dismiss) withObject:nil afterDelay:0.0f];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 40)];
    headerView.layer.cornerRadius = 6.0f;
    headerView.clipsToBounds = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 40)];
    label.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    label.backgroundColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    [headerView addSubview:label];
    return headerView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}


#pragma mark - Rotation Delegates
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [pv performSelector:@selector(dismiss) withObject:nil afterDelay:0.0f];
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.scrollView.hidden = YES;
    } else {
        self.scrollView.hidden = NO;
    }
}

#pragma mark - ScrollView Delegates

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > scrollView.contentSize.width-scrollView.frame.size.width) {
        scrollView.contentOffset = CGPointMake(0,0);
    }
    if (scrollView.contentOffset.x < 0) {
        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width-scrollView.frame.size.width,0);
    }
    
}


@end
