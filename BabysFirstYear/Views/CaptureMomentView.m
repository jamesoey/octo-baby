//
//  CaptureMoment.m
//  BabysFirstYear
//
//  Created by James Oey on 5/17/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "CaptureMomentView.h"
#import "Task.h"

@implementation CaptureMomentView

- (id)initWithFrame:(CGRect)frame task:(Task*)t {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.task = t;
        [self initView];
    }
    return self;
}

- (void)initView {
    UILabel *cameraLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 200, 40)];
    cameraLabel.text = @"Take a picture with your camera";
    [self addSubview:cameraLabel];

    UILabel *cameraRollLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 200, 40)];
    cameraRollLabel.text = @"Select from camera roll";
    [self addSubview:cameraRollLabel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
