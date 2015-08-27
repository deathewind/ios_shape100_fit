//
//  UIUtils.m
//  YXFit
//
//  Created by 何军 on 24/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIUtils.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
@implementation UIUtils
#pragma mark - build版本 -
/**
 *  build版本
 */
+ (NSString *)buildVersion
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR || TARGET_OS_MAC)
    NSString * __string_value = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    return __string_value;
#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    return nil;
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
}

#pragma mark - version -
/**
 *  version
 */
+ (NSString *)Version
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR || TARGET_OS_MAC)
    NSString * __string_value = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return __string_value;
#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    return nil;
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
}
#pragma mark - 检测网络 -
/**
 *  检测网络
 *
 *  @return BOOL
 */
+ (BOOL)isConnectNetwork
{
    
    BOOL connect_result = YES;
    //  Reachability *connect_net = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    Reachability *connect_net = [Reachability reachabilityForInternetConnection];
    switch ([connect_net currentReachabilityStatus])
    {
        case NotReachable:
        {
            connect_result = NO;
        }break;
        case ReachableViaWWAN:
        {
            connect_result = YES;
        }break;
        case ReachableViaWiFi:
        {
            connect_result = YES;
        }break;}
    return connect_result;
}
#pragma mark - 正则判断手机号 -
/**
 *  正则判断手机号
 */
+ (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)) {
        return YES;
    } else {
        return NO;
    }
}

//保存头像图片
+ (NSString *)saveMyImage:(UIImage *)image{
    NSArray *pathArray=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathString=[[pathArray objectAtIndex:0] stringByAppendingPathComponent:@"icon.jpg"];
    NSData *iconData = UIImageJPEGRepresentation(image, 1.0);
    [iconData writeToFile:pathString atomically:YES];
    return pathString;
}




+ (void)showProgressHUDto:(UIView *)view withString:(NSString *)tipString {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // CGAffineTransform old = hud.transform;
    // hud.transform = CGAffineTransformScale(old, 0.7, 0.7);
    hud.labelText = tipString;
    //  hud.detailsLabelText = @"请稍后";
    // [hud hide:YES afterDelay:time];
}
+ (void)showProgressHUDto:(UIView *)view withString:(NSString *)tipString showTime:(float)time{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // CGAffineTransform old = hud.transform;
    // hud.transform = CGAffineTransformScale(old, 0.7, 0.7);
    hud.labelText = tipString;
    //  hud.detailsLabelText = @"请稍后";
    [hud hide:YES afterDelay:time];
}
+ (void)showProgressHUDto:(UIView *)view below:(UIView *)navView withString:(NSString *)tipString showTime:(float)time{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view below:navView animated:YES];
    // CGAffineTransform old = hud.transform;
    // hud.transform = CGAffineTransformScale(old, 0.7, 0.7);
    hud.labelText = tipString;
    //  hud.detailsLabelText = @"请稍后";
    [hud hide:YES afterDelay:time];
}
+ (void)hideProgressHUD:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}
+ (void)showTextOnly:(UIView *)view labelString:(NSString *)str {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = str;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

+ (void)showTextOnly:(UIView *)view labelString:(NSString *)str time:(float)time{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = str;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:time];
}
@end
