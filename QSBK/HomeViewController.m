//
//  ViewController.m
//  QSBK
//
//  Created by jiangke on 16/6/3.
//  Copyright © 2016年 TianYu. All rights reserved.
//

#import "HomeViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "Masonry.h"
#import "HomeJokeData.h"
#import "HomeJokeCell.h"
#import "HomeVideoImage.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "ArticleDetailController.h"
#import "TitleScrollView.h"
#import "Constant.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,TitleScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HomeJokeData *homeData;
@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) TitleScrollView *titleScrollViw;
@property (nonatomic,strong) NSMutableArray<UITableView *> *tableViewArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildViews];
}
- (void)buildViews {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"糗事百科";
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *titleArray = @[@"专享",@"视频",@"纯文",@"纯图",@"精品"];
    TitleScrollView *titleScrollView = [[TitleScrollView alloc]initWithTitleArray:titleArray itemWidth:SCREEN_WIDTH / titleArray.count];
    titleScrollView.delegate = self;
    [self.view addSubview:titleScrollView];
    [titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    self.titleScrollViw = titleScrollView;
    
    UIScrollView *mainScrollView = [UIScrollView new];
    mainScrollView.pagingEnabled = YES;
    UIView *contentView = [UIView new];
    [mainScrollView addSubview:contentView];
    [self.view addSubview:mainScrollView];
    [mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
        make.top.equalTo(titleScrollView.mas_bottom);
    }];
    self.mainScrollView = mainScrollView;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(mainScrollView);
        make.height.equalTo(mainScrollView);
    }];
    
    UITableView *lastView,*firstView;;
    for (NSInteger i = 0; i < titleArray.count; i ++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.tag = i;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 150;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        __weak typeof(self) wSelf = self;
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [wSelf loadHomeDataWithTableView:tableView];
        }];
        [contentView addSubview:tableView];
        [self.tableViewArray addObject:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(lastView ? lastView.mas_trailing : @0);
            make.top.equalTo(contentView);
            make.bottom.equalTo(contentView);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        if (i == 0) {
            firstView = tableView;
        }
        lastView = tableView;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(contentView);
    }];
    [firstView.mj_header beginRefreshing];
}
#pragma tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeData.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeJokeCell *cell = [HomeJokeCell cellWithTable:tableView itemData:self.homeData.items[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeJokeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.navigationController pushViewController: [[ArticleDetailController alloc]initWithItemData:self.homeData.items[indexPath.row] withHeight:CGRectGetHeight(cell.frame)]animated:YES];
}
- (void)loadHomeDataWithTableView:(UITableView *)tableView {
    [HomeJokeData getHomeDataIndex:tableView.tag complete:^(id data, NSError *error) {
        if (!error) {
            self.homeData = data;
            [tableView reloadData];
        }else {
            [SVProgressHUD showErrorWithStatus:error.description];
        }
        [tableView.mj_header endRefreshing];
    }];
}
- (NSMutableArray<UITableView *> *)tableViewArray {
    if (_tableViewArray == nil) {
        _tableViewArray = [NSMutableArray array];
    }
    return _tableViewArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)didTitleScrollViewCliked:(TitleScrollView *)titleScrollView atIndex:(NSInteger)index {
    [self.mainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * index, 0)];
    [self.tableViewArray[index].mj_header beginRefreshing];
}
@end
