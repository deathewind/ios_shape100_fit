//
//  MoneyView.m
//  YXClient
//
//  Created by 何军 on 17/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "MoneyView.h"

@implementation MoneyView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(240, 240, 240);
        UIView *totel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
        totel.backgroundColor = [UIColor whiteColor];
        [self addSubview:totel];
        UILabel *label_totel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, totel.frame.size.width/2 - 10, totel.frame.size.height)];
        label_totel.font = YXCharacterFont(15);
        label_totel.textAlignment = NSTextAlignmentLeft;
        label_totel.text = @"总金额";
        [totel addSubview:label_totel];
        _totel = [[UILabel alloc] initWithFrame:CGRectMake(label_totel.frame.size.width + 10, 0, label_totel.frame.size.width, totel.frame.size.height)];
        _totel.textAlignment = NSTextAlignmentRight;
        _totel.font = YXCharacterFont(15);
        [totel addSubview:_totel];
        
        UIView *coupon = [[UIView alloc] initWithFrame:CGRectMake(0, totel.frame.size.height + 2, self.frame.size.width, 44)];
        coupon.backgroundColor = [UIColor whiteColor];
        [self addSubview:coupon];
        UILabel *label_coupon = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, coupon.frame.size.width/2 - 10, coupon.frame.size.height)];
        label_coupon.font = YXCharacterFont(15);
        label_coupon.textAlignment = NSTextAlignmentLeft;
        label_coupon.text = @"优惠券";
        [coupon addSubview:label_coupon];
        _coupon = [[UILabel alloc] initWithFrame:CGRectMake(label_coupon.frame.size.width + 10, 0, label_coupon.frame.size.width, totel.frame.size.height)];
        _coupon.textAlignment = NSTextAlignmentRight;
        _coupon.font = YXCharacterFont(15);
        [coupon addSubview:_coupon];
        
        UIView *balance = [[UIView alloc] initWithFrame:CGRectMake(0, coupon.frame.size.height + coupon.frame.origin.y + 2, self.frame.size.width, 44)];
        balance.backgroundColor = [UIColor whiteColor];
        [self addSubview:balance];
        UILabel *label_balance = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, balance.frame.size.width/2 - 10, balance.frame.size.height)];
        label_balance.font = YXCharacterFont(15);
        label_balance.textAlignment = NSTextAlignmentLeft;
        label_balance.text = @"账户余额";
        [balance addSubview:label_balance];
        _balance = [[UILabel alloc] initWithFrame:CGRectMake(label_balance.frame.size.width + 10, 0, label_balance.frame.size.width, balance.frame.size.height)];
        _balance.textAlignment = NSTextAlignmentRight;
        _balance.font = YXCharacterFont(15);
        [balance addSubview:_balance];
        
        UIView *payOnline = [[UIView alloc] initWithFrame:CGRectMake(0, balance.frame.size.height + balance.frame.origin.y + 2, self.frame.size.width, 44)];
        payOnline.backgroundColor = [UIColor whiteColor];
        [self addSubview:payOnline];
        UILabel *label_payOnline = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, payOnline.frame.size.width/2 - 10, payOnline.frame.size.height)];
        label_payOnline.font = YXCharacterFont(15);
        label_payOnline.textAlignment = NSTextAlignmentLeft;
        label_payOnline.text = @"在线支付";
        [payOnline addSubview:label_payOnline];
        _payOnline = [[UILabel alloc] initWithFrame:CGRectMake(label_payOnline.frame.size.width + 10, 0, label_payOnline.frame.size.width, payOnline.frame.size.height)];
        _payOnline.textAlignment = NSTextAlignmentRight;
        _payOnline.font = YXCharacterFont(15);
        [payOnline addSubview:_payOnline];
    }
    return self;
}


@end
