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
    UILabel *taskLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    taskLabel.text = self.task.caption;
    [self addSubview:taskLabel];
    
    UILabel *cameraLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 200, 40)];
    cameraLabel.text = @"Take a picture with your camera";
    [self addSubview:cameraLabel];
    
    self.cameraButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.cameraButton setTitle:@"Capture" forState:UIControlStateNormal];
    self.cameraButton.frame = CGRectMake(60, 150, 150, 40);
    [self addSubview:self.cameraButton];
    
    UILabel *cameraRollLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 200, 40)];
    cameraRollLabel.text = @"Select from camera roll";
    [self addSubview:cameraRollLabel];

    self.cameraRollButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.cameraRollButton setTitle:@"Select" forState:UIControlStateNormal];
    self.cameraRollButton.frame = CGRectMake(60, 400, 150, 40);
    [self addSubview:self.cameraRollButton];
    
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
