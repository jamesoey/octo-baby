//
//  MainViewController.h
//  BabysFirstYear
//
//  Created by James Oey on 5/16/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverView.h"

@class Project;

@interface MainViewController : UIViewController<UIPageViewControllerDelegate,UIPageViewControllerDataSource,PopoverViewDelegate,UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;

- (id)initWithProject:(Project*)p;

@end
