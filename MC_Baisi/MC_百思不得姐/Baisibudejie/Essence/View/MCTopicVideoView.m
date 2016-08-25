//
//  MCTopicVideoView.m
//  MC_百思不得姐
//
//  Created by Austen on 16/7/10.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MCTopicVideoView.h"
#import "MCTopicVideoViewController.h"
#import "MCTopic.h"
#import <UIImageView+WebCache.h>
#import "MCProgressView.h"

@interface MCTopicVideoView ()

/** 视频图片imageView*/
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
/**播放次数label*/
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
/**视频时长label*/
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
/**播放按钮*/
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet MCProgressView *progressView;

@end

@implementation MCTopicVideoView


- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    
    [self.videoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideoViewController)]];
    
}

- (void)showVideoViewController {
    MCTopicVideoViewController *vc = [[MCTopicVideoViewController alloc] init];
    vc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)setTopic:(MCTopic *)topic
{
    _topic = topic;
    self.playButton.hidden = YES;
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    NSInteger minute = [topic.videotime intValue] / 60;
    NSInteger second = [topic.videotime intValue] % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
    [self.progressView setProgress:topic.loadProgress animated:YES];
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        topic.loadProgress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:topic.loadProgress animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
        self.playButton.hidden = NO;
        
        self.videoImageView.userInteractionEnabled = YES;
    }];
  
    
}

- (IBAction)playButtonClick:(id)sender {
    
}


@end
