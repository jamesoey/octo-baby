//
//  TopBarView.m
//  BabysFirstYear
//
//  Created by James Oey on 5/17/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "TopBarView.h"
#import "SflyData.h"
#import "Project.h"

@implementation TopBarView

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)];
    if (self) {
        // Initialization code
        self.title = nil;
        [self initView];
    }
    return self;
}

- (id)initWithTitle:(NSString*)title {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)];
    if (self) {
        // Initialization code
        self.title = title;
        [self initView];
    }
    return self;
}


- (void)initView {
    self.backgroundColor = UIColorFromRGB(0xA5A09D);
    
    UIImage *iconMenuImage = [UIImage imageNamed:@"iconMenu.png"];
    self.iconMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.iconMenuButton setImage:iconMenuImage forState:UIControlStateNormal];
    self.iconMenuButton.frame = CGRectMake(0, 0, iconMenuImage.size.width, iconMenuImage.size.height);
    [self addSubview:self.iconMenuButton];
    
    Project *project = [SflyData project];
    if (project) {
        NSString *titleString;
        if (self.title) {
            titleString = self.title;
        } else {
            titleString = [NSString stringWithFormat:@"%@'s 1st Year", project.name];
        }
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        titleLabel.text = titleString;
        titleLabel.backgroundColor = [UIColor clearColor];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:16.0]];
        [self addSubview:titleLabel];
    }
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
