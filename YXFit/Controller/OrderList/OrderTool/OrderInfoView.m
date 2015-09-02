//
//  OrderInfoView.m
//  YXClient
//
//  Created by 何军 on 21/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "OrderInfoView.h"
@interface OrderInfoView()
@end
@implementation OrderInfoView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UILabel *label_pay = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.width - 10 * 2, 30)];
        label_pay.text = @"商品信息";
        label_pay.backgroundColor = [UIColor clearColor];
        label_pay.textAlignment = NSTextAlignmentLeft;
        label_pay.textColor = RGB(60, 60, 60);
        label_pay.font = YXCharacterBoldFont(16);
        [self addSubview:label_pay];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, label_pay.height, self.width, 150)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
//        _num = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width -  10 * 2, 20)];
//        _num.font = YXCharacterFont(15);
//        _num.textColor = [UIColor blackColor];
//        [self addSubview:_num];
//        
//        NSString *tips = @"订单状态:";
//        CGSize  textSize = [tips sizeWithFont:YXCharacterFont(15) constrainedToSize:CGSizeMake(200, 20) lineBreakMode:NSLineBreakByWordWrapping];
//        _lab = [[UILabel alloc] initWithFrame:CGRectMake(10, _num.frame.size.height, textSize.width, 20)];
//        _lab.font = YXCharacterFont(15);
//        _lab.textColor = [UIColor blackColor];
//        _lab.text = tips;
//        [self addSubview:_lab];
//        
//        _status = [[UILabel alloc] init];
//        _status.backgroundColor = [UIColor grayColor];
//        _status.font = YXCharacterFont(15);
//        _status.textColor = [UIColor whiteColor];
//        [self addSubview:_status];
    }
    return self;
}
@end
