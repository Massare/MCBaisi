//
//  MCPublishVC.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/13.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCPublishVC.h"
#import <POP.h>

@interface MCPublishVC ()

@end

static CGFloat const MCAnimationDelay = 0.1;
static CGFloat const MCAnimationFactor = 10;

@implementation MCPublishVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化视图和视图动画
    [self setupViewAndAnimation];
    
}

- (void)setupViewAndAnimation {
    self.view.userInteractionEnabled = NO;
    // 数据
    NSArray *imageArray = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titleArray = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    int columns = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat margin = 20;
    CGFloat space = (MCScreenWidth - 2 * margin - 3 * buttonW) / (columns - 1);
    CGFloat buttonInitY = MCScreenHeight * 0.5 - buttonH;
    
    for (int i = 0; i < titleArray.count; i++) {
        
        MCVerticalButton *button = [[MCVerticalButton alloc] init];
        int columnth = i % columns;
        int rowth = i / columns;
        CGFloat buttonX = columnth * (buttonW + space) + margin;
        CGFloat buttonEndY = buttonInitY + rowth * buttonH;
        CGFloat buttonStartY = buttonEndY - MCScreenHeight;
                button.width = buttonW;
                button.height = buttonH;
                button.x = buttonX;
                button.y = buttonStartY;
                button.tag = i;
        
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        
        [self.view addSubview:button];
        // POPBasicAnimation; POPDecayAnimation POPSpringAnimation
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.springBounciness = MCAnimationFactor;
        animation.springSpeed = MCAnimationFactor;
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonStartY, buttonW, buttonH)];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        animation.beginTime = CACurrentMediaTime() + MCAnimationDelay * i;
        [button pop_addAnimation:animation forKey:nil];
        
    }
    
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];

    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = MCScreenWidth * 0.5;
    CGFloat centerEndY = MCScreenHeight * 0.2;
    CGFloat centerBeginY = centerEndY - MCScreenHeight;
    sloganView.centerX = centerX;
    sloganView.centerY = centerBeginY;
    
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    animation.springSpeed = MCAnimationFactor;
    animation.springBounciness = MCAnimationFactor;
    animation.beginTime = CACurrentMediaTime() + imageArray.count * MCAnimationDelay;
    [animation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        self.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:animation forKey:nil];
    

    
}




- (IBAction)cancelButtonClick:(id)sender {
    
    [self cancelWithCompletionBlock:nil];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancelWithCompletionBlock:nil];
}

- (void)cancelWithCompletionBlock:(void (^)())completionBlock {
    
    self.view.userInteractionEnabled = YES;
    int beginIndex = 2;
    
    for (int i = beginIndex; i < self.view.subviews.count; i++) {
        CGFloat centerX = self.view.subviews[i].centerX;
        CGFloat centerBeignY = self.view.subviews[i].centerY;
        CGFloat centerEndY = centerBeignY + MCScreenHeight;
        
        POPSpringAnimation *animaiton = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        animaiton.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
        animaiton.springBounciness = MCAnimationFactor;
        animaiton.springSpeed = MCAnimationFactor;
        animaiton.beginTime = CACurrentMediaTime() + (i - beginIndex) * MCAnimationDelay;
        [self.view.subviews[i] pop_addAnimation:animaiton forKey:nil];
        if (i == self.view.subviews.count - 1) {
            [animaiton setCompletionBlock:^(POPAnimation *animtion, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                !completionBlock ? : completionBlock();
            }];
            
        }
    }
    
}

@end
