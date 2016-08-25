//
//  MCConcernViewController.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/5.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCConcernViewController.h"
#import "MCRecommendViewController.h"
#import "MCLoginRegisterViewController.h"

@interface MCConcernViewController ()


@end

@implementation MCConcernViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MCGlobalBackgroundColor;

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightedImage:@"friendsRecommentIcon-click" target:self action:@selector(recommendButtonClick)];
}

- (void)recommendButtonClick
{
    MCRecommendViewController *recommendVC = [[MCRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommendVC animated:YES];
}

- (IBAction)loginRegisterButtonClick:(UIButton *)sender {
    MCLoginRegisterViewController *logVC = [[MCLoginRegisterViewController alloc] init];
    [self.navigationController presentViewController:logVC animated:YES completion:nil];
}

@end
