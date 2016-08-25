//
//  MCTopicPictureViewController.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/10.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCTopicPictureViewController.h"
#import "MCTopic.h"
#import <UIImageView+WebCache.h>

@interface MCTopicPictureViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MCTopicPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollView];
    
}

- (void)setupScrollView {
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.userInteractionEnabled = YES;
     [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backButtonClick:)]];
    [self.containerScrollView addSubview:imageView];
    self.imageView = imageView;
    
    CGFloat pictureW = MCScreenWidth;
    CGFloat pictureH = pictureW * 1.0 * self.topic.height / self.topic.width ;
    
    if (pictureH <= MCScreenHeight) {
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = self.view.centerY;
    }else {
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.containerScrollView.contentSize = CGSizeMake(0, pictureH);
    }
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
   
}

/**隐藏状态栏*/
- (BOOL)prefersStatusBarHidden
{
    return  YES;
}

- (IBAction)backButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)repostButtonClick:(id)sender {
    
}

- (IBAction)commentButtonClick:(id)sender {
    
}


- (IBAction)saveButtonClick:(id)sender {
    
}



@end
