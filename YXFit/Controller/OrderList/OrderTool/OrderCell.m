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
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 105)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        
//        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 130, bgView.height - 5 * 2)];
//        _imageView.contentMode = UIViewContentModeScaleAspectFit;
//        [bgView addSubview:_imageView];
//        
//        _name = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.width + _imageView.origin.x * 2, _imageView.origin.y * 2, bgView.width - _imageView.width - _imageView.origin.x * 3, 20)];
//        _name.textColor = RGB(60, 60, 60);
//       // _name.backgroundColor = [UIColor redColor];
//        _name.numberOfLines = 0;
//        _name.textAlignment = NSTextAlignmentLeft;
//        _name.font = YXCharacterBoldFont(17);
//        [bgView addSubview:_name];
//        
//        _time = [[UILabel alloc] initWithFrame:CGRectMake(_name.frame.origin.x, _name.frame.size.height + _name.frame.origin.y, _name.frame.size.width, 20)];
//        _time.textColor = [UIColor lightGrayColor];
//        _time.textAlignment = NSTextAlignmentLeft;
//        _time.font = YXCharacterFont(13);
//        [bgView addSubview:_time];
//        
//        _coach = [[UILabel alloc] initWithFrame:CGRectMake(_name.frame.origin.x, _time.frame.size.height + _time.frame.origin.y, _name.frame.size.width, 20)];
//        _coach.textColor = [UIColor lightGrayColor];
//        _coach.textAlignment = NSTextAlignmentLeft;
//        _coach.font = YXCharacterFont(13);
//        [bgView addSubview:_coach];
//        
//        _money = [[UILabel alloc] initWithFrame:CGRectMake(_name.frame.origin.x, _coach.frame.size.height + _coach.frame.origin.y, _name.frame.size.width, 20)];
//        _money.textColor = [UIColor lightGrayColor];
//        _money.textAlignment = NSTextAlignmentLeft;
//        _money.font = YXCharacterFont(13);
//        [bgView addSubview:_money];
//        
//        _status = [[UILabel alloc] init];//WithFrame:CGRectMake(_name.frame.origin.x, _money.frame.size.height + _money.frame.origin.y, _name.frame.size.width, 20)];
//        _status.backgroundColor = [UIColor grayColor];
//        _status.textColor = [UIColor lightGrayColor];
//        _status.textAlignment = NSTextAlignmentCenter;
//        _status.font = YXCharacterFont(13);
//        [bgView addSubview:_status];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 210, 30)];
        _name.textColor = RGB(60, 60, 60);
        // _name.backgroundColor = [UIColor redColor];
        _name.textAlignment = NSTextAlignmentLeft;
        _name.font = YXCharacterBoldFont(16);
        [bgView addSubview:_name];
        
        _status = [[UILabel alloc] initWithFrame:CGRectMake(_name.origin.x + _name.width, 0, ScreenWidth - _name.origin.x * 2 - _name.width, _name.height)];//WithFrame:CGRectMake(_name.frame.origin.x, _money.frame.size.height + _money.frame.origin.y, _name.frame.size.width, 20)];
       // _status.backgroundColor = [UIColor grayColor];
        _status.textColor = [UIColor lightGrayColor];
        _status.textAlignment = NSTextAlignmentRight;
        _status.font = YXCharacterFont(15);
        [bgView addSubview:_status];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _name.height, ScreenWidth, 1)];
        line.backgroundColor = RGB(240, 240, 240);
        [bgView addSubview:line];
        
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_name.origin.x, _name.height + 5, 100, bgView.height - _name.height - 5 - 5)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
       // _imageView.clipsToBounds = YES;
        [bgView addSubview:_imageView];
        

        _time = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.origin.x + _imageView.width + 10, _imageView.origin.y + 5, ScreenWidth - _imageView.width - _imageView.origin.x * 2, 20)];
        _time.textColor = [UIColor lightGrayColor];
        _time.textAlignment = NSTextAlignmentLeft;
        _time.font = YXCharacterFont(13);
        [bgView addSubview:_time];
        
        
        _money = [[UILabel alloc] initWithFrame:CGRectMake(_time.origin.x, _time.frame.size.height + _time.frame.origin.y , _time.width, 20)];
        _money.textColor = [UIColor lightGrayColor];
        _money.textAlignment = NSTextAlignmentLeft;
        _money.font = YXCharacterFont(13);
        [bgView addSubview:_money];
        
        _coach = [[UILabel alloc] initWithFrame:CGRectMake(_money.frame.origin.x, _money.frame.size.height + _money.frame.origin.y, _money.frame.size.width, 20)];
        _coach.textColor = [UIColor lightGrayColor];
        _coach.textAlignment = NSTextAlignmentLeft;
        _coach.font = YXCharacterFont(13);
        [bgView addSubview:_coach];


    }
    return self;
}
- (void)setOrder:(Model_order *)order{
    _order = order;
    NSString *str = [[order.order_pic_urls firstObject] objectForKey:@"thumbnail_pic"];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:str]];
    
    _name.text = order.order_title;
    _time.text = [NSString stringWithFormat:@"购买时间: %@", order.order_created];
    _coach.text = [NSString stringWithFormat:@"上课时间: %@", order.order_created];
    _money.text = [NSString stringWithFormat:@"总额: ￥%@  数量: %@", order.order_price, order.order_count];
    
    NSString *status = [NSString stringWithFormat:@"%@", order.order_status];
    NSString *tips;
    UIColor *color;
    if ([status isEqualToString:@"0"]) {
        tips = @"待付款";
    }
    if ([status isEqualToString:@"1"]) {
        tips = @"已付款";
    }
    if ([status isEqualToString:@"2"]) {
        tips = @"已发货";
        color = RGB(199, 21, 133);
    }
    if ([status isEqualToString:@"3"]) {
        tips = @"已签收";
    }
    if ([status isEqualToString:@"4"]) {
        tips = @"交易成功";
    }
    if ([status isEqualToString:@"5"]) {
        tips = @"交易关闭";
    }
  //  CGSize  textSize = [tips sizeWithFont:YXCharacterFont(14) constrainedToSize:CGSizeMake(_name.frame.size.width, 20) lineBreakMode:NSLineBreakByWordWrapping];
  //  CGSize textSize = [tips boundingRectWithSize:CGSizeMake(_name.frame.size.width, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:YXCharacterFont(14)} context:nil].size;
    
  //  _status.frame = CGRectMake(_name.frame.origin.x, _money.frame.size.height + _money.frame.origin.y, textSize.width, 20);
    _status.text = tips;
    _status.textColor = color;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
