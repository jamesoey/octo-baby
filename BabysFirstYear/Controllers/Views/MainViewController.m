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
#import "TopBarView.h"
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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"imgIntroTile.png"]];
    
    UIImage *love = [UIImage imageNamed:@"side_menu_love_photos.png"];
    self.loveImage = [[UIImageView alloc] initWithImage:love];
    self.loveImage.frame = CGRectMake((self.view.frame.size.width-love.size.width/2.0)/2.0,464,love.size.width/2.0, love.size.height/2.0);
    [self.view addSubview:self.loveImage];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,250,200) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.bounces = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.topBarView = [[TopBarView alloc] init];
    [self.view addSubview:self.topBarView];
    
    UIImage *cal1 = [UIImage imageNamed:@"imgCalendarWeek1.png"];
    UIImage *calBot = [UIImage imageNamed:@"imgBottomOfCalendar.png"];
    //UIImage *cal2 = [UIImage imageNamed:@"imgCalendarWeek2.png"];
    //UIImage *cal3 = [UIImage imageNamed:@"imgCalendarWeek3.png"];
    
    UIImageView *calV1 = [[UIImageView alloc] initWithImage:cal1];
    calV1.frame = CGRectMake(0,0,cal1.size.width, cal1.size.height);
    UIImageView *calVBot = [[UIImageView alloc] initWithImage:calBot];
    calVBot.frame = CGRectMake(0,cal1.size.height,calBot.size.width, calBot.size.height);
    
    self.calBar = [[UIImageView alloc] initWithFrame:CGRectMake(0,self.topBarView.frame.size.height,calBot.size.width,calBot.size.height)];
    [self.calBar addSubview:calV1];
    [self.calBar addSubview:calVBot];
    
    
    UIImage *square = [self squareWithColor:(UIColorFromRGB(0xFF3300))];
    UIImageView *sv = [[UIImageView alloc] initWithImage:square];
    sv.frame = CGRectMake(140,23,40,40);
    sv.alpha = 0.5f;
    [self.calBar addSubview:sv];
    
    [self.view addSubview:self.calBar];
    
    
    
    
    //Step 1
    //Instantiate the UIPageViewController.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    //Step 2:
    //Assign the delegate and datasource as self.
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    self.pageViewController.view.autoresizingMask = UIViewAutoresizingNone;
    
    //Step 3:
    //Set the initial view controllers.
    FullMomentViewController *contentViewController = [[FullMomentViewController alloc] initWithTask:[tasks objectAtIndex:0] andIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:contentViewController];
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    //Step 4:
    //ViewController containment steps
    //Add the pageViewController as the childViewController
    [self addChildViewController:self.pageViewController];
    
    //Call didMoveToParentViewController: of the childViewController, the UIPageViewController instance in our case.
    [self.pageViewController didMoveToParentViewController:self];
    
    //Step 5:
    // set the pageViewController's frame as an inset rect.
    //CGRect pageViewRect = self.view.bounds;
    //pageViewRect = CGRectInset(pageViewRect, 20.0, 40.0);
    
    UIImage *bookBg = [UIImage imageNamed:@"imgOpenBook.png"];
    self.bookBgView = [[UIImageView alloc] initWithImage:bookBg];
    self.bookBgView.frame = CGRectMake(-290,151,bookBg.size.width, bookBg.size.height);
    [self.view addSubview:self.bookBgView];
    
    NSLog(@"book bg %f %f", bookBg.size.width, bookBg.size.height);
    
    self.pageViewController.view.frame = CGRectMake(9,163,270,268);
    //Add the view of the pageViewController to the current view
    [self.view addSubview:self.pageViewController.view];
    
    //Step 6:
    //Assign the gestureRecognizers property of our pageViewController to our view's gestureRecognizers property.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
    self.tapView = [[UIView alloc] initWithFrame:self.pageViewController.view.frame];
    [self.view addSubview:self.tapView];
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
    [self.tapView addGestureRecognizer:tapGest];
    
    UIImage *bbar = [UIImage imageNamed:@"imgBottomToolbar.png"];
    self.bottomBar = [[UIImageView alloc] initWithImage:bbar];
    self.bottomBar.frame = CGRectMake(0,self.view.frame.size.height-bbar.size.height,bbar.size.width,bbar.size.height);
    [self.view addSubview:self.bottomBar];
    
    self.ideaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *ideas = [UIImage imageNamed:@"iconIdeas.png"];
    [self.ideaButton setImage:ideas forState:UIControlStateNormal];
    [self.ideaButton addTarget:self action:@selector(taskPopup) forControlEvents:UIControlEventTouchUpInside];
    self.ideaButton.frame = CGRectMake(15,self.bottomBar.frame.origin.y,ideas.size.width,ideas.size.height);
    [self.view addSubview:self.ideaButton];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)taskPopup {
    
    /*
    PopoverView *pv = [PopoverView showPopoverAtPoint:CGPointMake(10,400)
                                               inView:self.view
                                            withTitle:@"This Week's Moments?"
                                      withStringArray:[NSArray arrayWithObjects:@"YES", @"NO", nil]
                                             delegate:self];
    */
    
    pv = [PopoverView showPopoverAtPoint:CGPointMake(20,500) inView:self.view withContentView:self.tableView delegate:self];
    
    
}

