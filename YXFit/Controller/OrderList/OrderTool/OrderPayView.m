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
        self.backgroundColor = [UIColor clearColor];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 10 * 2, 40)];
//        label.text = @"支付信息";
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = YXCharacterBoldFont(16);
//        [self addSubview:label];
        UILabel *label_pay = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.width - 10 * 2, 30)];
        label_pay.text = @"支付信息";
        label_pay.backgroundColor = RGB(240, 240, 240);
        label_pay.textAlignment = NSTextAlignmentLeft;
        label_pay.textColor = RGB(60, 60, 60);
        label_pay.font = YXCharacterBoldFont(16);
        [self addSubview:label_pay];
        
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, label_pay.frame.size.height - 1, self.frame.size.width, 3)];
//        line.backgroundColor = RGB(240, 240, 240);
//        [self addSubview:line];
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, label_pay.frame.size.height, self.width, 44)];
        view1.backgroundColor = [UIColor whiteColor];
        [self addSubview:view1];
        UILabel *totel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view1.width/2 - 10, view1.height)];
        totel.font = YXCharacterFont(15);
        totel.text = @"订单总金额";
        totel.textColor = [UIColor grayColor];
        [view1 addSubview:totel];
        _totel = [[UILabel alloc] initWithFrame:CGRectMake(totel.frame.size.width + totel.frame.origin.x, totel.frame.origin.y, totel.frame.size.width, totel.frame.size.height)];
        _totel.textAlignment = NSTextAlignmentRight;
        _totel.font = YXCharacterFont(15);
        [view1 addSubview:_totel];
        
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, view1.frame.size.height + view1.frame.origin.y, self.width, view1.height)];
        view2.backgroundColor = [UIColor whiteColor];
        [self addSubview:view2];
        UILabel *coupon = [[UILabel alloc] initWithFrame:CGRectMake(totel.frame.origin.x, 0, totel.frame.size.width, totel.frame.size.height)];
        coupon.font = YXCharacterFont(15);
        coupon.text = @"优惠券";
        coupon.textColor = totel.textColor;
        [view2 addSubview:coupon];
        _coupon = [[UILabel alloc] initWithFrame:CGRectMake(coupon.frame.size.width + coupon.frame.origin.x, coupon.frame.origin.y, totel.frame.size.width, totel.frame.size.height)];
        _coupon.textAlignment = NSTextAlignmentRight;
        _coupon.font = YXCharacterFont(15);
        [view2 addSubview:_coupon];
        
        UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, view2.frame.size.height + view2.frame.origin.y, self.width, view1.height)];
        view3.backgroundColor = [UIColor whiteColor];
        [self addSubview:view3];
        UILabel *balance = [[UILabel alloc] initWithFrame:CGRectMake(totel.frame.origin.x, 0, totel.frame.size.width, totel.frame.size.height)];
        balance.font = YXCharacterFont(15);
        balance.text = @"余额支付金额";
        balance.textColor = totel.textColor;
        [view3 addSubview:balance];
        _balance = [[UILabel alloc] initWithFrame:CGRectMake(balance.frame.size.width + balance.frame.origin.x, balance.frame.origin.y, totel.frame.size.width, totel.frame.size.height)];
        _balance.textAlignment = NSTextAlignmentRight;
        _balance.font = YXCharacterFont(15);
        [view3 addSubview:_balance];
        
        UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(0, view3.frame.size.height + view3.frame.origin.y, self.width, view1.height)];
        view4.backgroundColor = [UIColor whiteColor];
        [self addSubview:view4];
        UILabel *payOnline = [[UILabel alloc] initWithFrame:CGRectMake(totel.frame.origin.x, 0, totel.frame.size.width, totel.frame.size.height)];
        payOnline.font = YXCharacterFont(15);
        payOnline.text = @"第三方支付";
        payOnline.textColor = totel.textColor;
        [view4 addSubview:payOnline];
        _payOnline = [[UILabel alloc] initWithFrame:CGRectMake(payOnline.frame.size.width + payOnline.frame.origin.x, payOnline.frame.origin.y, totel.frame.size.width, totel.frame.size.height)];
        _payOnline.textAlignment = NSTextAlignmentRight;
        _payOnline.font = YXCharacterFont(15);
        [view4 addSubview:_payOnline];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [view1 addSubview:line];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(10, view1.height - 0.5, self.width - 10, 0.5)];
        line1.backgroundColor = line.backgroundColor;
        [view1 addSubview:line1];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(line1.origin.x, 0, line1.width, 0.5)];
        line2.backgroundColor = line.backgroundColor;
        [view3 addSubview:line2];
        
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(line1.origin.x, 0, line1.width, 0.5)];
        line3.backgroundColor = line.backgroundColor;
        [view4 addSubview:line3];
        
        UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, view4.height - 0.5, self.width, 0.5)];
        line4.backgroundColor = line.backgroundColor;
        [view4 addSubview:line4];
 
    }
    return self;
}
@end
