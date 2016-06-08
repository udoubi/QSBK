//
//  HomeJokeCell.m
//  QSBK
//
//  Created by jiangke on 16/6/3.
//  Copyright © 2016年 TianYu. All rights reserved.
//

#import "HomeJokeCell.h"
#import <Masonry/Masonry.h>
#import "UIImageView+WebCache.h"
#import "HomeVideoImage.h"
#import "HomePlayerView.h"
#import <AVFoundation/AVFoundation.h>


@interface HomeJokeCell()

@property (nonatomic,strong) UIImageView *avatarImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UILabel *dynamicLabel;
@property (nonatomic,strong) HomeVideoImage *videoView;
@property (nonatomic,strong) HomePlayerView *playerView;

@property (nonatomic,assign) BOOL played;

@end

@implementation HomeJokeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *avatarImageView = [UIImageView new];
        avatarImageView.layer.cornerRadius = 20;
        avatarImageView.layer.masksToBounds = YES;
        [self addSubview:avatarImageView];
        [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.equalTo(self).offset(10);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        UILabel *nameLabel = [UILabel new];
        nameLabel.font = [UIFont fontWithName:RegularFont size:16];
        [self addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(avatarImageView.mas_trailing).offset(10);
            make.centerY.equalTo(avatarImageView);
            make.height.mas_equalTo(40);
            make.trailing.equalTo(self).offset(-10);
        }];
        UILabel *contentLabel = [UILabel new];
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont fontWithName:LightFont size: 16];
        [self addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(avatarImageView);
            make.trailing.equalTo(nameLabel);
            make.top.equalTo(avatarImageView.mas_bottom).offset(5);
        }];
        UIImageView *picImageView = [UIImageView new];
        picImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(videoTaped)];
        [picImageView addGestureRecognizer:tap];
        picImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:picImageView];
        [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentLabel.mas_bottom).offset(10);
            make.leading.equalTo(avatarImageView);
            make.trailing.equalTo(nameLabel);
            make.height.mas_equalTo(0);
        }];
        HomeVideoImage *videoView = [[HomeVideoImage alloc]init];
        videoView.userInteractionEnabled = NO;
        videoView.hidden = YES;
        [self addSubview:videoView];
        [videoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(picImageView);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        HomePlayerView *playerView = [[HomePlayerView alloc]init];
        [picImageView addSubview:playerView];
        [playerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(picImageView);
        }];
        
        UILabel *dynamicLabel = [UILabel new];
        dynamicLabel.font = [UIFont fontWithName:RegularFont size:13];
        dynamicLabel.textColor = [UIColor grayColor];
        [self addSubview:dynamicLabel];
        [dynamicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(avatarImageView);
            make.top.equalTo(picImageView.mas_bottom).offset(5);
            make.height.mas_equalTo(30);
            make.trailing.equalTo(nameLabel);
        }];
        UIView *breaklineView = [UIView new];
        breaklineView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
        [self addSubview:breaklineView];
        [breaklineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self);
            make.height.mas_equalTo(10);
            make.top.equalTo(dynamicLabel.mas_bottom).offset(10);
            make.bottom.equalTo(self);
        }];
        
        self.avatarImageView = avatarImageView;
        self.nameLabel = nameLabel;
        self.contentLabel = contentLabel;
        self.picImageView = picImageView;
        self.dynamicLabel = dynamicLabel;
        self.videoView = videoView;
        self.playerView = playerView;
    }
    return self;
}
- (void)videoTaped {
    if (self.playerView.player != nil) {
        if (!self.played) {
            [self.playerView.player play];
            self.videoView.hidden = YES;
        }else {
            [self.playerView.player pause];
            self.videoView.hidden = NO;
        }
    }
    self.played = !self.played;
}
- (void)moviePlayDidEnd:(NSNotification *)notification {
    NSLog(@"Play end");
    self.playerView.playEnd = YES;
}
+ (HomeJokeCell *)cellWithTable:(UITableView *)tableView itemData:(HomeJokeItemData *)itemData {
    HomeJokeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[HomeJokeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.itemData = itemData;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)setItemData:(HomeJokeItemData *)itemData {
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:itemData.user.avatar_url]];
    self.nameLabel.text = itemData.user.login;
    self.contentLabel.text = itemData.content;
    self.dynamicLabel.text = [NSString stringWithFormat:@"好笑 819 . 评论 %ld . 分享 %ld",(long)itemData.comments_count,(long)itemData.share_count];
    
    if ([itemData.format isEqualToString:ItemFormatImage]) {
        self.videoView.hidden = YES;
        self.playerView.hidden = YES;
        [self.picImageView sd_setImageWithURL:[NSURL URLWithString:itemData.image_url]];
        CGFloat imageH = (SCREEN_WIDTH - 20) * itemData.image_scale;
        [self.picImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(imageH);
        }];
    }else if([itemData.format isEqualToString:ItemFormatVideo]) {
        self.playerView.hidden = NO;
        self.videoView.hidden = NO;
        [self.picImageView sd_setImageWithURL:[NSURL URLWithString:itemData.pic_url]];
        CGFloat imageH = (SCREEN_WIDTH- 20) * itemData.pic_scale;
        [self.picImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(imageH);
        }];
        AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:itemData.low_url]];
        self.playerView.player = player;
        self.playerView.playEnd = NO;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }else{
        self.videoView.hidden = YES;
        self.playerView.hidden = YES;
        [self.picImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
}

@end
