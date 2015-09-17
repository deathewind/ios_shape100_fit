//
//  YXClubDetailViewController.m
//  YXFit
//
//  Created by 何军 on 11/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXClubDetailViewController.h"
#import "ExpandTableViewHeader.h"
@interface YXClubDetailViewController ()<YXLoadingViewDelegate, UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate>
{
    YXLoadingView *CoverView;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) ExpandTableViewHeader *headerView;
@end

@implementation YXClubDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleBar.text = self.club.club_name;
    [self.view insertSubview:self.tableView belowSubview:self.navBar];
    [self creatBackButton];
    [self loadClubData];
}

- (void)loadClubData{
    
//    [UIUtils showProgressHUDto:self.view withString:nil showTime:30];
//    [[YXNetworkingTool sharedInstance] getProductDetailWithID:self.club.club_id success:^(id JSON) {
        [UIView animateWithDuration:0.4 animations:^{
            self.navBar.alpha = 0;
            CoverView.alpha = 0.;
        } completion:^(BOOL finished) {
            [CoverView removeFromSuperview];
        }];
        self.headerView.club = self.club;
//        [UIUtils hideProgressHUD:self.view];
//        
//        Model_club *club = [Model_club clubWithDictionary:JSON];
//        self.headerView.club = club;
//    
//    } failure:^(NSError *error, id JSON) {
//        [UIUtils hideProgressHUD:self.view];
//        [CoverView showFailure];
//    }];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        void *context = (__bridge void *)self;
        [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:context];
    }
    return _tableView;
}
- (ExpandTableViewHeader *)headerView{
    if (!_headerView) {
        _headerView = [[ExpandTableViewHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, headerViewHeight)];
    }
    return _headerView;
}
- (void)dealloc
{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // Make sure we are observing this value.
    if (context != (__bridge void *)self) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    if ((object == self.tableView) &&
        ([keyPath isEqualToString:@"contentOffset"] == YES))
    {
        [self scrollViewDidScrollWithOffset:self.tableView.contentOffset.y];
        return;
    }
}

- (void)scrollViewDidScrollWithOffset:(CGFloat)scrollOffset
{
    //    NSLog(@"scrollOffset = %f", scrollOffset);
    if ((headerViewHeight - 64)>=scrollOffset>0) {
        CGFloat a = scrollOffset/(headerViewHeight - 64);
        if (a > 0.9 && a != 0.9) {
            a = 0.9;
        }
        self.navBar.alpha = a;
    }
    
}

- (void)addCoverView{
    CoverView  = [[YXLoadingView alloc] initWithFrame:CGRectMake(0, self.navBar.height, ScreenWidth, ScreenHeight -  self.navBar.height) color:[UIColor whiteColor]];
    CoverView.delegate = self;
    [self.view addSubview:CoverView];
}
- (void)retryRequest{
    [self loadClubData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 400;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.tableView)
    {
        // pass the current offset of the UITableView so that the ParallaxHeaderView layouts the subViews.
        [self.headerView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}
@end
