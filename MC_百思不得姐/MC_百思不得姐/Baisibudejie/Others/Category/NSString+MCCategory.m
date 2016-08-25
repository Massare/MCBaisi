//
//  NSString+MCCategory.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/15.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "NSString+MCCategory.h"
#import <CoreMedia/CoreMedia.h>
#import <CoreFoundation/CoreFoundation.h>

@implementation NSString (MCCategory)

+ (NSString *)timeFormatWithTimeString:(NSString *)time
{
    NSInteger total = [time integerValue];
    NSInteger mins = total / 60;
    NSInteger secs = total % 60;
    
    if (total < 600) {
        return [NSString stringWithFormat:@"%02zd:%02zd",mins,secs];
    }else {
        return [NSString stringWithFormat:@"%03zd:%02zd",mins,secs];
    }
}

+ (NSString *)timeFormatWithTimeInterval:(NSTimeInterval)time
{
    NSInteger mins = time / 60;
    NSInteger secs = (NSInteger)time % 60;
    if (time < 600) {
        return [NSString stringWithFormat:@"%02zd:%02zd",mins,secs];
    }else {
        return [NSString stringWithFormat:@"%03zd:%02zd",mins,secs];
    }
}

+ (NSString *)timeFormatWithTime:(NSInteger)time
{
    NSInteger mins = time / 60;
    NSInteger secs = time % 60;
    
    if (time < 600) {
        return [NSString stringWithFormat:@"%02zd:%02zd",mins,secs];
    }else {
        return [NSString stringWithFormat:@"%03zd:%02zd",mins,secs];
    }
}

@end
