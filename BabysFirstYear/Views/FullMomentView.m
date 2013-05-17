//
//  FullMomentView.m
//  BabysFirstYear
//
//  Created by James Oey on 5/17/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "FullMomentView.h"
#import "Task.h"
#import "AssetsLibraryController.h"

@implementation FullMomentView

- (id)initWithFrame:(CGRect)frame task:(Task*)t {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.task = t;
        [self initView];
    }
    return self;
}


- (void)initView {
    CGRect bounds = [[UIScreen mainScreen] bounds];

    UIImageView *momentImageView = [[UIImageView alloc] initWithFrame:bounds];
    [self addSubview:momentImageView];
    
    NSString *uid = self.task.moment.uid;
    
    [[AssetsLibraryController sharedController] imageForURL:self.task.moment.uid success:^(UIImage *image) {
        momentImageView.image = image;
    } failureBlock:^(NSError *error) {
        NSLog(@"ERROR: Cannot add image to FMV image view");
        }];
    
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
