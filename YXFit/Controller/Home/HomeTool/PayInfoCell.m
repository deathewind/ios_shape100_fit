//
//  PayInfoCell.m
//  YXFit
//
//  Created by 何军 on 25/9/15.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "PayInfoCell.h"
@interface PayInfoCell()
{
    UIImageView *_icon;
    UILabel     *_label;
    UIImageView *_checkImage;
}
@end
@implementation PayInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 44, 44)];
        _icon.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_icon];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(_icon.origin.x + _icon.width + 10, 0, 150, _icon.height)];
        _label.font = YXCharacterFont(15);
        _label.textColor = RGB(60, 60, 60);
        [self.contentView addSubview:_label];
        
        _checkImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 44 - 10, 0, 44, 44)];
        _checkImage.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:_checkImage];
        
    }
    return self;
}
- (void)setIcon:(NSString *)icon callName:(NSString *)name{
    _icon.image = [UIImage imageFileName:icon];
    _label.text = name;
//    if ([name isEqualToString:@"微信支付"]) {
//        _checkImage.image = [UIImage imageFileName:@"pay_check.png"];
//    }
    
}
//- (void)setIsSelected:(BOOL)isSelected{
//    if (isSelected) {
//        _checkImage.image = [UIImage imageFileName:@"pay_check.png"];
//    }else{
//        _checkImage.image = [UIImage imageFileName:@"pay_uncheck.png"];
//    }
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    NSLog(@"111");
    [super setSelected:selected animated:animated];
    if (selected) {
      //  NSLog(@"111");
        _checkImage.image = [UIImage imageFileName:@"pay_check.png"];
    }else{
        _checkImage.image = [UIImage imageFileName:@"pay_uncheck.png"];
    }
    // Configure the view for the selected state
}

@end
