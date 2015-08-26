//
//  YXOrderDetailViewController.m
//  YXClient
//
//  Created by 何军 on 13/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "YXOrderDetailViewController.h"
#import "OrderPayView.h"
#import "Model_order.h"
#import "OrderNumView.h"
@interface YXOrderDetailViewController ()
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) Model_order    *order;
@property(nonatomic, strong) OrderNumView   *numView;
@property(nonatomic, strong) OrderPayView   *payView;
@end

@implementation YXOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleBar.text = @"订单详情";
    self.view.backgroundColor = RGB(240, 240, 240);
    [self.view addSubview:self.scrollView];
    [self getOrderData];
    [self addBackButton];
}
- (void)getOrderData{
    [UIUtils showProgressHUDto:self.view withString:nil showTime:30];
    [[YXNetworkingTool sharedInstance] getOrderDetailWithID:self.orderID success:^(id JSON) {
        [UIUtils hideProgressHUD:self.view];
        self.order = [Model_order orderWithDictionary:JSON];
       // [self.view addSubview:self.scrollView];
        [self.numView setNum:self.order.order_id andStatus:self.order.order_status];
        if ([self.order.order_status isEqualToString:@"0"]) {
            [self addPayButton];
        }
        self.payView.totel.text = [NSString stringWithFormat:@"%@元", self.order.order_payment];
        self.payView.coupon.text = @"0元";
        self.payView.balance.text = @"0元";
        self.payView.payOnline.text = @"0元";
    } failure:^(NSError *error, id JSON) {
        [UIUtils hideProgressHUD:self.view];
    }];
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navBar.height, ScreenWidth, ScreenHeight - self.navBar.height)];
        _scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
        [_scrollView addSubview:self.numView];
        [_scrollView addSubview:self.payView];
    }
    return _scrollView;
}
- (OrderNumView *)numView{
    if (!_numView) {
        _numView = [[OrderNumView alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth - 10 * 2, 40)];
        
    }
    return _numView;
}
- (OrderPayView *)payView{
    if (!_payView) {
        _payView = [[OrderPayView alloc] initWithFrame:CGRectMake(10, _numView.frame.size.height + 20, ScreenWidth - 10 * 2, 220)];
        
    }
    return _payView;
}

- (void)addBackButton{
    UIButton *button_back = [UIButton buttonWithType:UIButtonTypeCustom];
    button_back.frame = CGRectMake(0, 20, 60, 44);
    button_back.showsTouchWhenHighlighted = YES;
    [button_back setImage:[UIImage imageFileName:@"cd_back.png"] forState:UIControlStateNormal];
    [button_back addTarget:self action:@selector(clickButton_back)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_back];
}

- (void)addPayButton{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 44, ScreenWidth, 44)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(10, 2, view.frame.size.width / 2 - 30 /2, 40);
    [cancel setTitle:@"订单取消" forState:UIControlStateNormal];
    cancel.titleLabel.font = YXCharacterFont(15);
    [cancel setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    cancel.layer.cornerRadius = 5;
    cancel.layer.borderWidth = 1;
    cancel.layer.borderColor = [UIColor orangeColor].CGColor;
    [view addSubview:cancel];
    
    UIButton *pay = [UIButton buttonWithType:UIButtonTypeCustom];
    pay.frame = CGRectMake(cancel.frame.size.width + cancel.frame.origin.x + 5, 2, cancel.frame.size.width , 40);
    [pay setTitle:@"立即支付" forState:UIControlStateNormal];
    pay.titleLabel.font = YXCharacterFont(15);
    [pay setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    pay.layer.cornerRadius = 5;
    pay.layer.borderWidth = 1;
    pay.layer.borderColor = [UIColor orangeColor].CGColor;
    [view addSubview:pay];
}
@end
