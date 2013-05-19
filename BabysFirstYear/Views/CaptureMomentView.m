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
#import "SflyUtility.h"
#import <QuartzCore/QuartzCore.h>

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

    self.topLine = [SflyUtility horizLineAtY:44+30+282+30];
    self.botLine = [SflyUtility horizLineAtY:44+30+282+30+10+44+10];
    [self addSubview:self.topLine];
    [self addSubview:self.botLine];
    
    TopBarView *topBarView = [[TopBarView alloc] init];
    [self addSubview:topBarView];
    self.backButton = topBarView.iconMenuButton;
    
    UIImage *largeFrameImage = [UIImage imageNamed:@"imgPhotoFrameLarge.png"];
    self.cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cameraButton setImage:largeFrameImage forState:UIControlStateNormal];
    self.cameraButton.frame = CGRectMake((320-280)/2.0, 74, 280, 280);
    [self addSubview:self.cameraButton];

    UIImage *cameraIconImage = [UIImage imageNamed:@"iconCameraLarge.png"];
    self.cameraIcon = [[UIImageView alloc] initWithImage:cameraIconImage];
    self.cameraIcon.frame = CGRectMake((320-cameraIconImage.size.width)/2.0, 180, cameraIconImage.size.width, cameraIconImage.size.height);
    [self addSubview:self.cameraIcon];
    
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"BABY" options:0 error:nil];
    NSMutableString *mutableCap = [NSMutableString stringWithString:self.task.instruction];
    [regex replaceMatchesInString:mutableCap options:0 range:NSMakeRange(0, [mutableCap length]) withTemplate:[[SflyData project] name]];

    self.cameraLabel = [[UILabel alloc] initWithFrame:CGRectMake((320-200)/2.0, 240, 200, 80)];
    self.cameraLabel.backgroundColor = [UIColor clearColor];
    self.cameraLabel.numberOfLines = 0;
    self.cameraLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.cameraLabel.text = mutableCap;
    [self.cameraLabel setTextAlignment:NSTextAlignmentCenter];
    self.cameraLabel.textColor = UIColorFromRGB(0xA5A09D);
    [self addSubview:self.cameraLabel];
    
    //CGFloat margin = 18;
    self.previewImageView = [[UIImageView alloc] initWithFrame:CGRectMake((320-280)/2.0+18, 74+18, 280-2*18, 280-2*18)];
    self.previewImageView.hidden = YES;
    [self addSubview:self.previewImageView];
    
    UIImage *cameraRollIconImage = [UIImage imageNamed:@"iconCameraRoll.png"];
    self.cameraRollIcon = [[UIImageView alloc] initWithImage:cameraRollIconImage];
    [self.cameraRollIcon setFrame:CGRectMake(15, 44+30+282+30+10, cameraRollIconImage.size.width, cameraRollIconImage.size.height)];
    [self addSubview:self.cameraRollIcon];
    
    UIImage *forwardArrowImage = [UIImage imageNamed:@"imgForwardArrow.png"];
    self.forwardArrow = [[UIImageView alloc] initWithImage:forwardArrowImage];
    [self.forwardArrow setFrame:CGRectMake(285, 410, forwardArrowImage.size.width, forwardArrowImage.size.height)];
    [self addSubview:self.forwardArrow];

    self.cameraRollLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+44+10, 397, 200, 40)];
    self.cameraRollLabel.backgroundColor = [UIColor clearColor];
    self.cameraRollLabel.text = @"Select from camera roll";
    self.cameraRollLabel.textColor = UIColorFromRGB(0x666666);
    [self addSubview:self.cameraRollLabel];

    self.cameraRollView = [[UIView alloc] initWithFrame:CGRectMake(0, 44+30+282+30+10, 320, cameraRollIconImage.size.height)];
    [self addSubview:self.cameraRollView];
    

    UIImage *looksGreatImage = [UIImage imageNamed:@"btnLooksGreat.png"];
    self.looksGreatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.looksGreatButton setImage:looksGreatImage forState:UIControlStateNormal];
    self.looksGreatButton.frame = CGRectMake(320-40-looksGreatImage.size.width, 450, looksGreatImage.size.width, looksGreatImage.size.height);
    [self addSubview:self.looksGreatButton];
    
    UIImage *tryAgainImage = [UIImage imageNamed:@"btnTryAgain.png"];
    self.tryAgainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tryAgainButton setImage:tryAgainImage forState:UIControlStateNormal];
    self.tryAgainButton.frame = CGRectMake(40, 450, tryAgainImage.size.width, tryAgainImage.size.height);
    [self addSubview:self.tryAgainButton];

    self.taskNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 380, 240, 40)];
    self.taskNameTextField.backgroundColor = [UIColor whiteColor];
    self.taskNameTextField.layer.cornerRadius = 6.0f;
    self.taskNameTextField.layer.borderColor = [[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0] CGColor];
    self.taskNameTextField.layer.borderWidth = 1.0f;
    self.taskNameTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.taskNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self addSubview:self.taskNameTextField];
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
