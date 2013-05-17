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


- (void)initView {
    
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 40)];
    nameLabel.text = @"Baby's Name";
    [self addSubview:nameLabel];
    self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(120, 20, 200, 40)];
    [self.nameField setBackgroundColor:[UIColor whiteColor]];
    [self addSubview: self.nameField];
    self.submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.submitButton setTitle:@"Start!" forState:UIControlStateNormal];
    [self.submitButton setFrame:CGRectMake(100, 100, 120, 40)];
    [self addSubview:self.submitButton];

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
