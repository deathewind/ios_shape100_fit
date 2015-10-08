//
//  LoginViewController.m
//  HaiShang360
//
//  Created by 何军 on 9/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegistView.h"
#import "FindMMViewController.h"
//#import "Model_user.h"
@interface LoginViewController ()<UIScrollViewDelegate, LoginViewDelegate, RegistViewDelegate, UITextFieldDelegate>



@property(nonatomic, strong) UIScrollView *scrollView;
//@property(nonatomic, strong) UIView *topView;
//@property(nonatomic, strong) UIButton *loginBtn;
//@property(nonatomic, strong) UIButton *registBtn;
@property(nonatomic, strong) LoginView   *loginView;
@property(nonatomic, strong) RegistView   *registView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLeftBtn];
    [self.view addSubview:self.scrollView];

}
- (void)addLeftBtn{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, StatusBarHeight, 60, 44);
    [backBtn setImage:[UIImage imageFileName:@"cd_backBlack.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:backBtn];
    
  //  [self.navBar addSubview:self.topView];
    
    UISegmentedControl *segment_order = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"Login", nil), NSLocalizedString(@"Register", nil)]];
    segment_order.frame = CGRectMake(70, 25, self.view.frame.size.width - 70 * 2, 32);
    segment_order.selectedSegmentIndex = 0;
    segment_order.tintColor = RGB(199, 21, 133);
    [segment_order setTitleTextAttributes:@{NSFontAttributeName :YXCharacterBoldFont(16)} forState:UIControlStateNormal];
    [segment_order addTarget:self action:@selector(didClickButton_segment:) forControlEvents:UIControlEventValueChanged];
    [self.navBar addSubview:segment_order];
}
- (void)didClickButton_segment:(UISegmentedControl *)segment{
    switch (segment.selectedSegmentIndex) {
        case 0:{
            self.loginView.hidden = NO;
            self.registView.hidden = YES;
        }break;
        case 1:{
            self.loginView.hidden = YES;
            self.registView.hidden = NO;
        }break;
        default:
            break;
    }
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navBar.height , ScreenWidth, ScreenHeight - self.navBar.height)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
        _scrollView.delegate = self;
        //[_scrollView addSubview:self.topView];
        [_scrollView addSubview:self.loginView];
        [_scrollView addSubview:self.registView];
    }
    return _scrollView;
}


//- (void)showLoginView:(UIButton *)button{
//    button.selected = YES;
//    self.loginView.hidden = NO;
//    self.registView.hidden = YES;
//    _registBtn.selected = NO;
//   // _registBtn.backgroundColor = RGB(240, 240, 240);
//    button.backgroundColor = [UIColor whiteColor];
//    self.titleBar.text = @"登录";
//}
//- (void)showRegistView:(UIButton *)button{
//    button.selected = YES;
//    self.loginView.hidden = YES;
//    self.registView.hidden = NO;
//    _loginBtn.selected = NO;
//  //  _loginBtn.backgroundColor = RGB(240, 240, 240);
//    button.backgroundColor = [UIColor whiteColor];
//    self.titleBar.text = @"注册";
//}

- (LoginView *)loginView{
    if (!_loginView) {
        _loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.scrollView.frame.size.height - self.navBar.height)];
        _loginView.delegate = self;
    }
    return _loginView;
}
- (RegistView *)registView{
    if (!_registView) {
        _registView = [[RegistView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.scrollView.frame.size.height - self.navBar.height)];
        _registView.delegate = self;
        _registView.txtConPwd.delegate = self;
        _registView.hidden = YES;
    }
    return _registView;
}
#pragma 登录按钮事件
- (void)clickLoginView:(UIButton *)button{
    if (button.tag == 100) {
        [self btnLoginAction];
    }else{
        [self forgetPwd];
    }
}
#pragma 登录
- (void)btnLoginAction{ //登录
    if(self.loginView.txtUser.text.length==0)
    {
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Empty phoneNumber", nil)];
        return;
    }
    if (![UIUtils validateMobile:self.loginView.txtUser.text]){
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Wrong phoneNumber", nil)];
        return;
    }
    if(self.loginView.txtPwd.text.length==0)
    {
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Empty password", nil)];
        return;
    }
    if(self.loginView.txtPwd.text.length < 6)
    {
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Wrong password", nil)];
        return;
    }
    [self.view endEditing:YES];
    if ([UIUtils isConnectNetwork]) {
        [UIUtils showProgressHUDto:self.view withString:NSLocalizedString(@"Logging", nil) showTime:30];
        [[YXNetworkingTool sharedInstance] userLogin:self.loginView.txtUser.text password:self.loginView.txtPwd.text success:^(id JSON) {
            NSString *oauth_token = [JSON objectForKey:@"oauth_token"];
            NSString *oauth_token_secret = [JSON objectForKey:@"oauth_token_secret"];
            NSString *screen_name = [JSON objectForKey:@"screen_name"];
            NSString *user_id = [JSON objectForKey:@"user_id"];
            [[NSUserDefaults standardUserDefaults] setObject:oauth_token forKey:YXToken];
            [[NSUserDefaults standardUserDefaults] setObject:oauth_token_secret forKey:YXTokenSecret];
            [[YXNetworkingTool sharedInstance] getUserInfomation:user_id success:^(id JSON) {
                YXLog(@"%@", JSON);
                [UIUtils hideProgressHUD:self.view];
                [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Login Success", nil)];
                //名字
                if ([JSON[@"name"] isEqualToString:@""] || JSON[@"name"] == nil) {
                    [[NSUserDefaults standardUserDefaults] setObject:screen_name forKey:YXUserName];
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:JSON[@"name"] forKey:YXUserName];
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:YXUserId];
                //性别
                NSString *gender = [NSString stringWithFormat:@"%@", JSON[@"gender"]];
                if ([gender isEqualToString:@"0"]) {
                    [[NSUserDefaults standardUserDefaults] setObject:@"女" forKey:YXUserSex];
                }else if ([gender isEqualToString:@"1"]){
                    [[NSUserDefaults standardUserDefaults] setObject:@"男" forKey:YXUserSex];
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:@"保密" forKey:YXUserSex];
                }
                //头像
                if (![JSON[@"profile_image_url"] isEqualToString:@""]) {
                    UIImage *image = [UIImage imageURLPath:JSON[@"profile_image_url"]];
                    NSString *iconPath = [UIUtils saveMyImage:image];
                    [[NSUserDefaults standardUserDefaults] setObject:iconPath forKey:YXUserIcon];
                }
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            } failure:^(NSError *error, id JSON) {
                YXLog(@"error = %@", JSON);
                [UIUtils hideProgressHUD:self.view];
              //  [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Network", nil)];
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:YXToken];
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:YXTokenSecret];
            }];

        } failure:^(NSError *error, id JSON) {
            YXLog(@"error = %@", JSON);
            [UIUtils hideProgressHUD:self.view];
           // [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Network", nil)];
        }];
    }

}


