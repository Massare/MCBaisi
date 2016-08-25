//
//  MCAVPlayerView.h
//  MC_百思不得姐
//
//  Created by Austen on 16/7/15.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MCTopic.h"

@interface MCAVPlayerView : UIView

@property (nonatomic, strong) MCTopic *topic;

- (void)reset;

@end
