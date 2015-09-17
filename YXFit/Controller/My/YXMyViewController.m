//
//  YXMyViewController.m
//  YXFit
//
//  Created by 何军 on 24/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXMyViewController.h"

#import "YXMyInfoViewController.h"
#import "LoginViewController.h"
#import "YXAboutUSViewController.h"
#import "YXFeedbackViewController.h"
#import "YXCouponViewController.h"
#import "MLNavigationController.h"
#import "YXOrderViewController.h"

#import "MyHeaderExpandView.h"

#define BGImageHeight 180
@interface YXMyViewController()<UITableViewDataSource, UITableViewDelegate,  MyHeaderExpandViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) MyHeaderExpandView *headerView;
@end
@implementation YXMyViewController
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.headerView setNameAndImage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self loadData];
}
- (void)loadData{
    self.dataArray = [NSArray arrayWithObjects:@"我的订单",@"个人信息",@"我的优惠券",@"意见反馈",@"关于我们", nil];
    [self.tableView reloadData];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}
- (MyHeaderExpandView *)headerView{
    if (!_headerView) {
        _headerView = [[MyHeaderExpandView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, BGImageHeight)];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (void)showPortrait:(UITapGestureRecognizer *)tap{
    LoginViewController *login = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellReuseIdentifier  = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50 - 0.5, ScreenWidth - 20, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [cell addSubview:line];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = RGB(60, 60, 60);
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:YXToken];
        if (token == nil) {
            [self presentLoginView];
        }else{
            YXOrderViewController *info = [[YXOrderViewController alloc] init];
            [self pushViewController:info];
        }
        
    }
    if (indexPath.row == 1) {
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:YXToken];
        if (token == nil) {
            [self presentLoginView];
        }else{
            YXMyInfoViewController *info = [[YXMyInfoViewController alloc] init];
            [self pushViewController:info];
        }
    }
    if (indexPath.row == 2) {
        
    }
    if (indexPath.row == 3) {
        YXFeedbackViewController *feedback = [[YXFeedbackViewController alloc] init];
        [self pushViewController:feedback];
    }
    if (indexPath.row == 4) {
        YXAboutUSViewController *about = [[YXAboutUSViewController alloc] init];
        [self pushViewController:about];
    }

//            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"还未登录,是否现在登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            //            [alert show];

}
#pragma mark alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        LoginViewController *login = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        nav.navigationBarHidden = YES;
        [self presentViewController:nav animated:YES completion:nil];
    }
}
- (void)presentLoginView{
    LoginViewController *login = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.tableView)
    {
        // pass the current offset of the UITableView so that the ParallaxHeaderView layouts the subViews.
        [self.headerView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
        // [(ParallaxHeaderView *)self.mainTableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}
@end
