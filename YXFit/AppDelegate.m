//
//  AppDelegate.m
//  YXFit
//
//  Created by 何军 on 6/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "AppDelegate.h"

#import "YXProductViewController.h"
#import "YXOrderViewController.h"
#import "YXMyViewController.h"
#import "YXClubListViewController.h"
#import "MLNavigationController.h"

#import "Pingpp.h"
#import "YXIntroViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "YXOrderDetailViewController.h"

#define umengfeedback @"55e5284de0f55a7145000d56" //
@interface AppDelegate ()<UITabBarControllerDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;//用于获取位置
}

@end

@implementation AppDelegate
- (void)setupLocationManager{
    //6.经纬度
//#define LATITUDE_DEFAULT 39.983497
//#define LONGITUDE_DEFAULT 116.318042
    _latitude = 0;
    _longitude = 0;
    _locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]){
        if (IOS_VERSION >= 8.0) {
            if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [_locationManager requestWhenInUseAuthorization];
            }
        }
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 200.0;
        
        [_locationManager startUpdatingLocation];
    }else{
        YXLog(@"定位失败");
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupLocationManager];
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        YXIntroViewController *intro = [[YXIntroViewController alloc] init];
        self.window.rootViewController = intro;
    }else{
        [self loadMainView];
    }
   // [self checkVersion]; //版本检测

    return YES;
}
- (void)loadMainView{
    UIViewController *rootViewController = [self setRootVC];
    [[self window] setRootViewController:rootViewController];
    [[YXTabBarView sharedInstance] showAnimation];
}
- (UITabBarController *)setRootVC{
    YXTabBarViewController *tabBarController = [[YXTabBarViewController alloc] init];
    tabBarController.delegate = self;
   // self.tabbar = tabBarController;
    
    YXProductViewController *productVC = [[YXProductViewController alloc] init];
    MLNavigationController *productNav = [[MLNavigationController alloc] initWithRootViewController:productVC];
    
    YXClubListViewController *introduceVC = [[YXClubListViewController alloc] init];
    MLNavigationController *introduceNav = [[MLNavigationController alloc] initWithRootViewController:introduceVC];
    
//    YXOrderViewController *orderVC = [[YXOrderViewController alloc] init];
//    MLNavigationController *orderNav = [[MLNavigationController alloc] initWithRootViewController:orderVC];
    
    YXMyViewController *myVC = [[YXMyViewController alloc] init];
    MLNavigationController *myNav = [[MLNavigationController alloc] initWithRootViewController:myVC];
    
    tabBarController.viewControllers = @[productNav, introduceNav, myNav];
    return tabBarController;
}

- (void)checkVersion{
    [[YXNetworkingTool sharedInstance] checkVersionSuccess:^(id JSON) {
        
    } failure:^(NSError *error, id JSON) {
        
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    __block BOOL isConnect;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //    UIImage *imagePicBg = [self blurryImage:self.imagePic withBlurLevel:2];
        isConnect = [UIUtils isConnectNetwork];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!isConnect) {
                [UIUtils showTextOnly:self.window.rootViewController.view labelString:NSLocalizedString(@"Network", nil)];
            }
        });
    });
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
   // YXLog(@"open222222");
    NSString *urlStr=[[url absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([urlStr rangeOfString:@"pingpp?"].location != NSNotFound) {
        [Pingpp handleOpenURL:url withCompletion:^(NSString *result, PingppError *error) {
            // result : success, fail, cancel, invalid
            YXLog(@"支付结果%@", result);
            NSString *msg;
            if (error == nil) {
              //  YXLog(@"PingppError is nil");
                if ([result isEqualToString:@"success"]) {
                    msg = @"支付成功";
                    YXLog(@"支付成功");
                    [[NSNotificationCenter defaultCenter] postNotificationName:YXPaySuccessNoti object:nil];
        
                }
                if ([result isEqualToString:@"cancel"]) {
                    msg = @"支付取消";
                }
                if ([result isEqualToString:@"invalid"]) {
                    msg = @"支付无效";
                }
                //   msg = result;
            } else {
                YXLog(@"PingppError: code=%lu msg=%@", (unsigned long)error.code, [error getMsg]);
                msg = [NSString stringWithFormat:@"result=%@ PingppError: code=%lu msg=%@", result, (unsigned long)error.code, [error getMsg]];
            }
            
            // [(ViewController*)self.viewController.visibleViewController showAlertMessage:msg];
           // [UIUtils showTextOnly:self.window.rootViewController.view labelString:msg time:2];
           // [self.tabbar changeIndex:2];
           // YXOrderViewController *order = (YXOrderViewController *)self.tabbar.selectedViewController;
            
//            NSString *orderid = [[NSUserDefaults standardUserDefaults] objectForKey:@"orderID"];
//            YXOrderDetailViewController *orderDetail = [[YXOrderDetailViewController alloc] init];
//            orderDetail.orderID = orderid;
//            self.window.rootViewController = orderDetail;
            
////           // [order.navigationController pushViewController:orderDetail animated:YES];
//            [self.window.rootViewController.navigationController pushViewController:orderDetail animated:YES];
            
        }];
    }
    
    return YES;
}
#pragma mark CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *cl = [locations lastObject];
    _latitude = cl.coordinate.latitude;
    _longitude = cl.coordinate.longitude;
    YXLog(@"%f--%f",_latitude,_longitude);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    YXLog(@"定位失败");
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    YXLog(@"内存警告");
    [_locationManager stopUpdatingLocation];
}
@end
