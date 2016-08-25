//
//  UIImageView+MCCategory.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/7.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "UIImageView+MCCategory.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (MCCategory)

- (void)setHeaderWithUrl:(NSString *)url
{
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];
}

@end
