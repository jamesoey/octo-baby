//
//  MainView.m
//  BabysFirstYear
//
//  Created by James Oey on 5/16/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "MainView.h"
#import "Project.h"

@implementation MainView

- (id)initWithFrame:(CGRect)frame project:(Project*)p {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.project = p;
        [self initView];
    }
    return self;
}

- (void)initView {
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 200, 40)];
    nameLabel.text = self.project.name;
    [self addSubview:nameLabel];
    
    self.taskTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 70, 280, 400)];
    [self addSubview:self.taskTableView];
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
