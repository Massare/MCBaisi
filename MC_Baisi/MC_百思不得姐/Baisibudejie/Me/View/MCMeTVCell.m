//
//  MCMeTVCell.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/14.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCMeTVCell.h"

@implementation MCMeTVCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupCell];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCell];
    }
    return self;
}



- (void)setupCell {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = imageView;
    
    self.textLabel.textColor = [UIColor darkGrayColor];
    self.textLabel.font = [UIFont systemFontOfSize:16];
}

- (void)awakeFromNib {
    [self setupCell];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.image == nil) return;
    
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height * 0.5;
   
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + MCTopicCellMargin;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
