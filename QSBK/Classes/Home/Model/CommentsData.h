//
//  CommentsData.h
//  QSBK
//
//  Created by jiangke on 16/6/4.
//  Copyright © 2016年 TianYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeJokeData.h"
@interface CommentsData : NSObject

@property (nonatomic) NSInteger count;
@property (nonatomic) NSInteger total;
@property (nonatomic) NSInteger page;
@property (nonatomic) NSInteger err;
@property (nonatomic,copy) NSArray *items;

+ (void)loadCommentsData:(void(^)(id data,NSError *error))complete;
@end

@interface CommentsItemData : NSObject

@property (nonatomic) NSInteger cid;
@property (nonatomic,copy) NSString *content;
@property (nonatomic) NSInteger floor;
@property (nonatomic,strong) CommentsItemData *refer;
@property (nonatomic) NSInteger like_count;
@property (nonatomic) BOOL liked;
@property (nonatomic) NSInteger created_at;
@property (nonatomic) HomeUserModel *user;
@property (nonatomic) NSInteger parent_id;
@end