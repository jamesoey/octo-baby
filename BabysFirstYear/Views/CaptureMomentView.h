//
//  CaptureMoment.h
//  BabysFirstYear
//
//  Created by James Oey on 5/17/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Task;

@interface CaptureMomentView : UIView

@property (nonatomic, retain) Task *task;

- (id)initWithFrame:(CGRect)frame task:(Task*)t;

@end
