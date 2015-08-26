//
//  MyHeaderView.h
//  YXFit
//
//  Created by 何军 on 24/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Model_user.h"
@protocol MyHeaderViewDelegate <NSObject>
@optional
- (void)showPortrait:(UITapGestureRecognizer *)tap;
@end
@interface MyHeaderView : UIView
@property(nonatomic, assign) id<MyHeaderViewDelegate>delegate;
- (void)setNameAndImage;
@end
