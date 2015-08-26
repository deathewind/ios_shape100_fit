//
//  YXPeopleBGView.h
//  YXClient
//
//  Created by 何军 on 25/6/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BGImageHeight 210
@protocol YXBGScrollowViewDelegate <NSObject>

- (void)detailsForegroundView:(UIView *)foregroundView;

@end
@interface YXBGScrollowView : UIView
@property(nonatomic, assign) id<YXBGScrollowViewDelegate>delegate;
@property(nonatomic, assign) BOOL scrollEnble;
- (void)changeBGImage:(UIImage *)image;
@end
