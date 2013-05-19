//
//  RewardsView.m
//  BabysFirstYear
//
//  Created by James Oey on 5/19/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "RewardsView.h"
#import "TopBarView.h"

@implementation RewardsView

- (id)initWithFrame:(CGRect)frame mode:(int)mode
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.mode = mode;
        [self initView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)initView {
    self.backgroundColor = UIColorFromRGB(0xEFE9E5);
    
    TopBarView *topBarView = [[TopBarView alloc] initWithTitle:@"Rewards"];
    [self addSubview:topBarView];
    self.backButton = topBarView.iconMenuButton;
    
    UILabel *rewardLabel0 = [[UILabel alloc] initWithFrame:CGRectMake(100, 440, 230, 40)];
    rewardLabel0.text = @"20 free prints";
    rewardLabel0.textColor = UIColorFromRGB(0x666666);
    rewardLabel0.backgroundColor = [UIColor clearColor];
    [self addSubview:rewardLabel0];

    UILabel *rewardLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 380, 230, 40)];
    rewardLabel1.text = @"40% off a case of diapers";
    rewardLabel1.textColor = UIColorFromRGB(0x666666);
    rewardLabel1.backgroundColor = [UIColor clearColor];
    [self addSubview:rewardLabel1];

    UILabel *rewardLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 320, 230, 40)];
    rewardLabel2.text = @"1 Free Photo Magnet";
    rewardLabel2.textColor = UIColorFromRGB(0x666666);
    rewardLabel2.backgroundColor = [UIColor clearColor];
    [self addSubview:rewardLabel2];

    UILabel *rewardLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(100, 225, 230, 40)];
    rewardLabel3.text = @"$20 off a Photo Book";
    rewardLabel3.textColor = UIColorFromRGB(0x666666);
    rewardLabel3.backgroundColor = [UIColor clearColor];
    [self addSubview:rewardLabel3];

    UILabel *rewardLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(100, 130, 230, 40)];
    rewardLabel4.text = @"60% off a Photo Book";
    rewardLabel4.textColor = UIColorFromRGB(0x666666);
    rewardLabel4.backgroundColor = [UIColor clearColor];
    [self addSubview:rewardLabel4];
    
    UILabel *currentRewardLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 160, 40)];
    if (self.mode == 0) {
        currentRewardLabel.text = @"Get 40% off a case of diapers";
    } else if (self.mode == 1) {
        currentRewardLabel.text = @"Save $10 on your next Baby Gap Purchase";
    } else if (self.mode == 2) {
        currentRewardLabel.text = @"Order your 20 page baby book!";
    }
    currentRewardLabel.backgroundColor = [UIColor clearColor];
    currentRewardLabel.numberOfLines = 0;
    currentRewardLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [currentRewardLabel setTextAlignment:NSTextAlignmentRight];
    currentRewardLabel.textColor = UIColorFromRGB(0x666666);
    [self addSubview:currentRewardLabel];
    
    UIButton *rewardsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rewardsButton setFrame:CGRectMake(200, 60, 100, 40)];
    if (self.mode == 0) {
        [rewardsButton setTitle:@"Get Coupon" forState:UIControlStateNormal];
    } else if (self.mode == 1) {
        [rewardsButton setTitle:@"Get Coupon" forState:UIControlStateNormal];
    } else if (self.mode == 2) {
        [rewardsButton setTitle:@"Order Book" forState:UIControlStateNormal];
    }
    [self addSubview:rewardsButton];
    
    UIImage *barImage;
    if (self.mode == 0 || self.mode == 1) {
        barImage = [UIImage imageNamed:@"bar19.png"];
    } else {
        barImage = [UIImage imageNamed:@"bar20.png"];
    }
    UIImageView *barView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 130, barImage.size.width, barImage.size.height)];
    barView.image = barImage;
    [self addSubview:barView];

}
@end
