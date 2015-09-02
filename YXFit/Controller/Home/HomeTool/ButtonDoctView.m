//
//  ButtonDoctView.m
//  YXFit
//
//  Created by 何军 on 26/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ButtonDoctView.h"
@interface ButtonDoctView()
{
    UIView *_line;
}
@end
@implementation ButtonDoctView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, self.width/4, self.height);
        [button setTitle:@"课程介绍" forState:UIControlStateNormal];
        button.titleLabel.font = YXCharacterFont(15);
        button.tag = 0;
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(button.width, 0, self.width/4, self.height);
        [button1 setTitle:@"体验评价" forState:UIControlStateNormal];
        button1.titleLabel.font = YXCharacterFont(15);
        button1.tag = 1;
        [button1 addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [button1 setTitleColor:RGB(60, 60, 60) forState:UIControlStateNormal];
        [self addSubview:button1];
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(button1.width + button1.origin.x, 0, self.width/4, self.height);
        [button2 setTitle:@"注意事项" forState:UIControlStateNormal];
        button2.titleLabel.font = YXCharacterFont(15);
        button2.tag = 2;
        [button2 addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [button2 setTitleColor:RGB(60, 60, 60) forState:UIControlStateNormal];
        [self addSubview:button2];
        
        UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        button3.frame = CGRectMake(button2.width + button2.origin.x, 0, self.width/4, self.height);
        [button3 setTitle:@"下单须知" forState:UIControlStateNormal];
        button3.titleLabel.font = YXCharacterFont(15);
        button3.tag = 3;
        [button3 addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [button3 setTitleColor:RGB(60, 60, 60) forState:UIControlStateNormal];
        [self addSubview:button3];
        
//        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(button.width - 1, 10, 1, self.height - 10 * 2)];
//        line.backgroundColor = [UIColor lightGrayColor];
//        [button addSubview:line];
//        
//        UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(button1.width - 1, line.origin.y, 1, line.height)];
//        line1.backgroundColor = [UIColor lightGrayColor];
//        [button1 addSubview:line1];
//        
//        UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(button2.width - 1, line.origin.y, 1, line.height)];
//        line2.backgroundColor = [UIColor lightGrayColor];
//        [button2 addSubview:line2];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 2, button.width, 2)];
        _line.backgroundColor = [UIColor orangeColor];
        [self addSubview:_line];
    }
    return self;
}
- (void)changeBtn:(UIButton *)button{
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    CGRect lineRect = _line.frame;
    lineRect.origin.x = button.origin.x;
    [UIView animateWithDuration:0.3 animations:^{
        _line.frame = lineRect;
    } completion:^(BOOL finished) {
        
    }];
    for (UIButton *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if (view.tag != button.tag) {
                [view setTitleColor:RGB(60, 60, 60) forState:UIControlStateNormal];
            }
        }
    }
    if ([self.delegate respondsToSelector:@selector(clickChangeView:)]) {
        [self.delegate clickChangeView:button];
    }
}
@end
