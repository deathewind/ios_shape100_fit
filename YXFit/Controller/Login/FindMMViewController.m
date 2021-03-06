//
//  FindMMViewController.m
//  HaiShang360
//
//  Created by 何军 on 11/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "FindMMViewController.h"

@interface FindMMViewController ()<UIScrollViewDelegate, UITextFieldDelegate>
{
    __weak UIButton *_btnVerify;
    NSTimer *_timer_countDown;
    NSInteger _time_countDown;
}
@property(nonatomic, strong) UIScrollView *scrollView;
@end

@implementation FindMMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleBar.text = NSLocalizedString(@"Find passwork", nil);
    [self.view addSubview:self.scrollView];
   // [self.view insertSubview:self.scrollView belowSubview:self.navBar];
    [self creatBackButton];
    // Do any additional setup after loading the view.
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.navBar.frame.size.height)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height );
        _scrollView.delegate = self;
        [self addSubViews:_scrollView];
    }
    return _scrollView;
}
- (void)addSubViews:(UIScrollView *)scrollView{
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(20, 40, scrollView.frame.size.width - 40, 44)];
    phoneView.layer.borderWidth = 1;
    phoneView.layer.borderColor = RGB(222, 222, 222).CGColor;
    [scrollView addSubview:phoneView];
    UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 20, 20)];
    imgUser.image = [UIImage imageFileName:@"icon_account"];
    [phoneView addSubview:imgUser];
    _txtUser = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, phoneView.frame.size.width - 30, phoneView.frame.size.height)];
    _txtUser.placeholder = NSLocalizedString(@"Enter your phoneNumber", nil);
    _txtUser.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _txtUser.textAlignment = NSTextAlignmentLeft;
    _txtUser.clearButtonMode = UITextFieldViewModeAlways;
    _txtUser.textColor = [UIColor blackColor];
    _txtUser.keyboardType = UIKeyboardTypePhonePad;
    _txtUser.autocorrectionType = UITextAutocorrectionTypeNo;//去掉首字母大写和自
    _txtUser.autocapitalizationType = UITextAutocapitalizationTypeNone;//字多自动缩进
    _txtUser.adjustsFontSizeToFitWidth = YES;//缩进最小字体
    _txtUser.minimumFontSize = 20;
    _txtUser.font = YXCharacterFont(16);
    [phoneView addSubview:_txtUser];
    
    UIView *verifyView = [[UIView alloc] initWithFrame:CGRectMake(phoneView.frame.origin.x, phoneView.frame.origin.y + phoneView.frame.size.height + 20, phoneView.frame.size.width, phoneView.frame.size.height)];
    verifyView.layer.borderWidth = 1;
    verifyView.layer.borderColor = RGB(222, 222, 222).CGColor;
    [scrollView addSubview:verifyView];
    UIImageView *imgVerifyView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 20, 20)];
    imgVerifyView.image = [UIImage imageFileName:@"icon_code"];
    [verifyView addSubview:imgVerifyView];
    _txtCode = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, verifyView.frame.size.width - 30 - 100, verifyView.frame.size.height)];
    _txtCode.placeholder = NSLocalizedString(@"Code passwork", nil);
    _txtCode.font = YXCharacterFont(16);
    _txtCode.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _txtCode.autocorrectionType = UITextAutocorrectionTypeNo;
    _txtCode.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _txtCode.adjustsFontSizeToFitWidth = YES;
    _txtCode.textAlignment = NSTextAlignmentLeft;
    _txtCode.minimumFontSize = 20;
    [verifyView addSubview:_txtCode];
    UIButton *btnVerify = [[UIButton alloc] initWithFrame:CGRectMake(_txtCode.frame.origin.x +_txtCode.frame.size.width, 0, verifyView.frame.size.width - _txtCode.frame.origin.x - _txtCode.frame.size.width, verifyView.frame.size.height)];
    btnVerify.tag = 100;
    [btnVerify addTarget:self action:@selector(btnFindMMAction:) forControlEvents:UIControlEventTouchUpInside];
    btnVerify.layer.cornerRadius = 5;
    btnVerify.backgroundColor = RGB(199, 21, 133);
    btnVerify.titleLabel.font = YXCharacterFont(15);
    _btnVerify = btnVerify;
    [btnVerify setTitle:NSLocalizedString(@"Code", nil) forState:UIControlStateNormal];
    [verifyView addSubview:btnVerify];
    
    UIView *pwdView = [[UIView alloc] initWithFrame:CGRectMake(verifyView.frame.origin.x, verifyView.frame.origin.y + verifyView.frame.size.height + 20, verifyView.frame.size.width, verifyView.frame.size.height)];
    pwdView.layer.borderWidth = 1;
    pwdView.layer.borderColor = RGB(222, 222, 222).CGColor;
    [scrollView addSubview:pwdView];
    UIImageView *imgPwd = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 20, 20)];
    imgPwd.image = [UIImage imageFileName:@"icon_code"];
    [pwdView addSubview:imgPwd];
    _txtPwd = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, pwdView.frame.size.width - 30, pwdView.frame.size.height)];
    _txtPwd.placeholder = NSLocalizedString(@"Set password", nil);
    _txtPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _txtPwd.font = YXCharacterFont(16);
    _txtPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _txtPwd.textColor = [UIColor blackColor];
    _txtPwd.textAlignment = NSTextAlignmentLeft;
    _txtPwd.clearButtonMode = UITextFieldViewModeAlways;
    _txtPwd.secureTextEntry = YES;
    _txtPwd.autocorrectionType = UITextAutocorrectionTypeNo;
    _txtPwd.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _txtPwd.adjustsFontSizeToFitWidth = YES;
    _txtPwd.minimumFontSize = 20;
    [pwdView addSubview:_txtPwd];
    
    UIView *pwdConView = [[UIView alloc] initWithFrame:CGRectMake(pwdView.frame.origin.x, pwdView.frame.origin.y + pwdView.frame.size.height + 20, pwdView.frame.size.width, pwdView.frame.size.height)];
    pwdConView.layer.borderWidth = 1;
    pwdConView.layer.borderColor = RGB(222, 222, 222).CGColor;
    [scrollView addSubview:pwdConView];
    UIImageView *imgConPwd = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 20, 20)];
    imgConPwd.image = [UIImage imageFileName:@"icon_code"];
    [pwdConView addSubview:imgConPwd];
    _txtConPwd = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, pwdConView.frame.size.width - 30, pwdConView.frame.size.height)];
    _txtConPwd.placeholder = NSLocalizedString(@"Confirm password", nil);
    _txtConPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _txtConPwd.font = YXCharacterFont(16);
    _txtConPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _txtConPwd.textColor = [UIColor blackColor];
    _txtConPwd.textAlignment = NSTextAlignmentLeft;
    _txtConPwd.clearButtonMode = UITextFieldViewModeAlways;
    _txtConPwd.secureTextEntry = YES;
    _txtConPwd.autocorrectionType = UITextAutocorrectionTypeNo;
    _txtConPwd.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _txtConPwd.adjustsFontSizeToFitWidth = YES;
    _txtConPwd.minimumFontSize = 20;
    _txtConPwd.delegate = self;
    [pwdConView addSubview:_txtConPwd];
    
    UIButton *btnRegist = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRegist.frame = CGRectMake(pwdConView.frame.origin.x, pwdConView.frame.origin.y + pwdConView.frame.size.height + 20, pwdConView.frame.size.width, pwdConView.frame.size.height);
    [btnRegist setTitle:NSLocalizedString(@"Reset password", nil) forState:UIControlStateNormal];
    btnRegist.layer.cornerRadius = 5;
    btnRegist.backgroundColor = RGB(199, 21, 133);
    btnRegist.tag = 101;
    btnRegist.titleLabel.font = YXCharacterFont(16);
    [btnRegist addTarget:self action:@selector(btnFindMMAction:)forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btnRegist];
}
- (void)btnFindMMAction:(UIButton *)button{
    if (button.tag == 100) {
        [self btnVerifyAction];
    }else{
        [self findMMAction];
    }
}

