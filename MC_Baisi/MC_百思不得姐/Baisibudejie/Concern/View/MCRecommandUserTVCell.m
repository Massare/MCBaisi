//
//  MCRecommandUserTVCell.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/7.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCRecommandUserTVCell.h"
#import "MCRecommandUser.h"

@interface MCRecommandUserTVCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation MCRecommandUserTVCell

- (void)awakeFromNib {
 
}

- (void)setUser:(MCRecommandUser *)user
{
    _user = user;
    self.nickNameLabel.text = user.screen_name;
    NSString *fansCount = nil;
    int count = [user.fans_count intValue];
    if (count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人关注",count];
    } else {
        fansCount = [NSString stringWithFormat:@"%.1f万人关注",count/10000.0];
    }
    self.fansCountLabel.text = fansCount;
    [self.headerImageView setHeaderWithUrl:user.header];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)concernButtonClick:(id)sender {
    
}

@end
