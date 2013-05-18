//
//  CaptureMoment.m
//  BabysFirstYear
//
//  Created by James Oey on 5/17/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "CaptureMomentView.h"
#import "Task.h"
#import "TopBarView.h"
#import "SflyData.h"
#import "Project.h"

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
    self.backgroundColor = UIColorFromRGB(0xEFE9E5);

    
    UIView *topBarView = [[TopBarView alloc] init];
    [self addSubview:topBarView];
   
    
    UIImage *largeFrameImage = [UIImage imageNamed:@"imgPhotoFrameLarge.png"];
    UIButton *largeFrameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [largeFrameButton setImage:largeFrameImage forState:UIControlStateNormal];
    largeFrameButton.frame = CGRectMake((320-largeFrameImage.size.width)/2.0, 74, largeFrameImage.size.width, largeFrameImage.size.height);
    [self addSubview:largeFrameButton];

    UIImage *cameraIconImage = [UIImage imageNamed:@"iconCameraLarge.png"];
    UIImageView *cameraIcon = [[UIImageView alloc] initWithImage:cameraIconImage];
    cameraIcon.frame = CGRectMake((320-cameraIconImage.size.width)/2.0, 180, cameraIconImage.size.width, cameraIconImage.size.height);
    [self addSubview:cameraIcon];
    
    NSString *cameraLabelText = [NSString stringWithFormat:@"Let's get started. Take a photo of %@ right now.", [[SflyData project] name]];
    UILabel *cameraLabel = [[UILabel alloc] initWithFrame:CGRectMake((320-200)/2.0, 240, 200, 60)];
    cameraLabel.backgroundColor = [UIColor clearColor];
    cameraLabel.numberOfLines = 0;
    cameraLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cameraLabel.text = cameraLabelText;
    [cameraLabel setTextAlignment:NSTextAlignmentCenter];
    cameraLabel.textColor = UIColorFromRGB(0xA5A09D);
    [self addSubview:cameraLabel];
    
    /*self.cameraButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.cameraButton setTitle:@"Capture" forState:UIControlStateNormal];
    self.cameraButton.frame = CGRectMake(60, 150, 150, 40);
    [self addSubview:self.cameraButton];*/
    
    //UILabel *cameraIconImage = [UIImage imageNamed:@"iconCameraRoll.png"];
    
    UILabel *cameraRollLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 400, 200, 40)];
    cameraRollLabel.backgroundColor = [UIColor clearColor];
    cameraRollLabel.text = @"Select from camera roll";
    cameraRollLabel.textColor = UIColorFromRGB(0x666666);
    [self addSubview:cameraRollLabel];

    /*self.cameraRollButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.cameraRollButton setTitle:@"Select" forState:UIControlStateNormal];
    self.cameraRollButton.frame = CGRectMake(60, 400, 150, 40);
    [self addSubview:self.cameraRollButton];*/
    
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