- (void)findMMAction{ //找回密码
    if (_txtCode.text.length == 0){
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Empty phoneNumber", nil)];
        return;
    }
    if (![UIUtils validateMobile:_txtUser.text]){
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Wrong phoneNumber", nil)];
        return;
    }
    if (_txtPwd.text.length == 0){
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Empty password", nil)];
        return;
    }
    if (_txtConPwd.text.length < 6) {
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Wrong password", nil)];
        return;
    }
    if (_txtConPwd.text.length == 0){
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Empty password", nil)];
        return;
    }
    if (![_txtPwd.text isEqualToString:_txtConPwd.text]) {
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Same passwork", nil)];
        return;
    }
    [UIUtils showProgressHUDto:self.view withString:nil showTime:30];
    
    NSDictionary *paraDic=@{@"phone":_txtUser.text, @"token":_txtCode.text, @"new_password":_txtPwd.text};
    [[YXNetworkingTool sharedInstance] findPassword:paraDic success:^(id JSON) {
        [UIUtils hideProgressHUD:self.view];
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Reset Success", nil)];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError *error, id JSON) {
        [UIUtils hideProgressHUD:self.view];
       // [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Network", nil)];
    }];

}


- (void)btnVerifyAction{
    if(_txtUser.text.length==0)
    {
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Empty phoneNumber", nil)];
        return;
    }
    if (![UIUtils validateMobile:_txtUser.text]){
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Wrong phoneNumber", nil)];
        return;
    }

    [UIUtils showProgressHUDto:self.view withString:NSLocalizedString(@"Sending", nil) showTime:30];
    [[YXNetworkingTool sharedInstance] getVerifyCode:_txtUser.text success:^(id JSON) {
        [UIUtils hideProgressHUD:self.view];
        [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Send Success", nil)];
        [_btnVerify setUserInteractionEnabled:NO];
        [_btnVerify setBackgroundColor:[UIColor grayColor]];
        [self startBeginTimeCountDown];
    } failure:^(NSError *error, id JSON) {
        [UIUtils hideProgressHUD:self.view];
      //  [UIUtils showTextOnly:self.view labelString:NSLocalizedString(@"Network", nil)];
    }];

}

- (void)startBeginTimeCountDown{
    _time_countDown = 60;
    NSTimer *timer_count = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    _timer_countDown = timer_count;
}

#pragma mark 开始发送读秒
- (void)runTimePage
{
    _time_countDown --;
    NSString *string_countDown = [NSString stringWithFormat:@"%ld(s)",(long)_time_countDown];
    [_btnVerify setTitle:string_countDown forState:UIControlStateNormal];
    if(_time_countDown == 0){
        [self stopTimePage];
    }
}

#pragma mark 停止计时器
- (void)stopTimePage
{
    [_btnVerify setUserInteractionEnabled:YES];
    _btnVerify.backgroundColor = RGB(199, 21, 133);
    [_btnVerify setTitle:NSLocalizedString(@"Code", nil) forState:UIControlStateNormal];
    if(_timer_countDown) {
        [_timer_countDown invalidate];
        _timer_countDown = nil;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect=CGRectMake(0.0f,-120,self.view.frame.size.width,self.view.frame.size.height);
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
