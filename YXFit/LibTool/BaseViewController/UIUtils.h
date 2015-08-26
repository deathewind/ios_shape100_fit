//
//  UIUtils.h
//  YXFit
//
//  Created by 何军 on 24/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIUtils : NSObject
+ (NSString *)buildVersion;
+ (NSString *)Version;

+ (BOOL)isConnectNetwork;
#pragma mark - 正则判断手机号 -
/**
 *  正则判断手机号
 */
+ (BOOL)validateMobile:(NSString *)mobileNum;


+ (NSString *)saveMyImage:(UIImage *)image;



+ (void)showTextOnly:(UIView *)view labelString:(NSString *)str;
+ (void)showProgressHUDto:(UIView *)view withString:(NSString *)tipString ;
+ (void)showProgressHUDto:(UIView *)view withString:(NSString *)tipString showTime:(float)time;
+ (void)showProgressHUDto:(UIView *)view below:(UIView *)navView withString:(NSString *)tipString showTime:(float)time;
+ (void)hideProgressHUD:(UIView *)view;
@end
