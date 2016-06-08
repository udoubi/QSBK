//
//  ArticleDetailController.h
//  QSBK
//
//  Created by jiangke on 16/6/4.
//  Copyright © 2016年 TianYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeJokeData.h"

@interface ArticleDetailController : UIViewController
- (instancetype)initWithItemData:(HomeJokeItemData *)itemData withHeight:(CGFloat)height;
@end
