//
//  ButtonDoctView.h
//  YXFit
//
//  Created by 何军 on 26/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonDoctViewDelegate <NSObject>

@optional
- (void)clickChangeView:(UIButton *)button;

@end
@interface ButtonDoctView : UIView
@property(nonatomic, assign) id<ButtonDoctViewDelegate>delegate;
@end
