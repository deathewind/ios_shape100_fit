//
//  YXPayViewController.m
//  YXClient
//
//  Created by 何军 on 6/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "YXPayViewController.h"
#import "Pingpp.h"
#import "PayView.h"
#import "MoneyView.h"
#import "DescribeView.h"
#import "Model_order.h"

#import "YXOrderDetailViewController.h"
#define kUrlScheme      @"iosshape100fitapp"
@interface YXPayViewController ()
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) PayView *payView;
@property(nonatomic, strong) NSString *payString;
@property(nonatomic, strong) MoneyView *moneyView;
@property(nonatomic, strong) DescribeView *describeView;
@end

@implementation YXPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(240, 240, 240);
    self.titleBar.text = @"订单支付";
    // Do any additional setup after loading the view.
    [self.view addSubview:self.scrollView];
    _payString = WEIX;
    [self creatBackButton];
    [self addPayButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderDetailShow) name:YXPaySuccessNoti object:nil];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navBar.height, ScreenWidth, ScreenHeight - self.navBar.height)];
        _scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
        [_scrollView addSubview:self.payView];
        [_scrollView addSubview:self.moneyView];
        [_scrollView addSubview:self.describeView];
    }
    return _scrollView;
}
- (PayView *)payView{
    if (!_payView) {
        _payView = [[PayView alloc] initWithFrame:CGRectMake(0, 10, _scrollView.width, 120)];
        _payView.payChange = ^(NSString *payStr){
            NSLog(@"%@",payStr);
            _payString = payStr;
        };
    }
    return _payView;
}
- (MoneyView *)moneyView{
    if (!_moneyView) {
        _moneyView = [[MoneyView alloc] initWithFrame:CGRectMake(0, self.payView.frame.size.height + self.payView.origin.y + 10, _scrollView.width, 206)];
        _moneyView.totel.text = [NSString stringWithFormat:@"%@元", self.order.order_payment];
        _moneyView.coupon.text = @"0元";
        _moneyView.balance.text = @"0元";
        _moneyView.payOnline.text = [NSString stringWithFormat:@"%@元", self.order.order_payment];;
    }
    return _moneyView;
}

- (DescribeView *)describeView{
    if (!_describeView) {
         //182
        NSString *tips = @"网上支付扣款后,看订单山莨菪碱佛前金鹏飞进去陪我饥饿法撒旦发生的法律是地方是滴是滴飞， 阿加速度来飞机票钱未付激情片阿斯顿解放辣椒是劳动节佛前戊二醛，将连接片去哦额文件看得见放辣椒是大家佛尔uoqplaldjf，了垃圾大佛去偶尔陪。按键都疯啦.";
        CGSize textSize = [tips boundingRectWithSize:CGSizeMake(ScreenWidth - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:YXCharacterFont(16)} context:nil].size;
        _describeView = [[DescribeView alloc] initWithFrame:CGRectMake(0, self.moneyView.height + self.moneyView.origin.y + 30, _scrollView.width, textSize.height)];
        [_describeView setDescribe:tips];
    }
    return _describeView;
}
- (void)addTipsView{
    
    //CGSize  textSize = [tips sizeWithFont:YXCharacterBoldFont(16) constrainedToSize:CGSizeMake(ScreenWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    

//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, self.moneyView.frame.size.height + self.moneyView.frame.origin.y + 50, _scrollView.frame.size.width - 10 * 2, textSize.height)];
//    label.font = YXCharacterFont(15);
//    label.text = tips;
//    label.numberOfLines = 0;
//    label.backgroundColor = [UIColor whiteColor];
//    [_scrollView addSubview:label];
}
- (void)addPayButton{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, ScreenHeight - 44, ScreenWidth, 44);
    [button setTitle:@"立即支付" forState:UIControlStateNormal];
    button.backgroundColor = RGB(199, 21, 133);
    [button addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)pay{
    [UIUtils showProgressHUDto:self.view withString:nil showTime:60];
  //  YXPayViewController * __weak weakSelf = self;_payString
    [[YXNetworkingTool sharedInstance] payWithOrder:self.order.order_id channel:_payString success:^(id JSON) {
        [UIUtils hideProgressHUD:self.view];
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:JSON options:NSJSONWritingPrettyPrinted error:&parseError];
        NSString *string =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        [[NSUserDefaults standardUserDefaults] setObject:self.order.order_id forKey:@"orderID"];
//        [[NSUserDefaults standardUserDefaults] synchronize];

//        [self.navigationController popToRootViewControllerAnimated:YES];
//        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
//        [appDelegate.tabbar changeIndex:2];
        [Pingpp createPayment:string appURLScheme:kUrlScheme withCompletion:^(NSString *result, PingppError *error) {
            YXLog(@"111111completion block: %@", result);
            if (error == nil) {
                YXLog(@"11111111PingppError is nil");
            } else {
                YXLog(@"111111PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
            }

        }];
        
//        [Pingpp createPayment:string viewController:weakSelf appURLScheme:kUrlScheme withCompletion:^(NSString *result, PingppError *error) {
//            [self.navigationController popToRootViewControllerAnimated:YES];
//            AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
//            [appDelegate.tabbar changeIndex:2];
//            NSLog(@"completion block: %@", result);
//            if (error == nil) {
//                NSLog(@"PingppError is nil");
//            } else {
//                NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
//            }
//            // [weakSelf showAlertMessage:result];
//        }];
        
        YXLog(@"JSON = %@", JSON);
    } failure:^(NSError *error, id JSON) {
        [UIUtils hideProgressHUD:self.view];
        YXLog(@"error = %@ ---- %@ ---- %d", error, JSON, error.code);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)JSON;
        if (response.statusCode != 401 && response.statusCode != 0 && response != NULL) {
            [UIUtils showTextOnly:self.view labelString:@"支付失败"];
        }
       // [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Network", nil)];
    }];

}

- (void)orderDetailShow{
    [UIUtils showTextOnly:self.view labelString:@"支付成功" time:2];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (_isMyPush) {
            [self.navigationController popViewControllerAnimated:YES];
          //  [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        }else{
            [[YXTabBarView sharedInstance] showAnimation];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }

    });
    
//    YXOrderDetailViewController *orderDetail = [[YXOrderDetailViewController alloc] init];
//    orderDetail.orderID = self.order.order_id;
//    [self pushViewController:orderDetail];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YXPaySuccessNoti object:nil];
}
@end
