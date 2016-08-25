//
//  MCShareView.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/12.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCShareView.h"

@interface MCShareView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UIView *shareView;

@end

@implementation MCShareView


+ (void)showShareView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MCShareView *mcShareView = [MCShareView viewFromXib];
    mcShareView.frame = window.bounds;
    [window addSubview:mcShareView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{
            mcShareView.shareView.y = MCScreenHeight - mcShareView.shareView.height;
        }];
        
    });

}




- (IBAction)closeButtonClick:(id)sender {
    
    [self removeFromSuperview];
}

- (IBAction)topCloseButtonClick:(id)sender {
    [self removeFromSuperview];
}


- (void)awakeFromNib {
//     self.bottomSpace.constant = - self.shareView.height;
}

@end
