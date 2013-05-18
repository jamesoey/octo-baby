//
//  OnboardingView.m
//  BabysFirstYear
//
//  Created by James Oey on 5/16/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "OnboardingView.h"
#import "Project.h"

@implementation OnboardingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

- (UIImage*)doubleLine {
    //top line
    //E0DBD7
    //FFFFFF
    CGRect rect = CGRectMake(0, 0, 280, 2);

    UIColor *color0 = UIColorFromRGB(0xE0DBD7);
    CGRect rect0 = CGRectMake(0, 0, 280, 1);

    UIColor *color1 = UIColorFromRGB(0xFFFFFF);
    CGRect rect1 = CGRectMake(0, 1, 280, 1);

    // Create a 1 pixel line
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color0 setFill];
    UIRectFill(rect0); // Fill it with your color
    [color1 setFill];
    UIRectFill(rect1); // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
    
}

- (void)addLineAtY:(CGFloat)y {
    UIImage *dLine = [self doubleLine];
    UIImageView *iView = [[UIImageView alloc] initWithImage:dLine];
    iView.frame = CGRectMake(20, y, dLine.size.width, dLine.size.height);
    [self addSubview:iView];
}

- (void)initView {
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"imgIntroTile.png"]]];
    
    [self addLineAtY:55];
    [self addLineAtY:185];
    [self addLineAtY:400];
    
    
    UIImage *shutterflyTitleImage = [UIImage imageNamed:@"imgSflyLogo.png"];
    UIImageView *shutterflyTitle = [[UIImageView alloc] initWithImage:shutterflyTitleImage];
    [shutterflyTitle setFrame:CGRectMake((320-shutterflyTitleImage.size.width)/2.0, 20, shutterflyTitleImage.size.width, shutterflyTitleImage.size.height)];
    [self addSubview:shutterflyTitle];
    
    UIImage *introMessageImage = [UIImage imageNamed:@"imgIntroMessage.png"];
    UIImageView *introMessage = [[UIImageView alloc] initWithImage:introMessageImage];
    [introMessage setFrame:CGRectMake((320-introMessageImage.size.width)/2.0, 80, introMessageImage.size.width, introMessageImage.size.height)];
    [self addSubview:introMessage];
    
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 220, 280, 30)];
    [self.nameField setBackgroundColor:[UIColor whiteColor]];
    self.nameField.placeholder = @"Baby's First Name";
    self.nameField.textColor = UIColorFromRGB(0x999999);
    [self addSubview: self.nameField];

    self.dateField = [[UITextField alloc] initWithFrame:CGRectMake(20, 270, 280, 30)];
    [self.dateField setBackgroundColor:[UIColor whiteColor]];
    self.dateField.placeholder = @"Baby's Birthdate";
    self.dateField.textColor = UIColorFromRGB(0x999999);
    [self addSubview: self.dateField];

    
    CGFloat genderY = 340;
    UIImage *genderDisabled = [UIImage imageNamed:@"imgGenderRadial.png"];
    UIImage *boyImage = [UIImage imageNamed:@"imgBoySelection.png"];
    UIImage *girlImage = [UIImage imageNamed:@"imgGirlSelection.png"];
    
    self.girlButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.girlButton setImage:genderDisabled forState:UIControlStateNormal];
    [self.girlButton setImage:girlImage forState:UIControlStateSelected];
    [self.girlButton setFrame:CGRectMake(60, genderY, genderDisabled.size.width, genderDisabled.size.height)];
    [self addSubview:self.girlButton];
    
    UILabel *girlText = [[UILabel alloc] initWithFrame:CGRectMake(110, genderY, 80, 40)];
    girlText.text = @"Girl";
    girlText.backgroundColor = [UIColor clearColor];
    girlText.textColor = UIColorFromRGB(0x666666);
    [self addSubview:girlText];
    
    self.boyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.boyButton setImage:genderDisabled forState:UIControlStateNormal];
    [self.boyButton setImage:boyImage forState:UIControlStateSelected];
    [self.boyButton setFrame:CGRectMake(170, genderY, genderDisabled.size.width, genderDisabled.size.height)];
    [self addSubview:self.boyButton];
    
    UILabel *boyText = [[UILabel alloc] initWithFrame:CGRectMake(220, genderY, 80, 40)];
    boyText.text = @"Boy";
    boyText.backgroundColor = [UIColor clearColor];
    boyText.textColor = UIColorFromRGB(0x666666);
    [self addSubview:boyText];
    
    
    UIImage *btnBeginImage = [UIImage imageNamed:@"btnBegin"];
    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.submitButton setImage:btnBeginImage forState:UIControlStateNormal];
    [self.submitButton setFrame:CGRectMake((320-btnBeginImage.size.width)/2.0, 440, btnBeginImage.size.width, btnBeginImage.size.height)];
    self.submitButton.alpha = 0.4;
    [self addSubview:self.submitButton];
    
    self.birthdatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-250, 320, 250)];
    self.birthdatePicker.datePickerMode = UIDatePickerModeDate;
    self.birthdatePicker.hidden = YES;
    [self addSubview:self.birthdatePicker];

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
