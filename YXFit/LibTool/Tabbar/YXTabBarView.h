//
//  YXTabBarView.h
//  YXClient
//
//  Created by 何军 on 18/5/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YXTabBarViewDelegate <NSObject>
- (void)delegate_changeViewController:(NSInteger)index;
@end
@interface YXTabBarView : UIView
@property (assign, nonatomic) id<YXTabBarViewDelegate>delegate;
+ (YXTabBarView *)sharedInstance;
- (void)tabBarCreatButton;
- (void)showAnimation;
- (void)hiddenAnimation;
- (void)selectIndex:(NSInteger)index;
@end
