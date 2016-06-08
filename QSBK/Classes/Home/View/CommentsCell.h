//
//  CommentsCell.h
//  QSBK
//
//  Created by jiangke on 16/6/4.
//  Copyright © 2016年 TianYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsData.h"

@interface CommentsCell : UITableViewCell

+ (CommentsCell *)cellWithTableView:(UITableView *)tableView commentData:(CommentsItemData *)commentData;
@end
