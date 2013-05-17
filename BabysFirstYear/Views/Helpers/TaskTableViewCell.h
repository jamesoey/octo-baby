//
//  TaskTableViewCell.h
//  BabysFirstYear
//
//  Created by James Oey on 5/16/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Task;

@interface TaskTableViewCell : UITableViewCell

@property (nonatomic, retain) Task *task;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *status;
@property (nonatomic, retain) UIImageView *photo;

- (void)updateWithTask:(Task*)t;

@end
