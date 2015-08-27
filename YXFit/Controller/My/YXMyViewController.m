//
//  YXMyViewController.m
//  YXFit
//
//  Created by 何军 on 24/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXMyViewController.h"
#import "YXBGScrollowView.h"
#import "MyHeaderView.h"
#import "YXMyInfoViewController.h"
#import "LoginViewController.h"
#import "YXAboutUSViewController.h"
#import "YXFeedbackViewController.h"
#import "YXCouponViewController.h"
@interface YXMyViewController()<UITableViewDataSource, UITableViewDelegate, YXBGScrollowViewDelegate, MyHeaderViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) YXBGScrollowView *bgView;
@property (nonatomic, strong) MyHeaderView *headView;
@end
@implementation YXMyViewController
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.headView setNameAndImage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.titleBar.text = @"商品列表";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    [self loadData];
}
- (void)loadData{
    self.dataArray = [NSArray arrayWithObjects:@"个人信息",@"账户余额",@"我的优惠券",@"意见反馈",@"关于我们", nil];
    [self.tableView reloadData];
}

- (YXBGScrollowView *)bgView{
    if (!_bgView) {
        _bgView = [[YXBGScrollowView alloc] initWithFrame:self.view.frame];
        _bgView.delegate = self;
    }
    return _bgView;
}

- (void)detailsForegroundView:(UIView *)foregroundView{
    
    [foregroundView addSubview:self.tableView];
    
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate =self;
        _tableView.dataSource = self;
       // _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headView;
    }
    return _tableView;
}
- (MyHeaderView *)headView{
    if (!_headView) {
        _headView = [[MyHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, BGImageHeight)];
        _headView.delegate = self;
        //[_headView reloadMyData];
    }
    return _headView;
}
- (void)showPortrait:(UITapGestureRecognizer *)tap{
    LoginViewController *login = [[LoginViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
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
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:YXToken];
 
    NSString *title = [self.dataArray objectAtIndex:indexPath.row];
    if ([title isEqualToString:@"个人信息"]) {
        if (token == nil) {
            [UIUtils showTextOnly:self.view labelString:@"没有登录"];
            return;
        }
        YXMyInfoViewController *info = [[YXMyInfoViewController alloc] init];
        [self pushViewController:info];
    }
    if ([title isEqualToString:@"关于我们"]) {
        YXAboutUSViewController *about = [[YXAboutUSViewController alloc] init];
        [self pushViewController:about];
    }
    if ([title isEqualToString:@"我的优惠券"]) {
        if (token == nil) {
            [UIUtils showTextOnly:self.view labelString:@"没有登录"];
            return;
        }
        YXCouponViewController *coupon = [[YXCouponViewController alloc] init];
        [self pushViewController:coupon];
    }
    if ([title isEqualToString:@"意见反馈"]) {
        YXFeedbackViewController *feedback = [[YXFeedbackViewController alloc] init];
        [self pushViewController:feedback];
    }
}
@end
