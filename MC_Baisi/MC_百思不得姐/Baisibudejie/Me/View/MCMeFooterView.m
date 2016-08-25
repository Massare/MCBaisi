//
//  MCMeFooterView.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/14.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCMeFooterView.h"
#import "MCSquare.h"
#import "MCSquareButton.h"
#import "MCWebVC.h"
#import <AFNetworking.h>
#import <MJExtension.h>

@implementation MCMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        // 发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            NSArray *sqaures = [MCSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
           MCLog(@"---- %zd",sqaures.count);
            
            // 创建方块
            [self createSquares:sqaures];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
    return self;
}

- (void)createSquares:(NSArray *)squares {

    NSInteger columns = 4;
    CGFloat buttonW = MCScreenWidth / columns;
    CGFloat buttonH = buttonW;
    
    for (int i = 0;  i < squares.count; i++) {
        MCSquareButton *squareButton = [[MCSquareButton alloc] init];
        CGFloat buttonX = buttonW * (i % 4);
        CGFloat buttonY = buttonH * (i / 4);
        squareButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [self addSubview:squareButton];
        
        squareButton.square = squares[i];
        [squareButton addTarget:self action:@selector(squareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    NSInteger last = !(squares.count % columns == 0) ? 1 : 0;
    self.height = ((squares.count / columns) + last) * buttonH;
    
    
//    UITableView *tableView = (UITableView *)self.superview;
//    tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.frame));

//    [self setNeedsDisplay];
}

- (void)squareButtonClick:(MCSquareButton *)button {
    
    if (![button.square.url hasPrefix:@"http"]) return;
    
    MCWebVC *webVC = [[MCWebVC alloc] init];

    webVC.url = button.square.url;
    webVC.title = button.square.name;
    
    UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *navigationController = (UINavigationController *)tabBarController.selectedViewController;
    [navigationController pushViewController:webVC animated:YES];
}



@end
