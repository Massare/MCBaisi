//
//  MCProgressView.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/10.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCProgressView.h"

@implementation MCProgressView

- (void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    NSString *text = [NSString stringWithFormat:@"%.1f",100*progress];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
