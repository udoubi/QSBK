//
//  CommentsData.m
//  QSBK
//
//  Created by jiangke on 16/6/4.
//  Copyright © 2016年 TianYu. All rights reserved.
//

#import "CommentsData.h"

@implementation CommentsData

+ (void)loadCommentsData:(void(^)(id data,NSError *error))complete {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test_data.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    CommentsData *commentsData = [CommentsData mj_objectWithKeyValues:dic];
    complete(commentsData,nil);
}


+ (NSDictionary *)mj_objectClassInArray {
    return @{@"items":NSStringFromClass([CommentsItemData class])};
}
@end

@implementation CommentsItemData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"cid":@"id"};
}

@end