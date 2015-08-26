//
//  YXLoadMoreView.h
//  YXClient
//
//  Created by 何军 on 5/2/15.
//  Copyright (c) 2015年 张明磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YXLoadMoreViewDelegate <NSObject>
@optional
- (void)loadNewDate;
@end
@interface YXLoadMoreView : UIView
@property (nonatomic,strong) UIActivityIndicatorView * activeView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic, assign) BOOL errorInter;
@property (nonatomic, assign) id<YXLoadMoreViewDelegate>delegate;
@end
