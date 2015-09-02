//
//  YXLoadingView.h
//  YXFit
//
//  Created by 何军 on 28/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YXLoadingViewDelegate <NSObject>
-(void)retryRequest;
@end
@interface YXLoadingView : UIView
@property(nonatomic, assign) id<YXLoadingViewDelegate>delegate;
- (id)initWithFrame:(CGRect)frame color:(UIColor *)color;
- (void)showFailure;
@end
