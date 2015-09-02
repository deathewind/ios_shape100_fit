//
//  YXProductViewController.m
//  YXFit
//
//  Created by 何军 on 24/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXProductViewController.h"
#import "YXProductDetailViewController.h"
#import "MainListCell.h"
@interface YXProductViewController()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    MJRefreshBaseView  *_head;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation YXProductViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleBar.text = @"商品列表";
   // self.view.backgroundColor = RGB(233, 233, 233);
    [self loadRefreshView];
}
- (void)loadRefreshView
{
    MJRefreshHeaderView *head = [MJRefreshHeaderView header];
    head.scrollView = self.tableView;
    head.delegate = self;
    _head = head;
    [_head beginRefreshing];
}
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        [self loadNewState:refreshView];
    }
}
- (void)loadNewState:(MJRefreshBaseView *)refreshView
{
    [[YXNetworkingTool sharedInstance] getProductListSuccess:^(id JSON) {
        self.dataArray = [[NSMutableArray alloc] initWithArray:JSON];
        [self.tableView reloadData];
        [refreshView endRefreshing];
    } failure:^(NSError *error, id JSON) {
        [refreshView endRefreshing];
    }];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navBar.height, self.view.width, self.view.height - self.navBar.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
       // _tableView.backgroundColor =
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MainCell";
    MainListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[MainListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.product = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YXProductDetailViewController *detail = [[YXProductDetailViewController alloc] init];
    detail.product = [self.dataArray objectAtIndex:indexPath.row];
    [self pushViewController:detail];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
@end
