//
//  MyHeaderExpandView.h
//  YXFit
//
//  Created by 何军 on 9/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyHeaderExpandViewDelegate <NSObject>
@optional
- (void)showPortrait:(UITapGestureRecognizer *)tap;
@end
@interface MyHeaderExpandView : UIView
@property(nonatomic, assign) id<MyHeaderExpandViewDelegate>delegate;
- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset;
- (void)setNameAndImage;
@end
