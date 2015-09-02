//
//  YXShareCenter.m
//  YXClient
//
//  Created by 张明磊 on 14-9-2.
//  Copyright (c) 2014年 张明磊. All rights reserved.
//

#import "YXShareCenter.h"

//#import "SDImageCache.h"
//#import "SDWebImageManager.h"
//#import "UIImage+Utils.h"
//#import "UMSocial.h"
static NSString * const YX_WXAppID = @"wx159ec7bb04bcf95c";
static NSString * const YX_WXAppSecret = @"1a2e22d1e40e2e66ebe359a1c22d7c22";

static NSString * const YX_WBAppKey= @"879555002";
static NSString * const YX_WBAppSecret= @"174b98178c230288c9487c079127796d";


NSString *const notification_wxCallBack = @"notification_wxCallBack";

@interface YXShareCenter ()<WXApiDelegate, WBHttpRequestDelegate>

@end

@implementation YXShareCenter

#pragma mark - 注册app -
/**
 *  注册app
 *
 *  @param string_appid   注册app
 */
+ (void)registerAppTag:(YXShareTag )tag{
    switch (tag) {
        case YXShareTag_WX:{
            [WXApi registerApp:YX_WXAppID];
        }break;
        case YXShareTag_WeiBo:{
            [WeiboSDK enableDebugMode:YES];
            [WeiboSDK registerApp:YX_WBAppKey];
        }break;
        default:
            break;
    }
}

+ (BOOL) handleOpenURL:(NSURL *)url andTag:(YXShareTag)tag{
    switch (tag) {
        case YXShareTag_WX:{
            return  [WXApi handleOpenURL:url delegate:(id)self];
        }break;
        case YXShareTag_WeiBo:{
            return [WeiboSDK handleOpenURL:url delegate:(id)self];
        }break;
        default:
            break;
    }
    return NO;
}
+ (BOOL) handleOpenURL:(NSURL *)url andTag:(YXShareTag)tag atViewController:(UIViewController *)viewController{
    switch (tag) {
        case YXShareTag_WX:{
            if (viewController == nil) {
                return  [WXApi handleOpenURL:url delegate:(id)self];

            }else{
                return  [WXApi handleOpenURL:url delegate:(id)viewController];

            }
        }break;
        case YXShareTag_WeiBo:{
            if (viewController == nil) {
                return [WeiboSDK handleOpenURL:url delegate:(id)self];
            }else{
                return [WeiboSDK handleOpenURL:url delegate:(id)viewController];
            }
          //  return [WeiboSDK handleOpenURL:url delegate:(id)self];
        }break;
        default:
            break;
    }
    return NO;
}

- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response = %@", response);
}
/**
 *  微信返回
 *
 *  @param resp
 */
+ (void)onResp:(BaseResp*)resp{
    if([resp isKindOfClass:[SendMessageToWXResp class]]){
        [[NSNotificationCenter defaultCenter] postNotificationName:notification_wxCallBack object:[NSNumber numberWithInt:resp.errCode]];
    }
    
//    if ([resp isKindOfClass:[PayResp class]]) {
//        
//        NSString *strTitle = [NSString stringWithFormat:@"支付结果"];
//        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
//                                                        message:strMsg
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil, nil];
//        [alert show];
//        
//       // [[NSNotificationCenter defaultCenter] postNotificationName:HUDDismissNotification object:nil userInfo:nil];
//    }
}
- (void)onReq:(BaseReq *)req{
    NSLog(@"222222");
}
- (void)onResp:(BaseResp *)resp{
    NSLog(@"33333333");
    if([resp isKindOfClass:[SendMessageToWXResp class]]){
        [[NSNotificationCenter defaultCenter] postNotificationName:notification_wxCallBack object:[NSNumber numberWithInt:resp.errCode]];
    }
}
/**
 *  微博返回
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    NSLog(@"22222");
}
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    NSLog(@"33333333");

}

+ (BOOL)isHaveWX{
    return [WXApi isWXAppInstalled];
}
+ (BOOL)isHaveWeibo{
    return [WeiboSDK isWeiboAppInstalled];
}


@end
