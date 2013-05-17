//
//  FullMomentViewController.h
//  BabysFirstYear
//
//  Created by James Oey on 5/17/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Task;

@interface FullMomentViewController : UIViewController

@property (nonatomic, strong) Task *task;
@property (nonatomic, strong) UIImageView *photo;

- (id)initWithTask:(Task*)t;

@end
