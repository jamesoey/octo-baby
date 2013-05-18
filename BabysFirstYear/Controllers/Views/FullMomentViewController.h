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
@property (nonatomic, strong) UIImageView *bg;
@property (nonatomic, strong) UIImageView *spine;
@property int index;

- (id)initWithTask:(Task*)t andIndex:(int)index;
- (void)refreshPhoto;
- (void)hideAll;

@end
