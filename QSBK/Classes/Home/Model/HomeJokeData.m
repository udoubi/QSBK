//
//  HomeJokeData.m
//  QSBK
//
//  Created by jiangke on 16/6/3.
//  Copyright © 2016年 TianYu. All rights reserved.
//

#import "HomeJokeData.h"
#import "AFNetworking.h"

@implementation HomeJokeData

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"items":NSStringFromClass([HomeJokeItemData class])
             };
}

+ (void)getHomeDataIndex:(NSInteger)index complete:(void(^)(id data,NSError *error))complete{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSArray *keyPram = @[@"suggest",@"video",@"imgrank",@"text",@"day"];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://m2.qiushibaike.com/article/list/suggest?page=1&type=refresh&count=30&readarticles=[116591416,116585003,116599175,116596196,116584946]&rqcnt=17&r=da4083741465195420425"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setValue:@"m2.qiushibaike.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"qiushibalke_9.5.0_WIFI_auto_19" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"android_9.5.0" forHTTPHeaderField:@"Source"];
    [request setValue:@"Xiaomi/gemini/gemini:6.0/MRA58K/V7.3.4.0.MAACNDD:user/release-keys" forHTTPHeaderField:@"Model"];
    [request setValue:@"IMEI_9e6a014b2918d8a1a0e496b3da408374" forHTTPHeaderField:@"Uuid"];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            complete(nil,error);
        } else {
            HomeJokeData *homeData = [HomeJokeData mj_objectWithKeyValues:responseObject];
            complete(homeData,nil);
        }
    }];
    [dataTask resume];
}
@end

@implementation HomeJokeItemData

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"pic_size":NSStringFromClass([NSNumber class])
             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"jid":@"id"
             };
}
- (NSString *)image_url {
    return [NSString stringWithFormat:@"%@%@/%@/medium/%@",picHost,[_jid substringToIndex:5],_jid,_image];
}
- (CGFloat)image_scale {
    CGFloat scale = 0.0;
    if (_image_size != nil) {
        scale = [_image_size.m[1] floatValue] / [_image_size.m[0] floatValue];
    }
    return scale;
}
- (CGFloat)pic_scale {
    CGFloat scale = 0.0;
    if (_image_size != nil) {
        scale = [_pic_size[1] floatValue] / [_pic_size[0] floatValue];
    }
    return scale;
}
@end

@implementation HomeJokeImageSize

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"s":NSStringFromClass([NSNumber class]),
             @"m":NSStringFromClass([NSNumber class])
             };
}

@end

@implementation HomeUserModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"uid":@"id"
             };
}
- (NSString *)avatar_url {
    return [NSString stringWithFormat:@"%@%@/%@/thumb/%@",avatarHost,[_uid substringToIndex:4],_uid,_icon];
}

@end