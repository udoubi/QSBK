//
//  HomeJokeCell.h
//  QSBK
//
//  Created by jiangke on 16/6/3.
//  Copyright © 2016年 TianYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeJokeData.h"
#import "Constant.h"

static NSString *const ItemFormatWord = @"word";
static NSString *const ItemFormatImage = @"image";
static NSString *const ItemFormatVideo = @"video";

static NSString *const cellId = @"HomeJokeCell";

@interface HomeJokeCell : UITableViewCell
@property (nonatomic,strong) HomeJokeItemData *itemData;

+ (HomeJokeCell *)cellWithTable:(UITableView *)tableView itemData:(HomeJokeItemData *)itemData;
@end
