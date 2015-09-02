//
//  YXIndicatorView.h
//  YXFit
//
//  Created by 何军 on 28/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXIndicatorView : UIView
@property (nonatomic, strong) UIColor *color;
//@property (nonatomic, assign) BOOL hidesWhenStopped;
//
//@property (nonatomic, assign) BOOL stopped;
-(instancetype)initWithColor:(UIColor*)color;

-(void)startAnimating;
-(void)stopAnimating;
@end
