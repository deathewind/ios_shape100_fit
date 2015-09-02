//
//  YXShareCenter.h
//  YXClient
//
//  Created by 张明磊 on 14-9-2.
//  Copyright (c) 2014年 张明磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WeiboSDK.h"

#pragma mark - 分享中心 -
/**
 *  分享中心
 */

typedef NS_ENUM(NSInteger, YXShareTag){
    //微信(授权及发送给好友)
    YXShareTag_WX              = 0,
    //微信发送至朋友圈
    YXShareTag_WXFriends        ,
    //微博
    YXShareTag_WeiBo              ,
};

typedef NS_ENUM(NSInteger, YXResultCode){
    YXResultCode_succeed          = 0,
    YXResultCode_failed                    ,
};

#pragma mark - 消息系统 -
/**
 *  消息系统
 */
FOUNDATION_EXPORT NSString *const notification_wxCallBack;

@interface YXShareCenter : NSObject


#pragma mark - 注册app -
/**
 *  注册app
 *
 *  @param string_appid   注册app
 */
+ (void)registerAppTag:(YXShareTag )tag;

+ (BOOL) handleOpenURL:(NSURL *)url andTag:(YXShareTag)tag;
+ (BOOL) handleOpenURL:(NSURL *)url andTag:(YXShareTag)tag atViewController:(UIViewController *)viewController;


#pragma mark - 检测是否安装微信 -
/**
 *  检测是否安装微信
 */
+ (BOOL)isHaveWX;

/**
 *  检测是否安装微信
 */
+ (BOOL)isHaveWeibo;

@end
