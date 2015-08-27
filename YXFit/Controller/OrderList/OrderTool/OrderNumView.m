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
        self.backgroundColor = [UIColor whiteColor];
        _num = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width -  10 * 2, 20)];
        _num.font = YXCharacterFont(15);
        _num.textColor = [UIColor blackColor];
        [self addSubview:_num];
        
        NSString *tips = @"订单状态: ";
      //  CGSize  textSize = [tips sizeWithFont:YXCharacterFont(15) constrainedToSize:CGSizeMake(200, 20) lineBreakMode:NSLineBreakByWordWrapping];
        
        CGSize textSize = [tips boundingRectWithSize:CGSizeMake(200, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:YXCharacterFont(15)} context:nil].size;
        _lab = [[UILabel alloc] initWithFrame:CGRectMake(10, _num.frame.size.height, textSize.width, 20)];
        _lab.font = YXCharacterFont(15);
        _lab.textColor = [UIColor blackColor];
        _lab.text = tips;
        [self addSubview:_lab];
        
        _status = [[UILabel alloc] init];
        _status.backgroundColor = [UIColor grayColor];
        _status.font = YXCharacterFont(15);
        _status.textColor = [UIColor whiteColor];
        [self addSubview:_status];
    }
    return self;
}
- (void)setNum:(NSString *)num andStatus:(NSString *)status{
    _num.text = [NSString stringWithFormat:@"订单号: %@", num];
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
    _status.frame = CGRectMake(_lab.frame.size.width + _lab.frame.origin.x, _lab.frame.origin.y, textSize.width, 20);
    

    _status.text = tips;
}
@end
