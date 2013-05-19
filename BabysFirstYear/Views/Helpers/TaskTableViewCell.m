//
//  TaskTableViewCell.m
//  BabysFirstYear
//
//  Created by James Oey on 5/16/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "TaskTableViewCell.h"
#import "Task.h"

@implementation TaskTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithTask:(Task*)t {
    self.task = t;
    [self initializeView];
}

- (void)initializeView {
    
    self.contentView.frame = CGRectMake(0,0,360, 90);
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 30)];
    self.titleLabel.text = self.task.caption;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.titleLabel];
    
    UIImage *a = [UIImage imageNamed:@"disclosure.png"];
    self.arrow = [[UIImageView alloc] initWithImage:a];
    self.arrow.frame = CGRectMake(230,15,a.size.width,a.size.height);
    [self.contentView addSubview:self.arrow];
}

- (void)prepareForReuse {
    self.titleLabel.text = @"";
    self.status.text = @"";
    [self.titleLabel removeFromSuperview];
    [self.arrow removeFromSuperview];
}

@end
