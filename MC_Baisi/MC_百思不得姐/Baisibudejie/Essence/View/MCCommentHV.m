//
//  MCCommentHV.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/12.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCCommentHV.h"

@interface MCCommentHV ()

@property (nonatomic, strong) UILabel *label;
@end

static NSString * const identifier = @"header";
@implementation MCCommentHV

+ (instancetype)headerViewOfSectionWithTableView:(UITableView *)tableView
{
    MCCommentHV *commentHV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!commentHV) {
        commentHV = [[MCCommentHV alloc] initWithReuseIdentifier:identifier];
    }
    return commentHV;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:identifier]) {
        self.contentView.backgroundColor = MCGlobalBackgroundColor;
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:17];
        label.textColor = MCRGBAColor(67, 67, 67, 1.0);
        label.frame = CGRectMake(10, 0, 0, 0);
        label.width = 200;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        [self.contentView addSubview:label];
        self.label = label;
    }
    return  self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = title;
}

@end
