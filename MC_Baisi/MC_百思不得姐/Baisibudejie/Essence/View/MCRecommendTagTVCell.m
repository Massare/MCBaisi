//
//  MCRecommendTagTVCell.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/11.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCRecommendTagTVCell.h"
#import "MCRecommendTag.h"
#import <UIImageView+WebCache.h>


@interface MCRecommendTagTVCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *theme_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *concernNumberLabel;

@end

@implementation MCRecommendTagTVCell

- (void)awakeFromNib {
   
}

- (void)setRecommendTag:(MCRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    self.theme_nameLabel.text = recommendTag.theme_name;
    
    NSString *number = nil;
    if (recommendTag.sub_number < 10000) {
        number = [NSString stringWithFormat:@"%zd人关注",recommendTag.sub_number];
    }else {
        number = [NSString stringWithFormat:@"%.1lf",recommendTag.sub_number/10000.0];
    }
    self.concernNumberLabel.text = number;
    [self.profileImageView setHeaderWithUrl:recommendTag.image_list];
    
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}

- (IBAction)concernButtonClick:(id)sender {
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
