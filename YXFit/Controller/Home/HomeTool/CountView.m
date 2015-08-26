//
//  CountView.m
//  YXClient
//
//  Created by 何军 on 12/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "CountView.h"
@interface CountView()
{
    UILabel  *_label;
    UIButton *_leftBtn;
}
@end
@implementation CountView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, self.frame.size.height)];
       // label.backgroundColor = [UIColor redColor];
        label.font = YXCharacterFont(15);
        label.text = @"购买数量";
        [self addSubview:label];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - 190, 10, 180, self.frame.size.height - 10 * 2)];
        view.layer.borderWidth = 1;
        view.layer.borderColor = [UIColor grayColor].CGColor;
        view.layer.cornerRadius = 5;
        view.clipsToBounds = YES;
        [self addSubview:view];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"1";
        [view addSubview:_label];
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, 0, view.frame.size.width / 3, view.frame.size.height);
        _leftBtn.backgroundColor = [UIColor whiteColor];
        [_leftBtn setTitle:@"-" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        _leftBtn.enabled = NO;
        _leftBtn.layer.borderWidth = 1;
        _leftBtn.layer.borderColor = [UIColor grayColor].CGColor;
        [_leftBtn addTarget:self action:@selector(countChangeAction:) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.tag = 100;
        [view addSubview:_leftBtn];

        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(2 * view.frame.size.width / 3, 0, _leftBtn.frame.size.width, view.frame.size.height);
        rightBtn.backgroundColor = [UIColor whiteColor];
        [rightBtn setTitle:@"+" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        rightBtn.layer.borderWidth = 1;
        rightBtn.layer.borderColor = [UIColor grayColor].CGColor;
        [rightBtn addTarget:self action:@selector(countChangeAction:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.tag = 101;
        [view addSubview:rightBtn];
    }
    return self;
}
- (void)countChangeAction:(UIButton *)btn{
    if (btn.tag == 100) {
        
        if ([_label.text isEqualToString:@"1"]) {
            btn.enabled = NO;
        }else{
            btn.enabled = YES;
            _label.text = [NSString stringWithFormat:@"%ld",[_label.text integerValue] - 1];
            if ([_label.text isEqualToString:@"1"]) {
                btn.enabled = NO;
            }
        }
    }else{
        _label.text = [NSString stringWithFormat:@"%ld",[_label.text integerValue] + 1];
        _leftBtn.enabled = YES;
    }
    _countChange(_label.text);
}
@end
