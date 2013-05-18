//
//  MainViewController.h
//  BabysFirstYear
//
//  Created by James Oey on 5/16/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverView.h"
#import "TopBarView.h"

@class Project;

@interface MainViewController : UIViewController<UIPageViewControllerDelegate,UIPageViewControllerDataSource,PopoverViewDelegate,UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *bookBgView;
@property (nonatomic, strong) UIView *tapView;
@property (nonatomic, strong) TopBarView *topBarView;
@property (nonatomic, strong) UIImageView *bottomBar;
@property (nonatomic, strong) UIButton *ideaButton;
@property (nonatomic, strong) UIButton *cameraButton;
@property (nonatomic, strong) UIButton *progressButton;
@property (nonatomic, strong) UIImageView *loveImage;
@property (nonatomic, strong) UIImageView *calBar;

- (id)initWithProject:(Project*)p;

@end
