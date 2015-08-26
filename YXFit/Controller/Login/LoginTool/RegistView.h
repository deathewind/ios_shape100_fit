//
//  RegistView.h
//  HaiShang360
//
//  Created by 何军 on 10/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RegistViewDelegate <NSObject>

@optional
- (void)clickRegistView:(UIButton *)button;

@end
@interface RegistView : UIView
@property(nonatomic, strong) UITextField *txtUser;
@property(nonatomic, strong) UITextField *txtPwd;

@property(nonatomic, strong) UITextField *txtConPwd;
@property(nonatomic, strong) UITextField *txtCode;
@property(nonatomic, assign) id<RegistViewDelegate>delegate;

- (void)startBeginTimeCountDown;
@end
