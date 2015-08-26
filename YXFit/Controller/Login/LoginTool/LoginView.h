//
//  LoginView.h
//  HaiShang360
//
//  Created by 何军 on 10/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginViewDelegate <NSObject>

@optional
- (void)clickLoginView:(UIButton *)button;

@end
@interface LoginView : UIView
@property(nonatomic, strong) UITextField *txtUser;
@property(nonatomic, strong) UITextField *txtPwd;

@property(nonatomic, assign) id<LoginViewDelegate>delegate;
@end
