//
//  MCLoginRegisterViewController.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/6.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCLoginRegisterViewController.h"

@interface MCLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *loginPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *loginPassword;

@property (weak, nonatomic) IBOutlet UITextField *registerPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *registerPassword;
@property (weak, nonatomic) IBOutlet UIButton *registerAccountButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeadingMargin;

@end

@implementation MCLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    
//    NSString *string = @"手机号";
//    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:string];
//    [placeholder setAttributes:@{
//                                 NSFontAttributeName:[UIFont systemFontOfSize:14],
//                                 NSForegroundColorAttributeName:[UIColor whiteColor]
//                                 } range:NSMakeRange(0, 2)];
//    self.loginPhoneNumber.attributedPlaceholder = placeholder;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (IBAction)backButtonClick:(UIButton *)sender {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)loginButtonClick:(UIButton *)sender {
}

- (IBAction)forgetPwButtonClick:(UIButton *)sender {
}

- (IBAction)registerAccountButtonClick:(UIButton *)button {
    [self.view endEditing:YES];
    if (self.loginViewLeadingMargin.constant == 0) {
        self.loginViewLeadingMargin.constant = - self.view.width;
        button.selected = YES;
    }else {
        self.loginViewLeadingMargin.constant = 0;
        button.selected = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
        
    }];
}

- (IBAction)registerButtonClick:(UIButton *)sender {
}

- (IBAction)QQLoginButtonClick:(UIButton *)sender {
}

- (IBAction)sinaLoginButtonClick:(UIButton *)sender {
}

- (IBAction)tecentWeiboLoginButtonClick:(UIButton *)sender {
}

@end
