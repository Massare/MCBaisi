//
//  MCPushGuideView.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/12.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCPushGuideView.h"


@implementation MCPushGuideView

+ (void)showPushGuidView{
    
    NSString *key = @"CFBundleShortVersionString";
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中存储的版本号
    NSString *sandboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![currentVersion isEqualToString:sandboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        MCPushGuideView *view = [MCPushGuideView viewFromXib];
        view.frame = window.bounds;
        [window addSubview:view];
    }
    // 存储版本号
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


- (IBAction)closeButtonClick:(id)sender {
    [self removeFromSuperview];
}

@end
