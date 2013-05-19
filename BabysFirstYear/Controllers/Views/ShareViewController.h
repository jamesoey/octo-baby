//
//  ShareViewController.h
//  BabysFirstYear
//
//  Created by Ming Fu on 5/18/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface ShareViewController : UIViewController

@property (nonatomic, strong) Task *task;

- (id)initWithTask:(Task *)t;

@end
