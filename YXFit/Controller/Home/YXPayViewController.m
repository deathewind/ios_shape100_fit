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

#import "Model_order.h"
#define kUrlScheme      @"iosshape100fitapp"
@interface YXPayViewController ()
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) PayView *payView;
@property(nonatomic, strong) NSString *payString;
@property(nonatomic, strong) MoneyView *moneyView;

@end

@implementation YXPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(240, 240, 240);
    self.titleBar.text = @"订单支付";
    // Do any additional setup after loading the view.
    [self.view addSubview:self.scrollView];
    _payString = @"wx";
    
    [self addPayButton];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navBar.height, ScreenWidth, ScreenHeight - self.navBar.height)];
        _scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
        [_scrollView addSubview:self.payView];
        [_scrollView addSubview:self.moneyView];
        [self addTipsView];
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
        _moneyView = [[MoneyView alloc] initWithFrame:CGRectMake(0, self.payView.frame.size.height + 20, _scrollView.width, 170)]; //182
        _moneyView.totel.text = [NSString stringWithFormat:@"%@元", self.order.order_payment];
        _moneyView.coupon.text = @"0元";
        _moneyView.balance.text = @"0元";
        _moneyView.payOnline.text = [NSString stringWithFormat:@"%@元", self.order.order_payment];;
    }
    return _moneyView;
}


- (void)addTipsView{
    NSString *tips = @"网上支付扣款后,看订单山莨菪碱佛前金鹏飞进去陪我饥饿法撒旦发生的法律是地方是滴是滴飞， 阿加速度来飞机票钱未付激情片阿斯顿解放辣椒是劳动节佛前戊二醛，将连接片去哦额文件看得见放辣椒是大家佛尔uoqplaldjf，了垃圾大佛去偶尔陪。按键都疯啦.";
    //CGSize  textSize = [tips sizeWithFont:YXCharacterBoldFont(16) constrainedToSize:CGSizeMake(ScreenWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize textSize = [tips boundingRectWithSize:CGSizeMake(ScreenWidth - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:YXCharacterFont(16)} context:nil].size;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, self.moneyView.frame.size.height + self.moneyView.frame.origin.y + 50, _scrollView.frame.size.width - 10 * 2, textSize.height)];
    label.font = YXCharacterFont(15);
    label.text = tips;
    label.numberOfLines = 0;
    [self.scrollView addSubview:label];
}
- (void)addPayButton{
    UIButton *button_back = [UIButton buttonWithType:UIButtonTypeCustom];
    button_back.frame = CGRectMake(0, 20, 60, 44);
    button_back.showsTouchWhenHighlighted = YES;
    [button_back setImage:[UIImage imageFileName:@"cd_back.png"] forState:UIControlStateNormal];
    [button_back addTarget:self action:@selector(clickButton_back)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_back];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, ScreenHeight - 50, ScreenWidth, 50);
    [button setTitle:@"立即支付" forState:UIControlStateNormal];
    button.backgroundColor = RGB(156, 210, 122);
    [button addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)pay{
    [UIUtils showProgressHUDto:self.view withString:nil showTime:60];
    YXPayViewController * __weak weakSelf = self;
    [[YXNetworkingTool sharedInstance] payWithOrder:self.order.order_id channel:_payString success:^(id JSON) {
        [UIUtils hideProgressHUD:self.view];
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:JSON options:NSJSONWritingPrettyPrinted error:&parseError];
        NSString *string =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [Pingpp createPayment:string viewController:weakSelf appURLScheme:kUrlScheme withCompletion:^(NSString *result, PingppError *error) {
            NSLog(@"completion block: %@", result);
            if (error == nil) {
                NSLog(@"PingppError is nil");
            } else {
                NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
            }
            // [weakSelf showAlertMessage:result];
        }];
        
        NSLog(@"JSON = %@", JSON);
    } failure:^(NSError *error, id JSON) {
        [UIUtils hideProgressHUD:self.view];
        NSLog(@"error = %@", error);
    }];

}
@end
