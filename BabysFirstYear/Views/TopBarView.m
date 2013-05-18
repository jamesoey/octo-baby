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
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = UIColorFromRGB(0xA5A09D);
    
    UIImage *iconMenuImage = [UIImage imageNamed:@"iconMenu.png"];
    UIImageView *iconMenu = [[UIImageView alloc] initWithImage:iconMenuImage];
    [iconMenu setFrame:CGRectMake(0, 0, iconMenuImage.size.width, iconMenuImage.size.height)];
    [self addSubview:iconMenu];
    
    Project *project = [SflyData project];
    if (project) {
        NSString *titleString = [NSString stringWithFormat:@"%@'s 1st Year", project.name];
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
