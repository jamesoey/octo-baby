//
//  RewardsView.h
//  BabysFirstYear
//
//  Created by James Oey on 5/19/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RewardsView : UIView

@property (nonatomic, retain) UIButton *backButton;
@property int mode;

- (id)initWithFrame:(CGRect)frame mode:(int)mode;

@end
