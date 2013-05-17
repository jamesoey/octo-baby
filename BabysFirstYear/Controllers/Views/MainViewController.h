//
//  MainViewController.h
//  BabysFirstYear
//
//  Created by James Oey on 5/16/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Project;

@interface MainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

- (id)initWithProject:(Project*)p;

@end
