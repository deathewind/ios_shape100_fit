//
//  YXPayInfoViewController.m
//  YXFit
//
//  Created by 何军 on 25/9/15.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "YXPayInfoViewController.h"
#import "DetailCell.h"
#import "PayInfoCell.h"
#import "Pingpp.h"


#define kUrlScheme      @"iosshape100fitapp"
#define WEIX @"wx"
#define ALIPAY @"alipay"
@interface YXPayInfoViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSIndexPath *indexPath;

@property(nonatomic, strong) NSString    *payString;
@end

@implementation YXPayInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleBar.text = @"订单支付";
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    //返回按钮
    [self creatBackButton];
    //支付按钮
    [self addPayButton];
    //开始为微信支付
    _payString = WEIX;
    
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderDetailShow) name:YXPaySuccessNoti object:nil];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navBar.height, ScreenWidth, ScreenHeight - self.navBar.height - 44) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = RGB(240, 240, 240);
        NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_tableView selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    return _tableView;
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
    [[YXNetworkingTool sharedInstance] payWithOrder:self.order.order_id channel:_payString success:^(id JSON) {
        [UIUtils hideProgressHUD:self.view];
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:JSON options:NSJSONWritingPrettyPrinted error:&parseError];
        NSString *string =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
        appDelegate.orderID = self.order.order_id;
        
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
        YXLog(@"error = %@ ---- %@ ---- %ld", error, JSON, (long)error.code);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)JSON;
        if (response.statusCode != 401 && response.statusCode != 0 && response != NULL) {
            [UIUtils showTextOnly:self.view labelString:@"支付失败"];
        }
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if(section == 1){
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"weixCell";
            PayInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil){
                cell = [[PayInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell setIcon:@"weixin" callName:@"微信支付"];
            return cell;
        }
        static NSString *CellIdentifier = @"alipayCell";
        PayInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
            cell = [[PayInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setIcon:@"alipay" callName:@"支付宝"];
        return cell;
        
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"totelCell";
            DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil){
                cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier cellHeight:44];
            }
            [cell setLeftString:@"总金额" rightString:[NSString stringWithFormat:@"%@元",self.order.order_payment]];
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
            [cell setLeftString:@"账户余额" rightString:@"0元"];
            return cell;
            
        }else if (indexPath.row == 3){
            static NSString *CellIdentifier = @"payOnlineCell";
            DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil){
                cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier cellHeight:44];
            }
            [cell setLeftString:@"在线支付" rightString:[NSString stringWithFormat:@"%@元",self.order.order_payment]];
            return cell;
        }

    }else{
        static NSString *CellIdentifier = @"infoCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = YXCharacterFont(15);
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.textColor = RGB(60, 60, 60);
        }
        cell.textLabel.text = @"网上支付扣款后,看订单山莨菪碱佛前金鹏飞进去陪我饥饿法撒旦发生的法律是地方是滴是滴飞， 阿加速度来飞机票钱未付激情片阿斯顿解放辣椒是劳动节佛前戊二醛，将连接片去哦额文件看得见放辣椒是大家佛尔uoqplaldjf，了垃圾大佛去偶尔陪。按键都疯啦";
        return cell;
    }
    
    return nil;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        _indexPath = indexPath;
        if (indexPath.row == 0) {
            _payString = WEIX;
        }else{
            _payString = ALIPAY;
        }
        
    }else if(indexPath.section == 1){
        
    }else{
        
    }
    
    [tableView selectRowAtIndexPath:_indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        return 44;
    }else if (indexPath.section == 1){
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
        return @"选择支付方式";
    }else if (section == 1){
        return @"支付金额";
    }
    return @"支付提示";
}



@end