- (void)forgetPwd{//忘记密码
    FindMMViewController *find = [[FindMMViewController alloc] init];
    [self.navigationController pushViewController:find animated:YES];
}
#pragma 注册按钮事件
- (void)clickRegistView:(UIButton *)button{
    if (button.tag == 100) { //验证码
        [self btnVerifyAction];
    }else{
        [self btnRegistAction];
    }
}
#pragma 发送验证码
- (void)btnVerifyAction{
    if(self.registView.txtUser.text.length==0)
    {
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Empty phoneNumber", nil)];
        return;
    }
    if (![UIUtils validateMobile:self.registView.txtUser.text]){
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Wrong phoneNumber", nil)];
        return;
    }
    [UIUtils showProgressHUDto:self.view withString:NSLocalizedString(@"Sending", nil) showTime:30];
    [[YXNetworkingTool sharedInstance] getVerifyCode:self.registView.txtUser.text success:^(id JSON) {
        YXLog(@"%@", JSON);
        [UIUtils hideProgressHUD:self.view];
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Send Success", nil)];
        [self.registView startBeginTimeCountDown];
    } failure:^(NSError *error, id JSON) {
        [UIUtils hideProgressHUD:self.view];
       // [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Network", nil)];
    }];

}
#pragma 注册
- (void)btnRegistAction{
    if(self.registView.txtUser.text.length==0)
    {
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Empty phoneNumber", nil)];
        return;
    }
    if (![UIUtils validateMobile:self.registView.txtUser.text]){
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Wrong phoneNumber", nil)];
        return;
    }
    if (self.registView.txtCode.text.length == 0){
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Empty code", nil)];
        return;
    }
    if (self.registView.txtPwd.text.length == 0){
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Empty password", nil)];
        return;
    }
    if (self.registView.txtConPwd.text.length == 0){
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Empty password", nil)];
        return;
    }
    if (self.registView.txtConPwd.text.length < 6) {
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Wrong password", nil)];
        return;
    }
    if (![self.registView.txtPwd.text isEqualToString:self.registView.txtConPwd.text]) {
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Same passwork", nil)];
        return;
    }

    [self.view endEditing:YES];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObject:self.registView.txtUser.text forKey:@"phone"];
    [param setObject:self.registView.txtPwd.text forKey:@"password"];
    [param setObject:self.registView.txtCode.text forKey:@"code"];
    [UIUtils showProgressHUDto:self.view withString:NSLocalizedString(@"Registering", nil) showTime:30];
    [[YXNetworkingTool sharedInstance] registWith:param success:^(id JSON) {
        YXLog(@"%@", JSON);
        [UIUtils hideProgressHUD:self.view];
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Register Success", nil)];
        
       // [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"User Name Already Exists", nil)];
    } failure:^(NSError *error, id JSON) {
        YXLog(@"error = %@ ===== %@", error, JSON);
        [UIUtils hideProgressHUD:self.view];
        if (JSON[@"error"]) {
            if ([[NSString stringWithFormat:@"%@", JSON[@"error"]] isEqualToString:@"400"]) {
                [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Already exists", nil)];
                return ;
            }
        }
//        NSHTTPURLResponse *response = (NSHTTPURLResponse *)JSON;
//        if(response.statusCode==400){ //未登陆错误
//            [UIUtils showTextOnly:self.view labelString:@"您还未登录"];
//        }
       // [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Network", nil)];
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect=CGRectMake(0.0f,-100,self.view.frame.size.width,self.view.frame.size.height);
        self.view.frame=rect;
    }];
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect=CGRectMake(0.0f,0,self.view.frame.size.width,self.view.frame.size.height);
        self.view.frame=rect;
    }];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
@end
