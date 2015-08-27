//
//  OrderCell.m
//  YXClient
//
//  Created by 何军 on 13/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "OrderCell.h"

@interface OrderCell()
{
    UIImageView *_imageView;
    UILabel *_name;
    UILabel *_time;
    UILabel *_coach;
    UILabel *_money;
    UILabel *_status;
}
@end

@implementation OrderCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = RGB(233, 233, 233);
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, ScreenWidth - 10 *2, 120)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 140, bgView.frame.size.height)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [bgView addSubview:_imageView];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.frame.size.width + 5, 10, bgView.frame.size.width - _imageView.frame.size.width - 5, 20)];
        _name.textColor = [UIColor blackColor];
       // _name.backgroundColor = [UIColor redColor];
        _name.numberOfLines = 0;
        _name.textAlignment = NSTextAlignmentLeft;
        _name.font = YXCharacterBoldFont(16);
        [bgView addSubview:_name];
        
        _time = [[UILabel alloc] initWithFrame:CGRectMake(_name.frame.origin.x, _name.frame.size.height + _name.frame.origin.y, _name.frame.size.width, 20)];
        _time.textColor = [UIColor lightGrayColor];
        _time.textAlignment = NSTextAlignmentLeft;
        _time.font = YXCharacterFont(13);
        [bgView addSubview:_time];
        
        _coach = [[UILabel alloc] initWithFrame:CGRectMake(_name.frame.origin.x, _time.frame.size.height + _time.frame.origin.y, _name.frame.size.width, 20)];
        _coach.textColor = [UIColor lightGrayColor];
        _coach.textAlignment = NSTextAlignmentLeft;
        _coach.font = YXCharacterFont(13);
        [bgView addSubview:_coach];
        
        _money = [[UILabel alloc] initWithFrame:CGRectMake(_name.frame.origin.x, _coach.frame.size.height + _coach.frame.origin.y, _name.frame.size.width, 20)];
        _money.textColor = [UIColor lightGrayColor];
        _money.textAlignment = NSTextAlignmentLeft;
        _money.font = YXCharacterFont(13);
        [bgView addSubview:_money];
        
        _status = [[UILabel alloc] init];//WithFrame:CGRectMake(_name.frame.origin.x, _money.frame.size.height + _money.frame.origin.y, _name.frame.size.width, 20)];
        _status.backgroundColor = [UIColor grayColor];
        _status.textColor = [UIColor lightGrayColor];
        _status.textAlignment = NSTextAlignmentCenter;
        _status.font = YXCharacterFont(13);
        [bgView addSubview:_status];
    }
    return self;
}
- (void)setOrder:(Model_order *)order{
    _order = order;
    NSString *str = [[order.order_pic_urls firstObject] objectForKey:@"thumbnail_pic"];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:str]];
    
    _name.text = order.order_title;
    _time.text = order.order_created;
   // _coach.text =
    _money.text = [NSString stringWithFormat:@"￥%@ 数量 %@", order.order_price, order.order_count];
    
    NSString *status = [NSString stringWithFormat:@"%@", order.order_status];
    NSString *tips;
    if ([status isEqualToString:@"0"]) {
        tips = @"等待买家付款";
    }
    if ([status isEqualToString:@"1"]) {
        tips = @"买家已付款";
    }
    if ([status isEqualToString:@"2"]) {
        tips = @"卖家已发货";
    }
    if ([status isEqualToString:@"3"]) {
        tips = @"买家已签收";
    }
    if ([status isEqualToString:@"4"]) {
        tips = @"交易成功";
    }
    if ([status isEqualToString:@"5"]) {
        tips = @"交易关闭";
    }
  //  CGSize  textSize = [tips sizeWithFont:YXCharacterFont(14) constrainedToSize:CGSizeMake(_name.frame.size.width, 20) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize textSize = [tips boundingRectWithSize:CGSizeMake(_name.frame.size.width, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:YXCharacterFont(14)} context:nil].size;
    
    _status.frame = CGRectMake(_name.frame.origin.x, _money.frame.size.height + _money.frame.origin.y, textSize.width, 20);
    _status.text = tips;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
