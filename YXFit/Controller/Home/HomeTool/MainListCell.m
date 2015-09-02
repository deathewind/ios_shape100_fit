//
//  MainListCell.m
//  YXClient
//
//  Created by 何军 on 13/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "MainListCell.h"

@interface MainListCell()
{
    UIImageView *_imageView;
    UILabel     *_name;
    UILabel     *_describe;
    UILabel     *_price;
}
@end
@implementation MainListCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(230, 230, 230);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, ScreenWidth , 118)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 100, bgView.height - 5 * 2)];
        [bgView addSubview:_imageView];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.width + _imageView.origin.x * 2, _imageView.origin.y + 5, bgView.width - _imageView.origin.x *3 - _imageView.width, 20)];
        _name.textColor = RGB(60, 60, 60);
        _name.numberOfLines = 0;
        _name.textAlignment = NSTextAlignmentLeft;
        _name.font = YXCharacterBoldFont(17);
        [bgView addSubview:_name];
        
        _describe = [[UILabel alloc] initWithFrame:CGRectMake(_name.origin.x, _name.height + _name.origin.y, _name.width, bgView.height - _name.height * 2 - _name.origin.y * 2)];
      //  _describe.backgroundColor = [UIColor orangeColor];
        _describe.textColor = [UIColor grayColor];
        _describe.textAlignment = NSTextAlignmentLeft;
        _describe.font = YXCharacterFont(15);
        _describe.numberOfLines = 0;
        [bgView addSubview:_describe];
        
        _price = [[UILabel alloc] initWithFrame:CGRectMake(_name.origin.x, _describe.height + _describe.origin.y, _name.width, _name.height)];
        _price.textAlignment = NSTextAlignmentRight;
       // _price.backgroundColor = [UIColor redColor];
        _price.textColor = [UIColor redColor];
        _price.font = YXCharacterBoldFont(17);
        [bgView addSubview:_price];
        
    }
    return self;
}
- (void)setProduct:(Model_product *)product{
    _product = product;
    _name.text = product.product_name;
    _price.text = [NSString stringWithFormat:@"￥%@", product.product_price];
    _describe.text = product.product_description;
    NSString *str = [[product.product_pic_urls firstObject] objectForKey:@"thumbnail_pic"];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:str]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
