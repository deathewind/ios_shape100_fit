//
//  YXCouponViewController.m
//  YXFit
//
//  Created by 何军 on 26/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXCouponViewController.h"
@interface YXCouponViewController()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    MJRefreshBaseView  *_head;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation YXCouponViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(240, 240, 240);
    self.titleBar.text = @"我的优惠券";
    [self addBackButton];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navBar.height, ScreenWidth, ScreenHeight - self.navBar.height)];
        _tableView.delegate =self;
        _tableView.dataSource = self;
       // _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}
- (void)addBackButton{
    UIButton *button_back = [UIButton buttonWithType:UIButtonTypeCustom];
    button_back.frame = CGRectMake(0, StatusBarHeight, 60, 44);
    button_back.showsTouchWhenHighlighted = YES;
    [button_back setImage:[UIImage imageFileName:@"cd_back.png"] forState:UIControlStateNormal];
    [button_back addTarget:self action:@selector(clickButton_back)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_back];
}
@end
