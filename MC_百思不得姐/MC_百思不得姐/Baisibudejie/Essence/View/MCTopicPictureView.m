//
//  MCTopicPictureView.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/10.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCTopicPictureView.h"
#import "MCTopic.h"
#import "MCTopicPictureViewController.h"
#import <UIImageView+WebCache.h>
#import "MCProgressView.h"

@interface MCTopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@property (weak, nonatomic) IBOutlet UIImageView *gifIconImageView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@property (weak, nonatomic) IBOutlet MCProgressView *progressView;

@end

@implementation MCTopicPictureView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.pictureImageView.userInteractionEnabled = YES;
    [self.pictureImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPictureViewController)]];
}

- (void)showPictureViewController {
    MCTopicPictureViewController *vc = [[MCTopicPictureViewController alloc] init];
    vc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)setTopic:(MCTopic *)topic
{
    _topic = topic;
    
    [self.progressView setProgress:topic.loadProgress animated:YES];
    
    [self.pictureImageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
         topic.loadProgress = receivedSize * 1.0 / expectedSize;
        [self.progressView setProgress:topic.loadProgress animated:YES];
       
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        if (topic.isBigPicture == NO) return;
        
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
//        CGContextRef ref = UIGraphicsGetCurrentContext();
        
        CGFloat width = topic.pictureF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        CGRect rect = CGRectMake(0, 0, width, height);
//        CGContextAddEllipseInRect(ref, rect);
//        CGContextClip(ref);
        
        [image drawInRect:rect];
        
        self.pictureImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }];
    
    NSString *suffix = topic.large_image.pathExtension;
    self.gifIconImageView.hidden = ![suffix.lowercaseString isEqualToString:@"gif"];
    
    if (topic.isBigPicture) {
        MCLog(@"%zd",self.seeBigPictureButton.hidden);
        self.seeBigPictureButton.hidden = NO;
    }else {
        self.seeBigPictureButton.hidden = YES;
    }
}



//重置



@end
