//
//  OrderPayView.m
//  YXClient
//
//  Created by 何军 on 21/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "OrderPayView.h"
@interface OrderPayView()

@end
@implementation OrderPayView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 10 * 2, 40)];
        label.text = @"支付信息";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = YXCharacterBoldFont(16);
        [self addSubview:label];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, label.frame.size.height - 1, self.frame.size.width, 3)];
        line.backgroundColor = RGB(240, 240, 240);
        [self addSubview:line];
        
        UILabel *totel = [[UILabel alloc] initWithFrame:CGRectMake(10, label.frame.size.height, self.frame.size.width/2 - 10, 44)];
        totel.font = YXCharacterFont(15);
        totel.text = @"订单总金额";
        totel.textColor = [UIColor grayColor];
        [self addSubview:totel];
        _totel = [[UILabel alloc] initWithFrame:CGRectMake(totel.frame.size.width + totel.frame.origin.x, totel.frame.origin.y, totel.frame.size.width, totel.frame.size.height)];
        _totel.textAlignment = NSTextAlignmentRight;
        _totel.font = YXCharacterFont(15);
        [self addSubview:_totel];
        
        UILabel *coupon = [[UILabel alloc] initWithFrame:CGRectMake(totel.frame.origin.x, totel.frame.size.height + totel.frame.origin.y, totel.frame.size.width, totel.frame.size.height)];
        coupon.font = YXCharacterFont(15);
        coupon.text = @"优惠券";
        coupon.textColor = totel.textColor;
        [self addSubview:coupon];
        _coupon = [[UILabel alloc] initWithFrame:CGRectMake(coupon.frame.size.width + coupon.frame.origin.x, coupon.frame.origin.y, totel.frame.size.width, totel.frame.size.height)];
        _coupon.textAlignment = NSTextAlignmentRight;
        _coupon.font = YXCharacterFont(15);
        [self addSubview:_coupon];
        
        UILabel *balance = [[UILabel alloc] initWithFrame:CGRectMake(totel.frame.origin.x, coupon.frame.size.height + coupon.frame.origin.y, totel.frame.size.width, totel.frame.size.height)];
        balance.font = YXCharacterFont(15);
        balance.text = @"余额支付金额";
        balance.textColor = totel.textColor;
        [self addSubview:balance];
        _balance = [[UILabel alloc] initWithFrame:CGRectMake(balance.frame.size.width + balance.frame.origin.x, balance.frame.origin.y, totel.frame.size.width, totel.frame.size.height)];
        _balance.textAlignment = NSTextAlignmentRight;
        _balance.font = YXCharacterFont(15);
        [self addSubview:_balance];
        
        UILabel *payOnline = [[UILabel alloc] initWithFrame:CGRectMake(totel.frame.origin.x, balance.frame.size.height + balance.frame.origin.y, totel.frame.size.width, totel.frame.size.height)];
        payOnline.font = YXCharacterFont(15);
        payOnline.text = @"第三方支付";
        payOnline.textColor = totel.textColor;
        [self addSubview:payOnline];
        _payOnline = [[UILabel alloc] initWithFrame:CGRectMake(payOnline.frame.size.width + payOnline.frame.origin.x, payOnline.frame.origin.y, totel.frame.size.width, totel.frame.size.height)];
        _payOnline.textAlignment = NSTextAlignmentRight;
        _payOnline.font = YXCharacterFont(15);
        [self addSubview:_payOnline];
 
    }
    return self;
}
@end
