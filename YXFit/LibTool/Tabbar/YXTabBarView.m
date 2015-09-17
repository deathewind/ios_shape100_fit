//
//  YXTabBarView.m
//  YXClient
//
//  Created by 何军 on 18/5/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "YXTabBarView.h"
#import "YXCustonButton.h"
@interface YXTabBarView()
{
    UIImageView *_tabBarView;
    YXCustonButton *_previousButton;
  //  BOOL tabBarisShow;
}
@end
@implementation YXTabBarView
static YXTabBarView *YXTabBarInstance = nil;
+ (YXTabBarView *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        YXTabBarInstance = [[self alloc] init];
    });
    return YXTabBarInstance;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = RGB(243, 243, 243);
        self.alpha = 0.9;
        [self setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 51)];
        _tabBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width , self.frame.size.height)];
        _tabBarView.userInteractionEnabled = YES;
        _tabBarView.image = [UIImage imageFileName:@"tabbar_bg.png"];
        [self addSubview:_tabBarView];
        
        UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0.5, self.frame.size.width, 0.5)];
        topLine.backgroundColor = RGB(200, 200, 200);
        [self addSubview:topLine];
    }
    return self;
}
- (void)tabBarCreatButton{
    if (_tabBarView.subviews.count) {
        for (UIView *v in _tabBarView.subviews) {
            if ([v isKindOfClass:[YXCustonButton class]]) {
                [v removeFromSuperview];
            }
        }
    }
    [self creatButtonWithName:@"tabBar_home_nor.png" andImageName:@"tabBar_home_sel.png" andTitle:NSLocalizedString(@"企业课", nil) atIndex:0];
    [self creatButtonWithName:@"tabBar_club_nor.png" andImageName:@"tabBar_club_sel.png" andTitle:NSLocalizedString(@"俱乐部", nil) atIndex:1];
//    [self creatButtonWithName:@"tabBar_timeTable_nor.png" andImageName:@"tabBar_timeTable_sel.png" andTitle:NSLocalizedString(@"订单", nil) atIndex:2];
    [self creatButtonWithName:@"tabBar_me_nor.png" andImageName:@"tabBar_me_sel.png" andTitle:NSLocalizedString(@"我", nil) atIndex:2];
    
   // YXCustonButton *btn = self.subviews[0];
    YXCustonButton *btn = _tabBarView.subviews[0];
  //  YXCustonButton *btn =(YXCustonButton *)[self viewWithTag:0];
    [self changeViewController:btn];
}
-(void)creatButtonWithName:(NSString *)normal andImageName:(NSString *)selected andTitle:(NSString *)title atIndex:(int)index{
    YXCustonButton *button = [YXCustonButton buttonWithType:UIButtonTypeCustom];
    button.tag = index;
    CGFloat buttonW = _tabBarView.frame.size.width / 3;
    CGFloat buttonH = self.frame.size.height;
    button.frame = CGRectMake(buttonW *index, 2, buttonW, buttonH - 4);
    [button setImage:[UIImage imageFileName:normal] forState:UIControlStateNormal];
    [button setImage:[UIImage imageFileName:selected] forState:UIControlStateDisabled];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:RGB(136, 136, 136) forState:UIControlStateNormal];
    [button setTitleColor:RGB(156, 210, 122) forState:UIControlStateDisabled];
   // [button setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [button addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    button.imageView.contentMode = UIViewContentModeCenter;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = YXCharacterBoldFont(13);
    [_tabBarView addSubview:button];
}
- (void)changeViewController:(YXCustonButton *)sender{
//    self.selectedIndex = sender.tag;
    sender.enabled = NO;
    if (_previousButton != sender) {
        _previousButton.enabled = YES;
        if ([_delegate respondsToSelector:@selector(delegate_changeViewController:)])
            [_delegate delegate_changeViewController:sender.tag];
    }
    _previousButton = sender;

}
- (void)showAnimation{
//    if (tabBarisShow) {
//        return;
//    }
//    [UIView animateWithDuration:0.3
//                     animations:^{
//                         CGRect tabFrame = self.frame;
//                         //tabFrame.origin.y = CGRectGetMaxY(window.bounds) - CGRectGetHeight(tabBar.frame);
//                         tabFrame.origin.x = 0;
//                        // NSLog(@"%f", tabFrame.origin.x);
//                         self.frame = tabFrame;
//                     }];
    self.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        CGRect tabFrame = self.frame;
        tabFrame.origin.y = CGRectGetMaxY(self.window.bounds) - CGRectGetHeight(self.frame);
        //tabFrame.origin.y = CGRectGetMaxY(window.bounds);
        //tabFrame.origin.x = 0;
        self.frame = tabFrame;
    } completion:^(BOOL finished) {
       // self.hidden = NO;
    }];
   // tabBarisShow = YES;
}
- (void)hiddenAnimation{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect tabFrame = self.frame;
        tabFrame.origin.y = CGRectGetMaxY(self.window.bounds);
       // tabFrame.origin.x = 0 - tabFrame.size.width;
        self.frame = tabFrame;
    } completion:^(BOOL finished){
        self.hidden = YES;
    }];

}

- (void)selectIndex:(NSInteger)index{
    YXCustonButton *btn = (YXCustonButton *)_tabBarView.subviews[index];
    //  YXCustonButton *btn =(YXCustonButton *)[self viewWithTag:0];
    [self changeViewController:btn];
    
}
@end
