//
//  MCAlertController.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/11.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCAlertController.h"

@interface MCAlertController ()

@end

@implementation MCAlertController


- (instancetype)init
{
    if (self = [super init]) {
        UIAlertAction *collectAction = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [collectAction setValue:[UIColor brownColor] forKey:@"titleTextColor"];
        UIAlertAction *reportAction = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [reportAction setValue:[UIColor brownColor] forKey:@"titleTextColor"];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [cancelAction setValue:[UIColor brownColor] forKey:@"titleTextColor"];
        [self addAction:collectAction];
        [self addAction:reportAction];
        [self addAction:cancelAction];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}




@end
