//
//  MainListCell.m
//  YXClient
//
//  Created by 何军 on 13/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "MainListCell.h"
//#import "GradientView.h"
@interface MainListCell()
{
    UIImageView *_imageView;
    UILabel     *_summary;
    UILabel     *_name;
    UILabel     *_address;
    UILabel     *_price;
}
@end
@implementation MainListCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(240, 240, 240);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 210)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];

        UIView *gradient = [[UIView alloc] initWithFrame:CGRectMake(0, _imageView.height - 60, _imageView.width, 60)];
        gradient.backgroundColor = RGBA(0, 0, 0, 0.4);
        [_imageView addSubview:gradient];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 220, gradient.height - 30)];
        //  _describe.backgroundColor = [UIColor orangeColor];
        _name.textColor = [UIColor whiteColor];
        _name.textAlignment = NSTextAlignmentLeft;
        _name.font = YXCharacterFont(17);
       // _describe.numberOfLines = 0;
        [gradient addSubview:_name];
        
        _address = [[UILabel alloc] initWithFrame:CGRectMake(10, _name.height + _name.origin.y-3, 220, 20)];
        _address.textAlignment = NSTextAlignmentLeft;
        // _price.backgroundColor = [UIColor redColor];
        _address.textColor = [UIColor whiteColor];
        _address.font = YXCharacterFont(13);
        [gradient addSubview:_address];
        //
        _price = [[UILabel alloc] initWithFrame:CGRectMake(gradient.width - 70, _address.origin.y, 60, _address.height)];
        _price.textAlignment = NSTextAlignmentRight;
        // _price.backgroundColor = [UIColor redColor];
        _price.textColor = [UIColor whiteColor];
        _price.font = YXCharacterFont(13);
        [gradient addSubview:_price];
        
        
        
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, _imageView.height, ScreenWidth , 40)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        _summary = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, bgView.width - 10 * 2, bgView.height)];
        _summary.textColor = RGB(60, 60, 60);
        _summary.numberOfLines = 0;
        _summary.textAlignment = NSTextAlignmentLeft;
        _summary.font = YXCharacterFont(17);
        [bgView addSubview:_summary];
        
//        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, bgView.height - 0.5, bgView.width, 0.5)];
//        line.backgroundColor = [UIColor lightGrayColor];
//        [bgView addSubview:line];
    }
    return self;
}
- (void)setProduct:(Model_product *)product{
    _product = product;
    _name.text = product.product_name;
    _summary.text = product.product_summary;
    if ([product.product_distance isEqualToString:@"-1"]) {
        _address.text = [NSString stringWithFormat:@"%@", product.product_place];
    }else{
        _address.text = [NSString stringWithFormat:@"%@  %.1fKM", product.product_place, [product.product_distance floatValue]/1000];
    }
    
    _price.text = [NSString stringWithFormat:@"￥%@", product.product_price];
    NSString *str = [[product.product_pic_urls firstObject] objectForKey:@"thumbnail_pic"];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:str]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
