//
//  ArticleDetailController.m
//  QSBK
//
//  Created by jiangke on 16/6/4.
//  Copyright © 2016年 TianYu. All rights reserved.
//

#import "ArticleDetailController.h"
#import "HomeJokeCell.h"
#import "CommentsCell.h"
#import "CommentsData.h"
#import <Masonry/Masonry.h>

@interface ArticleDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) HomeJokeItemData *itemData;
@property (nonatomic,assign) CGFloat headerViewHeight;
@property (nonatomic,strong) CommentsData *commentsData;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ArticleDetailController

- (instancetype)initWithItemData:(HomeJokeItemData *)itemData withHeight:(CGFloat)height {
    if (self = [super init]) {
        self.itemData = itemData;
        self.headerViewHeight = height;
    }
    return self;
}
- (void)loadData {
    [CommentsData loadCommentsData:^(id data, NSError *error) {
        self.commentsData = data;
        [self.tableView reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self buildViews];
    [self loadData];
}
- (void)buildViews {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 100;
    tableView.separatorInset = UIEdgeInsetsMake(0, 60, 0, 0);
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.bottom.equalTo(self.view);
    }];
    self.tableView = tableView;
    
    HomeJokeCell *homeJokeView = [[HomeJokeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    homeJokeView.itemData = self.itemData;
    homeJokeView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.headerViewHeight);
    tableView.tableHeaderView = homeJokeView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentsData.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentsCell *cell = [CommentsCell cellWithTableView:tableView commentData:self.commentsData.items[indexPath.row]];
    return cell;
}
@end
