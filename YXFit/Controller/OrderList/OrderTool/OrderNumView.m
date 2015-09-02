//
//  OrderNumView.m
//  YXClient
//
//  Created by 何军 on 21/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "OrderNumView.h"
@interface OrderNumView()
{
    UILabel *_num;
    UILabel *_lab;
    UILabel *_status;
}
@end
@implementation OrderNumView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *label_pay = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.width - 10 * 2, 30)];
        label_pay.text = @"订单信息";
        label_pay.backgroundColor = [UIColor clearColor];
        label_pay.textAlignment = NSTextAlignmentLeft;
        label_pay.textColor = RGB(60, 60, 60);
        label_pay.font = YXCharacterBoldFont(16);
        [self addSubview:label_pay];
        
        UIView *orderNum = [[UIView alloc] initWithFrame:CGRectMake(0, label_pay.height, self.width, 30)];
        orderNum.backgroundColor = [UIColor whiteColor];
        [self addSubview:orderNum];
        UILabel *left = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, orderNum.height)];
        left.text = @"订单号:";
        left.textColor = RGB(60, 60, 60);
        left.font = YXCharacterFont(15);
        [orderNum addSubview:left];
        _num = [[UILabel alloc] initWithFrame:CGRectMake(left.origin.x + left.width, 0, self.width - left.origin.x * 2 - left.width, orderNum.height)];
        _num.font = YXCharacterFont(15);
        _num.textColor = [UIColor grayColor];
        _num.textAlignment = NSTextAlignmentRight;
        [orderNum addSubview:_num];
        
        UIView *status = [[UIView alloc] initWithFrame:CGRectMake(0, orderNum.height + orderNum.origin.y, self.width, orderNum.height)];
        status.backgroundColor = [UIColor whiteColor];
        [self addSubview:status];
        
        UILabel *left1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, status.height)];
        left1.text = @"订单状态:";
        left1.font = YXCharacterFont(15);
        left1.textColor = RGB(60, 60, 60);
        [status addSubview:left1];
        

        
        _status = [[UILabel alloc] init];
        _status.backgroundColor = [UIColor grayColor];
        _status.font = YXCharacterFont(15);
        _status.textColor = [UIColor whiteColor];
        [status addSubview:_status];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [orderNum addSubview:line];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(10, orderNum.height - 0.5, self.width - 10, 0.5)];
        line1.backgroundColor = [UIColor lightGrayColor];
        [orderNum addSubview:line1];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, status.height - 0.5, self.width, 0.5)];
        line2.backgroundColor = [UIColor lightGrayColor];
        [status addSubview:line2];
    }
    return self;
}
- (void)setNum:(NSString *)num andStatus:(NSString *)status{
    _num.text = [NSString stringWithFormat:@"%@", num];
    NSString *sta = [NSString stringWithFormat:@"%@", status];
    NSString *tips;
    if ([sta isEqualToString:@"0"]) {
        tips = @"等待买家付款";
    }
    if ([sta isEqualToString:@"1"]) {
        tips = @"买家已付款";
    }
    if ([sta isEqualToString:@"2"]) {
        tips = @"卖家已发货";
    }
    if ([sta isEqualToString:@"3"]) {
        tips = @"买家已签收";
    }
    if ([sta isEqualToString:@"4"]) {
        tips = @"交易成功";
    }
    if ([sta isEqualToString:@"5"]) {
        tips = @"交易关闭";
    }
   // CGSize  textSize = [tips sizeWithFont:YXCharacterFont(15) constrainedToSize:CGSizeMake(200, 20) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize textSize = [tips boundingRectWithSize:CGSizeMake(200, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:YXCharacterFont(15)} context:nil].size;
    _status.frame = CGRectMake(self.width - 10 -textSize.width, 5, textSize.width, 20);
    

    _status.text = tips;
}
@end
