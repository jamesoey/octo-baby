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
    self.photo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"baby0.jpg"]];
    self.photo.frame = self.contentView.frame;
    [self.contentView addSubview:self.photo];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 30)];
    self.titleLabel.text = self.task.caption;
    self.titleLabel.backgroundColor = [UIColor blackColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.status = [[UILabel alloc] initWithFrame:CGRectMake(170, 0, 100, 30)];
    if (self.task.moment == nil) {
        self.status.text = @"NOT DONE";
    } else {
        self.status.text = @"DONE";
    }
    [self.contentView addSubview:self.status];
    

}

- (void)prepareForReuse {
    self.titleLabel.text = @"";
    self.status.text = @"";
}

@end
