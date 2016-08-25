//
//  MCVerticalButton.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/6.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCVerticalButton.h"

@implementation MCVerticalButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return  self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.layer.cornerRadius = 10;
    self.imageView.layer.masksToBounds = YES;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int margin = 5;
    self.imageView.x = margin;
    self.imageView.y = 0;
    self.imageView.width = self.width - 2 * margin;
    self.imageView.height = self.imageView.width;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
}

@end
