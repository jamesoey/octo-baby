//
//  OnboardingView.h
//  BabysFirstYear
//
//  Created by James Oey on 5/16/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnboardingView : UIView

@property (nonatomic, retain) UITextField *nameField;
@property (nonatomic, retain) UITextField *dateField;
@property (nonatomic, retain) UIButton *submitButton;
@property (nonatomic, retain) UIButton *girlButton;
@property (nonatomic, retain) UIButton *boyButton;
@property (nonatomic, retain) UIDatePicker *birthdatePicker;
@end
