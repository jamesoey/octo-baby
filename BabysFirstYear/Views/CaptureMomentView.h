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
@property (nonatomic, retain) UIButton *cameraButton;
@property (nonatomic, retain) UIButton *cameraRollButton;
@property (nonatomic, retain) UIView *cameraRollView;

@property (nonatomic, retain) UIButton *looksGreatButton;
@property (nonatomic, retain) UIButton *tryAgainButton;

@property (nonatomic, retain) UIView *topLine;
@property (nonatomic, retain) UIView *botLine;

@property (nonatomic, retain) UILabel *cameraRollLabel;
@property (nonatomic, retain) UIImageView *cameraRollIcon;
@property (nonatomic, retain) UIImageView *forwardArrow;

@property (nonatomic, retain) UIButton *backButton;

@property (nonatomic, retain) UIImageView *previewImageView;
@property (nonatomic, retain) UIImageView *cameraIcon;
@property (nonatomic, retain) UILabel *cameraLabel;

@property (nonatomic, retain) UITextField *taskNameTextField;

- (id)initWithFrame:(CGRect)frame task:(Task*)t;

@end
