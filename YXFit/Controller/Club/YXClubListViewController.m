//
//  YXClubListViewController.m
//  YXFit
//
//  Created by 何军 on 10/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXClubListViewController.h"
#import "ClubListCell.h"
#import "YXLoadMoreView.h"
#import "YXClubDetailViewController.h"
@interface YXClubListViewController ()<UITableViewDataSource,UITableViewDelegate,YXLoadMoreViewDelegate,MJRefreshBaseViewDelegate>
{
    MJRefreshBaseView  *_head;
    int page;
    BOOL isLoadMore;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) YXLoadMoreView *footerView;
@end

@implementation YXClubListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleBar.text = @"俱乐部";
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
    page = 1;
    NSMutableDictionary *parmeter = [NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", page] forKey:@"page"];
    [parmeter setObject:[NSString stringWithFormat:@"%d", stateCount] forKey:@"count"];
    if (APPDELEGATE.latitude != 0) {
        [parmeter setObject:[NSString stringWithFormat:@"%f", APPDELEGATE.latitude] forKey:@"lat"];
        [parmeter setObject:[NSString stringWithFormat:@"%f", APPDELEGATE.longitude] forKey:@"long"];
    }
    [[YXNetworkingTool sharedInstance] getClubProductList:parmeter success:^(id JSON) {
        self.dataArray = [[NSMutableArray alloc] initWithArray:JSON];
        [self.tableView reloadData];
        [refreshView endRefreshing];
        
        if (self.dataArray.count == stateCount) {
            isLoadMore = YES;
            page += 1;
        }else{
            isLoadMore = NO;
            if (self.dataArray.count>10) {
                self.footerView.titleLabel.text = NSLocalizedString(@"No more", nil);
            }
        }
        
    } failure:^(NSError *error, id JSON) {
        [refreshView endRefreshing];
    }];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        // _tableView.backgroundColor =
        _tableView.allowsMultipleSelection = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _tableView.tableFooterView = self.footerView;
      //  [self.view addSubview:_tableView];
        [self.view insertSubview:_tableView belowSubview:self.navBar];
    }
    return _tableView;
}
- (YXLoadMoreView *)footerView{
    if (!_footerView) {
        _footerView = [[YXLoadMoreView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
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
    static NSString *CellIdentifier = @"ClubCell";
    ClubListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[ClubListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.club = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YXClubDetailViewController *detail = [[YXClubDetailViewController alloc] init];
    Model_club *club = [self.dataArray objectAtIndex:indexPath.row];
    detail.club = club;
    [self pushViewController:detail];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}


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
    [[YXNetworkingTool sharedInstance] getClubProductList:dic success:^(id JSON) {
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
        //  [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Network", nil)];
        self.footerView.titleLabel.text = NSLocalizedString(@"Network", nil);
        isLoadMore = YES;
    }];
}

@end
