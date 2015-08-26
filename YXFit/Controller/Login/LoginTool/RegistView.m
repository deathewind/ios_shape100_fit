//
//  RegistView.m
//  HaiShang360
//
//  Created by 何军 on 10/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "RegistView.h"
@interface RegistView()
{
    __weak UIButton *_btnVerify;
    NSTimer *_timer_countDown;
    NSInteger _time_countDown;
}
@end
@implementation RegistView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(25, 40, self.frame.size.width - 50, 44)];
        phoneView.layer.borderWidth = 1;
        phoneView.layer.borderColor = RGB(222, 222, 222).CGColor;
        [self addSubview:phoneView];
        UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 20, 20)];
        imgUser.image = [UIImage imageFileName:@"icon_account"];
        [phoneView addSubview:imgUser];
        _txtUser = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, phoneView.frame.size.width - 30, phoneView.frame.size.height)];
        _txtUser.placeholder = @"请输入您的手机号码";
        _txtUser.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _txtUser.textAlignment = NSTextAlignmentLeft;
        _txtUser.clearButtonMode = UITextFieldViewModeAlways;
        _txtUser.textColor = [UIColor blackColor];
        _txtUser.keyboardType = UIKeyboardTypePhonePad;
        _txtUser.autocorrectionType = UITextAutocorrectionTypeNo;//去掉首字母大写和自
        _txtUser.autocapitalizationType = UITextAutocapitalizationTypeNone;//字多自动缩进
        _txtUser.adjustsFontSizeToFitWidth = YES;//缩进最小字体
        _txtUser.minimumFontSize = 20;
        _txtUser.font = [UIFont systemFontOfSize:16];
        [phoneView addSubview:_txtUser];
        
        UIView *verifyView = [[UIView alloc] initWithFrame:CGRectMake(phoneView.frame.origin.x, phoneView.frame.origin.y + phoneView.frame.size.height + 20, phoneView.frame.size.width, phoneView.frame.size.height)];
        verifyView.layer.borderWidth = 1;
        verifyView.layer.borderColor = RGB(222, 222, 222).CGColor;
        [self addSubview:verifyView];
        UIImageView *imgVerifyView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 20, 20)];
        imgVerifyView.image = [UIImage imageFileName:@"icon_code"];
        [verifyView addSubview:imgVerifyView];
        _txtCode = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, verifyView.frame.size.width - 30 - 100, verifyView.frame.size.height)];
        _txtCode.placeholder = @"请填写短信验证码";
        _txtCode.font = [UIFont systemFontOfSize:16];
        _txtCode.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _txtCode.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtCode.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _txtCode.adjustsFontSizeToFitWidth = YES;
        _txtCode.textAlignment = NSTextAlignmentLeft;
        _txtCode.minimumFontSize = 20;
        [verifyView addSubview:_txtCode];
        UIButton *btnVerify = [[UIButton alloc] initWithFrame:CGRectMake(_txtCode.frame.origin.x +_txtCode.frame.size.width, 0, verifyView.frame.size.width - _txtCode.frame.origin.x - _txtCode.frame.size.width, verifyView.frame.size.height)];
        btnVerify.tag = 100;
        [btnVerify addTarget:self action:@selector(btnRegistAction:) forControlEvents:UIControlEventTouchUpInside];
        btnVerify.layer.cornerRadius = 5;
        btnVerify.backgroundColor = [UIColor orangeColor];
        btnVerify.titleLabel.font = [UIFont systemFontOfSize:15];
        _btnVerify = btnVerify;
        [btnVerify setTitle:@"获取验证码" forState:UIControlStateNormal];
        [verifyView addSubview:btnVerify];
        
        UIView *pwdView = [[UIView alloc] initWithFrame:CGRectMake(verifyView.frame.origin.x, verifyView.frame.origin.y + verifyView.frame.size.height + 20, verifyView.frame.size.width, verifyView.frame.size.height)];
        pwdView.layer.borderWidth = 1;
        pwdView.layer.borderColor = RGB(222, 222, 222).CGColor;
        [self addSubview:pwdView];
        UIImageView *imgPwd = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 20, 20)];
        imgPwd.image = [UIImage imageFileName:@"icon_code"];
        [pwdView addSubview:imgPwd];
        _txtPwd = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, pwdView.frame.size.width - 30, pwdView.frame.size.height)];
        _txtPwd.placeholder = @"请设置密码";
        _txtPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
        _txtPwd.font = [UIFont systemFontOfSize:16];
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
        [self addSubview:pwdConView];
        UIImageView *imgConPwd = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 20, 20)];
        imgConPwd.image = [UIImage imageFileName:@"icon_code"];
        [pwdConView addSubview:imgConPwd];
        _txtConPwd = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, pwdConView.frame.size.width - 30, pwdConView.frame.size.height)];
        _txtConPwd.placeholder = @"请确认密码";
        _txtConPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
        _txtConPwd.font = [UIFont systemFontOfSize:16];
        _txtConPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _txtConPwd.textColor = [UIColor blackColor];
        _txtConPwd.textAlignment = NSTextAlignmentLeft;
        _txtConPwd.clearButtonMode = UITextFieldViewModeAlways;
        _txtConPwd.secureTextEntry = YES;
        _txtConPwd.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtConPwd.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _txtConPwd.adjustsFontSizeToFitWidth = YES;
        _txtConPwd.minimumFontSize = 20;
        [pwdConView addSubview:_txtConPwd];
        
        UIButton *btnRegist = [UIButton buttonWithType:UIButtonTypeCustom];
        btnRegist.frame = CGRectMake(pwdConView.frame.origin.x, pwdConView.frame.origin.y + pwdConView.frame.size.height + 20, pwdConView.frame.size.width, pwdConView.frame.size.height);
        [btnRegist setTitle:@"注册" forState:UIControlStateNormal];
        btnRegist.layer.cornerRadius = 5;
        btnRegist.backgroundColor = [UIColor orangeColor];
        btnRegist.tag = 101;
        [btnRegist addTarget:self action:@selector(btnRegistAction:)forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnRegist];
        
    }
    return self;
}
- (void)btnRegistAction:(UIButton *)button{

    if ([_delegate respondsToSelector:@selector(clickRegistView:)]) {
        [_delegate clickRegistView:button];
    }
}

- (void)startBeginTimeCountDown{
    [_btnVerify setUserInteractionEnabled:NO];
    [_btnVerify setBackgroundColor:[UIColor grayColor]];
    _time_countDown = 60;
    NSTimer *timer_count = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    _timer_countDown = timer_count;
}

#pragma mark 开始发送读秒
- (void)runTimePage
{
    _time_countDown --;
    NSString *string_countDown = [NSString stringWithFormat:@"%ld秒",(long)_time_countDown];
    [_btnVerify setTitle:string_countDown forState:UIControlStateNormal];
    if(_time_countDown == 0){
        [self stopTimePage];
    }
}

#pragma mark 停止计时器
- (void)stopTimePage
{
    [_btnVerify setUserInteractionEnabled:YES];
    _btnVerify.backgroundColor = [UIColor orangeColor];
    [_btnVerify setTitle:@"获取验证码" forState:UIControlStateNormal];
    if(_timer_countDown) {
        [_timer_countDown invalidate];
        _timer_countDown = nil;
    }
}
@end
