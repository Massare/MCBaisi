//
//  MCWebVC.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/14.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCWebVC.h"
#import <NJKWebViewProgress.h>

@interface MCWebVC ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButtonItem;

@property (nonatomic, strong) NJKWebViewProgress *progress;

@end

@implementation MCWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPogressView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)setupPogressView {
    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progress;
    
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress) {
        weakSelf.progressView.progress = progress;
        weakSelf.progressView.hidden = (progress == 1.0);
    };
//    self.progress.progressBlock = ^(float progress) {
//        [weakSelf.progressView setProgress:progress animated:NO];
//        weakSelf.progressView.hidden = (progress == 1.0);
//    };
    self.progress.webViewProxyDelegate = self;
//    self.progress.progressDelegate = self;
    
}

//-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
//{
//    [self.progressView setProgress:progress animated:NO];
//}



- (IBAction)backWardButtonClick:(id)sender {
    [self.webView goBack];
}

- (IBAction)forwardButtonClick:(id)sender {
    [self.webView goForward];
}

- (IBAction)refreshButtonClick:(id)sender {
    [self.webView reload];
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backButtonItem.enabled = self.webView.canGoBack;
    self.forwardButtonItem.enabled = self.webView.canGoForward;
}

@end
