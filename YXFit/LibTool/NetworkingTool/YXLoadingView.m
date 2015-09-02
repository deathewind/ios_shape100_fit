//
//  YXLoadingView.m
//  YXFit
//
//  Created by 何军 on 28/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXLoadingView.h"
@interface YXLoadingView()
{
    UIButton *_button;
    UILabel  *_label;
}
@end
@implementation YXLoadingView
- (id)initWithFrame:(CGRect)frame color:(UIColor *)color{
    self = [super initWithFrame:frame];
    if (self) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = self.bounds;
        _button.backgroundColor = color;
        [self addSubview:_button];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height/2 - 20, self.width, 40)];
        _label.textColor = [UIColor lightGrayColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = YXCharacterBoldFont(17);
        _label.hidden = YES;
        [self addSubview:_label];
    }
    return self;
}
- (void)showFailure{
    _label.hidden = NO;
    _label.text = @"点击屏幕重新加载";
    [_button addTarget:self action:@selector(request) forControlEvents:UIControlEventTouchUpInside];
}
- (void)request{
    _label.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(retryRequest)]) {
        [self.delegate retryRequest];
    }
    [_button removeTarget:self action:@selector(request) forControlEvents:UIControlEventTouchUpInside];
}

@end
