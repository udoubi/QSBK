//
//  HomeJokeData.h
//  QSBK
//
//  Created by jiangke on 16/6/3.
//  Copyright © 2016年 TianYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJExtension.h"
@class HomeUserModel;
@class HomeJokeImageSize;

static NSString *const avatarHost = @"http://pic.qiushibaike.com/system/avtnew/";
static NSString *const picHost = @"http://pic.qiushibaike.com/system/pictures/";


@interface HomeJokeData : NSObject

@property (nonatomic) NSInteger count;
@property (nonatomic) NSInteger err;
@property (nonatomic,copy) NSArray *items;
@property (nonatomic) NSInteger total;
@property (nonatomic) NSInteger page;
@property (nonatomic) NSInteger refresh;

+ (void)getHomeDataIndex:(NSInteger)index complete:(void(^)(id data,NSError *error))complete;

@end

@interface HomeJokeItemData : NSObject


@property (nonatomic) NSInteger comments_count;
@property (nonatomic) NSInteger share_count;
@property (nonatomic,copy) NSString *tag;
@property (nonatomic,copy) NSString *state;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *format;
@property (nonatomic,copy) NSString *pic_url;
@property (nonatomic) NSInteger published_at;
@property (nonatomic,copy) NSString *jid;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSArray *pic_size;
@property (nonatomic,strong) HomeJokeImageSize *image_size;
@property (nonatomic,copy) NSString *high_url;
@property (nonatomic) NSInteger loop;
@property (nonatomic) NSInteger created_at;
@property (nonatomic) BOOL allow_comment;
@property (nonatomic,copy) NSString *low_url;
@property (nonatomic,strong) HomeUserModel *user;
@property (nonatomic,copy) NSString *image_url;
@property (nonatomic) CGFloat image_scale;
@property (nonatomic) CGFloat pic_scale;
@end

@interface HomeJokeImageSize : NSObject
@property (nonatomic,copy) NSArray *s;
@property (nonatomic,copy) NSArray *m;
@end

@interface HomeUserModel : NSObject
@property (nonatomic,copy) NSString *uid;
@property (nonatomic) NSInteger last_visited_at;
@property (nonatomic) NSInteger avatar_updated_at;
@property (nonatomic) NSInteger created_at;

@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *state;
@property (nonatomic,copy) NSString *role;
@property (nonatomic,copy) NSString *login;
@property (nonatomic,copy) NSString *last_device;

@property (nonatomic,copy)NSString *avatar_url;

@end