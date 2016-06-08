//
//  PlayerView.h
//  AVPlayerDemo
//
//  Created by CaoJie on 14-5-5.
//  Copyright (c) 2014年 yiban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface HomePlayerView : UIView

@property (nonatomic ,strong) AVPlayer *player;
@property (nonatomic,assign) BOOL playEnd;

@end