- (UIImage *)squareWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 50, 50);
    // Create a 1 pixel line
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect); // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)tapped {
    NSLog(@"Tapped!!!");
}



#pragma mark - UIPageViewControllerDataSource Methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    FullMomentViewController *currentViewController = (FullMomentViewController*)viewController;
    int currentTaskIndex = [tasks indexOfObject:currentViewController.task];
    
    if(currentTaskIndex == 0) return nil;
    
    FullMomentViewController *contentViewController = [[FullMomentViewController alloc] initWithTask:[tasks objectAtIndex:currentTaskIndex-1] andIndex:currentTaskIndex-1];
    return contentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    FullMomentViewController *currentViewController = (FullMomentViewController*)viewController;
    int currentTaskIndex = [tasks indexOfObject:currentViewController.task];
    
    if(currentTaskIndex == [tasks count]-1) return nil;
    FullMomentViewController *contentViewController = [[FullMomentViewController alloc] initWithTask:[tasks objectAtIndex:currentTaskIndex+1] andIndex:currentTaskIndex+1];
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

    CaptureMomentViewController *cmViewController =
       [[CaptureMomentViewController alloc] initWithTask:[tasks objectAtIndex:indexPath.row]];
    [self presentViewController:cmViewController animated:YES completion:nil];
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

- (void) hideUI:(BOOL)hide {
    
    BOOL hideui = hide;
    if (!hide)
        hideui = hide || UIDeviceOrientationIsLandscape(self.interfaceOrientation);
    
    float alpha = hideui ? 0:1;
    
    self.topBarView.alpha = alpha;
    self.calBar.alpha = alpha;
    self.bottomBar.alpha = alpha;
    self.cameraButton.alpha = alpha;
    self.ideaButton.alpha = alpha;
    self.progressButton.alpha = alpha;
    self.loveImage.alpha = alpha;
    
    self.bookBgView.alpha = 1-(float)hide;
}


#pragma mark - Rotation Delegates

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [UIView setAnimationsEnabled:NO];
    FullMomentViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
    [currentViewController hideAll];
    
    [pv performSelector:@selector(dismiss) withObject:nil afterDelay:0.0f];
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.pageViewController.view.frame = CGRectMake(14,17,270*2,268);
    } else {
        self.pageViewController.view.frame = CGRectMake(9,163,270,268);
    }
    
    [self hideUI:YES];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [UIView setAnimationsEnabled:YES];
    if (fromInterfaceOrientation != UIInterfaceOrientationLandscapeLeft && fromInterfaceOrientation != UIInterfaceOrientationLandscapeRight) {
        self.bookBgView.frame = CGRectMake(-16, 5, self.bookBgView.frame.size.width, self.bookBgView.frame.size.height);
        [UIView animateWithDuration:0.7 animations:^{
            [self hideUI:NO];
            //self.pageViewController.view.frame = CGRectMake((self.view.frame.size.width-self.pageViewController.view.frame.size.width)/2.0,
            //                                                17,self.pageViewController.view.frame.size.width, self.pageViewController.view.frame.size.height);
            
        } completion:^(BOOL finished) {
        }];
    } else {
        if ((fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown || UIDeviceOrientationIsLandscape(fromInterfaceOrientation))
            && UIDeviceOrientationIsPortrait(self.interfaceOrientation))
            self.bookBgView.frame = CGRectMake(-290,151,self.bookBgView.frame.size.width, self.bookBgView.frame.size.height);
        [UIView animateWithDuration:0.7 animations:^{
            [self hideUI:NO];
        } completion:^(BOOL finished) {
        }];
    }

    
    
}

#pragma mark - ScrollView Delegates
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x > scrollView.contentSize.width-scrollView.frame.size.width) {
        scrollView.contentOffset = CGPointMake(0,0);
    }
    if (scrollView.contentOffset.x < 0) {
        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width-scrollView.frame.size.width,0);
    }
}


- (void) snapScroll;
{
    int temp = (self.scrollView.contentOffset.x+25) / 50;
    self.scrollView.contentOffset = CGPointMake(temp*50 , 0);
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    NSLog(@"ended dragging!!");
    
    //if (!decelerate) {
        [self snapScroll];
    //}
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self snapScroll];
}
*/
@end
