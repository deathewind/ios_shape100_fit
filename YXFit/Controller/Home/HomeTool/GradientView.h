//
//  GradientView.h
//  YXFit
//
//  Created by 何军 on 11/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TRANSPARENT_GRADIENT_TYPE 1
#define COLOR_GRADIENT_TYPE 2
@interface GradientView : UIView
- (id)initWithFrame:(CGRect)frame type:(int)type;
@end
