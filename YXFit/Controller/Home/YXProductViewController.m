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
#import "YXLoadMoreView.h"
#import "YXCalendarViewController.h"


//#import "YXFontViewController.h"
@interface YXProductViewController()<UITableViewDataSource,UITableViewDelegate,YXLoadMoreViewDelegate,MJRefreshBaseViewDelegate>
{
    MJRefreshBaseView  *_head;
    int page;
    BOOL isLoadMore;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) YXLoadMoreView *footerView;

@end
@implementation YXProductViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleBar.text = @"商品列表";
    [self loadRefreshView];
   // [self goFont];
}
- (void)goFont{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(ScreenWidth - 60, 20, 60, 40);
    [button addTarget:self action:@selector(pushFont) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
   
}
- (void)pushFont{
//    YXFontViewController *font = [[YXFontViewController alloc] init];
//    [self pushViewController:font];
}
- (void)loadRefreshView
{
    MJRefreshHeaderView *head = [MJRefreshHeaderView header];
    head.scrollView = self.tableView;
    head.delegate = self;
    _head = head;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_head beginRefreshing];
    });
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

  //  YXLog(@"最新的经纬度：%f,%f",APPDELEGATE.latitude, APPDELEGATE.longitude);
    if (APPDELEGATE.latitude != 0) {
        [parmeter setObject:[NSString stringWithFormat:@"%f", APPDELEGATE.latitude] forKey:@"lat"];
        [parmeter setObject:[NSString stringWithFormat:@"%f", APPDELEGATE.longitude] forKey:@"long"];
    }

    [[YXNetworkingTool sharedInstance] getEnterpriseProductList:parmeter success:^(id JSON) {
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
       // _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navBar.height)];
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _tableView.tableFooterView = self.footerView;
       // [self.view addSubview:_tableView];
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
    return 250;
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
    [[YXNetworkingTool sharedInstance] getEnterpriseProductList:dic success:^(id JSON) {
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
