//
//  AppDelegate.m
//  YXFit
//
//  Created by 何军 on 6/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "AppDelegate.h"
#import "YXIntroduceViewController.h"
#import "YXProductViewController.h"
#import "YXOrderViewController.h"
#import "YXMyViewController.h"
#import "YXTabBarViewController.h"
#import "MLNavigationController.h"

#import "Pingpp.h"
#import "YXIntroViewController.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    

    

    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        YXIntroViewController *intro = [[YXIntroViewController alloc] init];
        self.window.rootViewController = intro;
    }else{
        UIViewController *rootViewController = [self setRootVC];
        [[self window] setRootViewController:rootViewController];
        
        [[YXTabBarView sharedInstance] showAnimation];
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
    
    YXIntroduceViewController *introduceVC = [[YXIntroduceViewController alloc] init];
    MLNavigationController *introduceNav = [[MLNavigationController alloc] initWithRootViewController:introduceVC];
    
    YXOrderViewController *orderVC = [[YXOrderViewController alloc] init];
    MLNavigationController *orderNav = [[MLNavigationController alloc] initWithRootViewController:orderVC];
    
    YXMyViewController *myVC = [[YXMyViewController alloc] init];
    MLNavigationController *myNav = [[MLNavigationController alloc] initWithRootViewController:myVC];
    

    
    tabBarController.viewControllers = @[productNav, introduceNav, orderNav, myNav];
    
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
    NSString *urlStr=[[url absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([urlStr rangeOfString:@"pingpp?"].location != NSNotFound) {
        [Pingpp handleOpenURL:url withCompletion:^(NSString *result, PingppError *error) {
            // result : success, fail, cancel, invalid
            NSLog(@"%@", result);
            NSString *msg;
            if (error == nil) {
                NSLog(@"PingppError is nil");
                if ([result isEqualToString:@"success"]) {
                    msg = @"支付成功";
                }
                if ([result isEqualToString:@"cancel"]) {
                    msg = @"支付取消";
                }
                if ([result isEqualToString:@"invalid"]) {
                    msg = @"支付无效";
                }
                //   msg = result;
            } else {
                NSLog(@"PingppError: code=%lu msg=%@", (unsigned long)error.code, [error getMsg]);
                msg = [NSString stringWithFormat:@"result=%@ PingppError: code=%lu msg=%@", result, (unsigned long)error.code, [error getMsg]];
            }
            // [(ViewController*)self.viewController.visibleViewController showAlertMessage:msg];
            [UIUtils showTextOnly:self.window.rootViewController.view labelString:msg];
            
        }];
    }
    
    return YES;
}
@end
