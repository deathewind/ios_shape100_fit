//
//  DetailCell.m
//  YXFit
//
//  Created by 何军 on 25/9/15.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "DetailCell.h"
@interface DetailCell()
{
    UILabel *_left;
    UILabel *_right;
}
@end
@implementation DetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHeight:(CGFloat)height{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _left = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, (ScreenWidth - 10 * 2)/2, height)];
        _left.textColor = RGB(60, 60, 60);
        _left.font = YXCharacterFont(15);
        _left.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_left];
        
        _right = [[UILabel alloc] initWithFrame:CGRectMake(_left.origin.x + _left.width, 0, _left.width, _left.height)];
        _right.textColor = RGB(60, 60, 60);
        _right.font = YXCharacterFont(15);
        _right.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_right];
    }
    return self;
}
- (void)setLeftString:(NSString *)left andOrderStatus:(NSString *)status{
    _left.text = left;
    NSString *sta = status;
    NSString *tips;
    if ([sta isEqualToString:@"0"]) {
        tips = @"等待买家付款";
    }
    if ([sta isEqualToString:@"1"]) {
        tips = @"买家已付款";
    }
    if ([sta isEqualToString:@"2"]) {
        tips = @"卖家已发货";
        _right.textColor = RGB(199, 21, 133);
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
//    CGSize textSize = [tips boundingRectWithSize:CGSizeMake(200, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:YXCharacterFont(15)} context:nil].size;
//    _status.frame = CGRectMake(self.width - 10 -textSize.width, 5, textSize.width, 20);
    
    
    _right.text = tips;

}
- (void)setLeftString:(NSString *)left rightString:(NSString *)right{
    _left.text = left;
    _right.text = right;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
