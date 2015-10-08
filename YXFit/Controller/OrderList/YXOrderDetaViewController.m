//
//  YXOrderDetaViewController.m
//  YXFit
//
//  Created by 何军 on 25/9/15.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "YXOrderDetaViewController.h"
#import "Model_order.h"
#import "YXPayInfoViewController.h"

#import "DetailCell.h"
@interface YXOrderDetaViewController ()<YXLoadingViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) Model_order    *order;

@property(nonatomic, strong) YXLoadingView  *coverView;
@end

@implementation YXOrderDetaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleBar.text = @"订单详情";
    
    [self.view addSubview:self.coverView];
    
    //网络请求
    [self loadRequestData];
    //返回按钮
    [self creatBackBtn];
}
- (void)loadRequestData{
    [UIUtils showProgressHUDto:self.view withString:nil showTime:30];
    [[YXNetworkingTool sharedInstance] getOrderDetailWithID:self.orderID success:^(id JSON) {
        [UIView animateWithDuration:0.4 animations:^{
            self.coverView.alpha = 0.;
        } completion:^(BOOL finished) {
            [self.coverView removeFromSuperview];
        }];
        [UIUtils hideProgressHUD:self.view];
        self.order = [Model_order orderWithDictionary:JSON];
        [self.tableView reloadData];
        if ([self.order.order_status isEqualToString:@"0"]) {
            [self addPayButton];
        }

    } failure:^(NSError *error, id JSON) {
        [UIUtils hideProgressHUD:self.view];
        [self.coverView showFailure];
    }];

}
- (void)creatBackBtn{
    UIButton *button_back = [UIButton buttonWithType:UIButtonTypeCustom];
    button_back.frame = CGRectMake(0, StatusBarHeight, 60, 44);
    button_back.showsTouchWhenHighlighted = YES;
    [button_back setImage:[UIImage imageFileName:@"cd_backBlack.png"] forState:UIControlStateNormal];
    [button_back addTarget:self action:@selector(clickButton_back)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_back];
}

- (void)clickButton_back{
    if (_index == 0) {
        [[YXTabBarView sharedInstance] showAnimation];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if(_index == 2){
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (YXLoadingView *)coverView{
    if (!_coverView) {
        _coverView = [[YXLoadingView alloc] initWithFrame:CGRectMake(0, self.navBar.height, ScreenWidth, ScreenHeight -  self.navBar.height) color:RGB(240, 240, 240)];
        _coverView.delegate = self;
        
    }
    return _coverView;
}
- (void)retryRequest{
    [self loadRequestData];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navBar.height, ScreenWidth, ScreenHeight -  self.navBar.height) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = RGB(240, 240, 240);
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if(section == 1){
        return 1;
    }
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"orderIDCell";
            DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil){
                cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier cellHeight:35];
            }
            [cell setLeftString:@"订单号 :" rightString:self.order.order_id];
            return cell;
        }
        static NSString *CellIdentifier = @"statusCell";
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
            cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier cellHeight:35];
        }
        [cell setLeftString:@"订单状态 :" andOrderStatus:self.order.order_status];
        return cell;
        
    }else if (indexPath.section == 1){
        static NSString *CellIdentifier = @"infoCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        return cell;
    }else{
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"totelCell";
            DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil){
                cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier cellHeight:44];
            }
            [cell setLeftString:@"订单总金额" rightString:[NSString stringWithFormat:@"%@元",self.order.order_payment]];
            return cell;
        }else if (indexPath.row == 1){
            static NSString *CellIdentifier = @"couponCell";
            DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil){
                cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier cellHeight:44];
            }
            [cell setLeftString:@"优惠券" rightString:@"0元"];
            return cell;

        }else if (indexPath.row == 2){
            static NSString *CellIdentifier = @"balanceCell";
            DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil){
                cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier cellHeight:44];
            }
            [cell setLeftString:@"余额支付金额" rightString:@"0元"];
            return cell;
            
        }else if (indexPath.row == 3){
            static NSString *CellIdentifier = @"payOnlineCell";
            DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil){
                cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier cellHeight:44];
            }
            [cell setLeftString:@"第三方支付" rightString:@"0元"];
            return cell;
        }
    }

    return nil;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
//    return view;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        return 35;
    }else if (indexPath.section == 2){
        return 44;
    }
    return 140;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //字体家族名称
    if (section == 0) {
        return @"订单信息";
    }else if (section == 1){
        return @"商品信息";
    }
    return @"支付信息";
}


- (void)addPayButton{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 44, ScreenWidth, 44)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(10, 5, view.frame.size.width / 2 - 30 /2, 34);
    [cancel setTitle:@"订单取消" forState:UIControlStateNormal];
    cancel.titleLabel.font = YXCharacterFont(16);
    [cancel setTitleColor:RGB(199, 21, 133) forState:UIControlStateNormal];
    cancel.layer.cornerRadius = 5;
    cancel.layer.borderWidth = 1;
    cancel.layer.borderColor = RGB(199, 21, 133).CGColor;
    cancel.tag = 100;
    [cancel addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancel];
    
    UIButton *pay = [UIButton buttonWithType:UIButtonTypeCustom];
    pay.frame = CGRectMake(cancel.frame.size.width + cancel.frame.origin.x + 5, 5, cancel.frame.size.width , 34);
    [pay setTitle:@"立即支付" forState:UIControlStateNormal];
    pay.titleLabel.font = YXCharacterFont(16);
    [pay setTitleColor:RGB(199, 21, 133) forState:UIControlStateNormal];
    pay.layer.cornerRadius = 5;
    pay.layer.borderWidth = 1;
    pay.layer.borderColor = RGB(199, 21, 133).CGColor;
    pay.tag = 101;
    [pay addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:pay];
}
- (void)clickButtonAction:(UIButton *)button{
    if (button.tag == 101) {
        YXPayInfoViewController *pay = [[YXPayInfoViewController alloc] init];
        pay.order = self.order;
        [self pushViewController:pay];
    }
}
@end
