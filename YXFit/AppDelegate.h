//
//  AppDelegate.h
//  YXFit
//
//  Created by 何军 on 6/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXTabBarViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) YXTabBarViewController *tabbar;
@property (strong, nonatomic) NSString *orderID;
- (void)loadMainView;
@end

