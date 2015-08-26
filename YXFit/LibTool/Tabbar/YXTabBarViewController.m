//
//  YXTabBarViewController.m
//  YXClient
//
//  Created by 何军 on 18/5/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "YXTabBarViewController.h"
#import "YXCustonButton.h"
@interface YXTabBarViewController()<YXTabBarViewDelegate>
@end
@implementation YXTabBarViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    [[YXTabBarView sharedInstance] tabBarCreatButton];
    [YXTabBarView sharedInstance].delegate = self;
    [self.view addSubview:[YXTabBarView sharedInstance]];
}
- (void)delegate_changeViewController:(NSInteger)index{
    self.selectedIndex = index;
}
- (void)exit{
    [[YXTabBarView sharedInstance] removeFromSuperview];
    [YXTabBarView sharedInstance].delegate = nil;
}
@end
