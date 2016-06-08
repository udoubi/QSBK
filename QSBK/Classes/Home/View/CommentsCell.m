//
//  CommentsCell.m
//  QSBK
//
//  Created by jiangke on 16/6/4.
//  Copyright © 2016年 TianYu. All rights reserved.
//

#import "CommentsCell.h"
#import <Masonry/Masonry.h>
#import "UIImageView+WebCache.h"
#import "Constant.h"

static NSString *const cellId = @"CommentsCell";

@interface CommentsCell()

@property (nonatomic,strong) UIImageView *avatarImageView;
@property (nonatomic,strong) UILabel *replyNameLabel;
@property (nonatomic,strong) UILabel *replyContentLabel;
@property (nonatomic,strong) UILabel *commentNameLabel;
@property (nonatomic,strong) UILabel *commentContentLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIView *commentView;

@property (nonatomic,strong) CommentsItemData *commentData;
@end

@implementation CommentsCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *avatarImageView = [UIImageView new];
        avatarImageView.layer.cornerRadius = 20;
        avatarImageView.layer.masksToBounds = YES;
        [self addSubview:avatarImageView];
        [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.leading.equalTo(self).offset(10);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        UILabel *replyNameLabel = [UILabel new];
        replyNameLabel.font = [UIFont fontWithName:LightFont size:15];
        replyNameLabel.textColor = [UIColor grayColor];
        [self addSubview:replyNameLabel];
        [replyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(avatarImageView.mas_trailing).offset(10);
            make.height.mas_equalTo(25);
            make.top.equalTo(avatarImageView);
            make.trailing.equalTo(self).offset(-10);
        }];
        UILabel *replyContentLabel = [UILabel new];
        replyContentLabel.font = [UIFont fontWithName:LightFont size:14];
        replyContentLabel.numberOfLines = 0;
        replyContentLabel.textColor = [UIColor blackColor];
        [self addSubview:replyContentLabel];
        [replyContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(replyNameLabel);
            make.top.equalTo(replyNameLabel.mas_bottom).offset(5);
            make.trailing.equalTo(replyNameLabel);
        }];
        
        UIView *commentView = [UIView new];
        commentView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
;
        [self addSubview:commentView];
        
        UILabel *commentNameLabel = [UILabel new];
        commentNameLabel.font = [UIFont fontWithName:LightFont size:15];
        commentNameLabel.textColor = [UIColor grayColor];
        commentNameLabel.numberOfLines = 0;
        [commentView addSubview:commentNameLabel];
        [commentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(commentView).offset(10);
            make.top.equalTo(commentView).offset(5);
            make.trailing.equalTo(commentView);
        }];
        UILabel *commentContentLabel = [UILabel new];
        commentContentLabel.font = [UIFont fontWithName:LightFont size:14];
        commentContentLabel.numberOfLines = 0;
        commentContentLabel.textColor = [UIColor blackColor];
        [commentView addSubview:commentContentLabel];
        [commentContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(commentNameLabel);
            make.top.equalTo(commentNameLabel.mas_bottom).offset(5);
            make.trailing.equalTo(commentNameLabel);
            make.bottom.equalTo(commentView).offset(-5);
        }];
        [commentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(replyNameLabel);
            make.top.equalTo(replyContentLabel.mas_bottom).offset(10);
            make.trailing.equalTo(replyNameLabel);
        }];
        UILabel *timeLabel = [UILabel new];
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.textColor = [UIColor grayColor];
        [self addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(replyNameLabel);
            make.height.mas_equalTo(25);
            make.top.equalTo(commentView.mas_bottom);
            make.trailing.equalTo(self).offset(-10);
            make.bottom.equalTo(self);
        }];
        self.avatarImageView = avatarImageView;
        self.replyNameLabel = replyNameLabel;
        self.replyContentLabel = replyContentLabel;
        self.commentView = commentView;
        self.commentNameLabel = commentNameLabel;
        self.commentContentLabel = commentContentLabel;
        self.timeLabel = timeLabel;
    }
    return self;
}
+ (CommentsCell *)cellWithTableView:(UITableView *)tableView commentData:(CommentsItemData *)commentData {
    CommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[CommentsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.commentData = commentData;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)setCommentData:(CommentsItemData *)commentData {
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:commentData.user.avatar_url] placeholderImage:nil];
    self.replyNameLabel.text = commentData.user.login;
    self.replyContentLabel.text = commentData.content;
    if (!commentData.refer) {
        [self.commentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }else{
        self.commentNameLabel.text = commentData.refer.user.login;
        self.commentContentLabel.text = commentData.refer.content;
    }
    self.timeLabel.text = @"2016.6.5";
}
@end
