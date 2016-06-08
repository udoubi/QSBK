//
//  PlayerView.m
//  AVPlayerDemo
//
//  Created by CaoJie on 14-5-5.
//  Copyright (c) 2014年 yiban. All rights reserved.
//

#import "HomePlayerView.h"

@interface HomePlayerView()

@property (nonatomic,strong) UIView *completeView;
@property (nonatomic,strong) UIButton *rePlaybtn;
@end

@implementation HomePlayerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *completeView = [UIView new];
        completeView.backgroundColor = [[UIColor alloc]initWithWhite:0.2 alpha:0.8];
        completeView.hidden = YES;
        self.completeView = completeView;
        [self addSubview:completeView];
        UIButton *rePlaybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rePlaybtn setTitle:@"重播" forState:UIControlStateNormal];
        [rePlaybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rePlaybtn sizeToFit];
        [completeView addSubview:rePlaybtn];
        self.rePlaybtn = rePlaybtn;
    }
    return self;
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer *)player {
    return [(AVPlayerLayer *)self.layer player];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)self.layer setPlayer:player];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.completeView.frame = self.bounds;
    self.rePlaybtn.center = self.completeView.center;
}
- (void)setPlayEnd:(BOOL)playEnd {
    _playEnd = playEnd;
    self.completeView.hidden = !playEnd;
}
@end
