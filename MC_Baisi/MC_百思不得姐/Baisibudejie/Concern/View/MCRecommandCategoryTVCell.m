//
//  MCRecommandCategoryTVCell.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/7.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCRecommandCategoryTVCell.h"

@interface MCRecommandCategoryTVCell ()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicatorView;
@end

@implementation MCRecommandCategoryTVCell

- (void)awakeFromNib {
    self.backgroundColor = MCRGBAColor(244, 244, 244, 1.0);
    self.selectedIndicatorView.backgroundColor = MCRGBAColor(219, 21, 26, 1.0);
}

- (void)setCategory:(MCRecommandCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.height - 2 * self.textLabel.y;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedIndicatorView.hidden = !selected;
    self.backgroundColor = selected? [UIColor whiteColor] : MCRGBAColor(244, 244, 244, 1.0);
    self.textLabel.textColor = selected ? self.selectedIndicatorView.backgroundColor : MCRGBAColor(78, 78, 78, 1.0);
}

@end
