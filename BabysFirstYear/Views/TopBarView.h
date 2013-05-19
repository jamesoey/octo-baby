//
//  TopBarView.h
//  BabysFirstYear
//
//  Created by James Oey on 5/17/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopBarView : UIView

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIButton *iconMenuButton;

- (id)initWithTitle:(NSString*)title;

@end
