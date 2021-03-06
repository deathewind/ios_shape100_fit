//
//  LoginView.m
//  HaiShang360
//
//  Created by 何军 on 10/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(20, 40, self.frame.size.width - 40, 44)];
        phoneView.layer.borderWidth = 1;
        phoneView.layer.borderColor = RGB(222, 222, 222).CGColor;
        [self addSubview:phoneView];
        UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 20, 20)];
        imgUser.image = [UIImage imageFileName:@"icon_account"];
        [phoneView addSubview:imgUser];        
        _txtUser = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, phoneView.frame.size.width - 30, phoneView.frame.size.height)];
        _txtUser.placeholder = NSLocalizedString(@"Enter phoneNumber", nil);
        _txtUser.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _txtUser.textAlignment = NSTextAlignmentLeft;
        _txtUser.clearButtonMode = UITextFieldViewModeAlways;
        _txtUser.textColor = [UIColor blackColor];
        _txtUser.keyboardType = UIKeyboardTypePhonePad;
        _txtUser.autocorrectionType = UITextAutocorrectionTypeNo;//去掉首字母大写和自动纠错
        _txtUser.autocapitalizationType = UITextAutocapitalizationTypeNone;//字多自动缩进
        _txtUser.adjustsFontSizeToFitWidth = YES;//缩进最小字体
        _txtUser.minimumFontSize = 20;
        _txtUser.font = YXCharacterFont(16);
        [phoneView addSubview:_txtUser];
        
        UIView *pwdView = [[UIView alloc] initWithFrame:CGRectMake(phoneView.frame.origin.x, phoneView.frame.origin.y + phoneView.frame.size.height + 20, phoneView.frame.size.width, phoneView.frame.size.height)];
        pwdView.layer.borderWidth = 1;
        pwdView.layer.borderColor = RGB(222, 222, 222).CGColor;
        [self addSubview:pwdView];
        UIImageView *imgPwd = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 20, 20)];
        imgPwd.image = [UIImage imageFileName:@"icon_code"];
        [pwdView addSubview:imgPwd];
        _txtPwd = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, pwdView.frame.size.width - 30, pwdView.frame.size.height)];
        _txtPwd.placeholder = NSLocalizedString(@"Enter password", nil);
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
        
        UIButton* btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(phoneView.frame.origin.x, pwdView.frame.origin.y + pwdView.frame.size.height + 20, phoneView.frame.size.width, phoneView.frame.size.height)];
        btnLogin.layer.cornerRadius = 5;
        btnLogin.backgroundColor = RGB(199, 21, 133);
        [btnLogin setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
        btnLogin.tag = 100;
        btnLogin.titleLabel.font = YXCharacterFont(16);
        [btnLogin addTarget:self action:@selector(btnLoginAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnLogin];
        
        
        UIButton *button_forget = [UIButton buttonWithType:UIButtonTypeCustom];
        button_forget.frame = CGRectMake(self.frame.size.width - 130, btnLogin.frame.origin.y + btnLogin.frame.size.height + 20, 120, 20);
        [button_forget setTitle:NSLocalizedString(@"Find passwork", nil) forState:UIControlStateNormal];
        [button_forget setTitleColor:RGB(199, 21, 133) forState:UIControlStateNormal];
        button_forget.titleLabel.font = YXCharacterFont(16);
        button_forget.tag = 101;
        [button_forget addTarget:self action:@selector(btnLoginAction:)forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button_forget];
        
    }
    return self;
}
- (void)btnLoginAction:(UIButton *)button{
    if ([_delegate respondsToSelector:@selector(clickLoginView:)]) {
        [_delegate clickLoginView:button];
    }
}
@end
