//
//  YXOrderViewController.m
//  YXFit
//
//  Created by 何军 on 24/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXOrderViewController.h"
#import "YXOrderDetailViewController.h"
#import "YXLoadMoreView.h"
#import "OrderCell.h"
@interface YXOrderViewController ()<UITableViewDataSource,UITableViewDelegate,YXLoadMoreViewDelegate, MJRefreshBaseViewDelegate, UIScrollViewDelegate>
{
    MJRefreshBaseView       *_head;
    int page;
    BOOL isLoadMore;
}
@property(nonatomic, strong) UITableView    *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) YXLoadMoreView *footerView;
@end
@implementation YXOrderViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleBar.text = @"我的订单";
    [self loadRefreshView];
}
- (void)loadRefreshView
{
    // 1、下拉刷新控件
    MJRefreshHeaderView *head = [MJRefreshHeaderView header];
    head.scrollView = self.tableView;
    head.delegate = self;
    _head = head;
    [_head beginRefreshing];
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        // 下拉操作加载最新数据
        [self loadNewState:refreshView];
    }
}

- (void)loadNewState:(MJRefreshBaseView *)refreshView
{
    page = 1;
    NSDictionary *dic = @{@"page"     : [NSString stringWithFormat:@"%d", page],
                          @"count"    : [NSString stringWithFormat:@"%d", stateCount]
                          };
    [[YXNetworkingTool sharedInstance] getTradeList:dic success:^(id JSON) {
        self.dataArray = [[NSMutableArray alloc] initWithArray:JSON];
        //  NSLog(@"%d", self.dataArray.count);
        [self.tableView reloadData];
        [refreshView endRefreshing];
        
        if (self.dataArray.count == stateCount) {
            isLoadMore = YES;
            page += 1;
        }else{
            isLoadMore = NO;
            if (self.dataArray.count>10) {
                self.footerView.titleLabel.text = NSLocalizedString(@"No more state", nil);
            }
        }
        
    } failure:^(NSError *error, id JSON) {
        [refreshView endRefreshing];
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"You have no internet connection", nil)];
    }];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navBar.height, ScreenWidth, ScreenHeight - self.navBar.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = self.footerView;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (YXLoadMoreView *)footerView{
    if (!_footerView) {
        _footerView = [[YXLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        _footerView.delegate = self;
    }
    return _footerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"orderCell";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //   cell.backgroundColor = [UIColor clearColor];
        
    }
    cell.order = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YXOrderDetailViewController *detail = [[YXOrderDetailViewController alloc] init];
    Model_order *order = [self.dataArray objectAtIndex:indexPath.row];
    detail.orderID = order.order_id;
    [self pushViewController:detail];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
}

//#define DEFAULT_HEIGHT_OFFSET 44.0f
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isLoadMore && [UIUtils isConnectNetwork]){
        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
        if (scrollPosition < 44) {
            [self loadMore];
        }
    }
    
}
-(void)loadMore{
    if (isLoadMore) {
        [self.footerView.activeView startAnimating];
        [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:0.1];
        isLoadMore = NO;
        self.footerView.titleLabel.text = NSLocalizedString(@"Loading", nil);
    }
}

-(void)loadMoreData{
    NSDictionary *dic = @{@"page"    : [NSString stringWithFormat:@"%d", page],
                          @"count"     : [NSString stringWithFormat:@"%d", stateCount]
                          };
    [[YXNetworkingTool sharedInstance] getTradeList:dic success:^(id JSON) {
        NSArray *posts = [NSArray arrayWithArray:JSON];
        if (posts.count) {
            [self.dataArray addObjectsFromArray:posts];
            [self.tableView reloadData];
            [self.footerView.activeView stopAnimating];
            if (posts.count < stateCount) {
                self.footerView.titleLabel.text = NSLocalizedString(@"No more", nil);
                isLoadMore = NO;
            }else{
                isLoadMore = YES;
                page += 1;
            }
        }else{
            [self.footerView.activeView stopAnimating];
            self.footerView.titleLabel.text = NSLocalizedString(@"No more", nil);
            isLoadMore = NO;
        }
    } failure:^(NSError *error, id JSON) {
        [self.footerView.activeView stopAnimating];
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Network", nil)];
        self.footerView.titleLabel.text = NSLocalizedString(@"Network", nil);
        isLoadMore = YES;
    }];
}

@end
