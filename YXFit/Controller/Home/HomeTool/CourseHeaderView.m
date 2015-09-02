//
//  CourseHeaderView.m
//  YXClient
//
//  Created by 何军 on 13/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "CourseHeaderView.h"
@interface CourseHeaderView()
{
    UIImageView *_imageView;
    UILabel     *_left;
    UILabel     *_right;
    //UILabel     *_right1;
}
@end
@implementation CourseHeaderView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        //_imageView.backgroundColor = [UIColor redColor];
        [self addSubview:_imageView];
        
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 44, self.frame.size.width, 44)];
//        view.backgroundColor = RGBA(60, 60, 60, 0.3);
//        view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
//        [self addSubview:view];
//        
//        _left = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.frame.size.width/2 - 10, view.frame.size.height)];
//        _left.textAlignment = NSTextAlignmentLeft;
//        _left.textColor = RGB(60, 60, 60);
//        _left.font = YXCharacterFont(15);
//        [view addSubview:_left];
//        
//        _right = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width/2, 0, _left.frame.size.width, _left.frame.size.height)];
//        _right.backgroundColor = [UIColor clearColor];
//        _right.textColor = [UIColor redColor];
//        _right.textAlignment = NSTextAlignmentRight;
//        _right.font = YXCharacterFont(15);
//        [view addSubview:_right];
        
        _right = [[UILabel alloc] init];//WithFrame:CGRectMake(view.frame.size.width/2, 0, _left.frame.size.width, _left.frame.size.height)];
//        _right1 = [[UILabel alloc] initWithFrame:CGRectMake(_right.frame.size.width + _right.frame.origin.x + 2, 0, view.frame.size.width - _right.frame.size.width - _right.frame.origin.x - 2, _left.frame.size.height)];
//        _right1.backgroundColor = [UIColor clearColor];
//        _right1.textColor = [UIColor whiteColor];
//        _right1.textAlignment = NSTextAlignmentLeft;
//        _right1.font = YXCharacterFont(15);
//        [view addSubview:_right1];
        _right.backgroundColor = RGBA(60, 60, 60, 0.3);
        _right.textColor = [UIColor redColor];
        _right.textAlignment = NSTextAlignmentCenter;
        _right.font = YXCharacterFont(15);
        _right.layer.cornerRadius = 10;
        _right.clipsToBounds = YES;
        [self addSubview:_right];
        
    }
    return self;
}
- (void)setProduct:(Model_product *)product{
    NSString *str = [[product.product_pic_urls firstObject] objectForKey:@"thumbnail_pic"];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:str]];
    
    _left.text = product.product_name;
    
//    _right.text = [NSString stringWithFormat:@"￥%@", product.product_price];
//    
//    NSString *markString = [NSString stringWithFormat:@"￥%@", product.product_standard_price];
//    NSMutableAttributedString *attrMarkString = [[NSMutableAttributedString alloc] initWithString:markString];
//    [attrMarkString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, markString.length)];
//    _right1.attributedText = attrMarkString;
    
    NSString *price = [NSString stringWithFormat:@"￥%@￥%@", product.product_price, product.product_standard_price];
//    CGSize textSize = [price boundingRectWithSize:CGSizeMake(ScreenWidth/2, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:YXCharacterFont(16)} context:nil].size;
//    _right.frame = CGRectMake(self.width - textSize.width -10, self.height - 40, textSize.width, 40);
    
    
    NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc] initWithString:price];
  //  NSString *mackString = [NSString stringWithFormat:@"￥%@", product.product_standard_price];
    NSString *pricString = [NSString stringWithFormat:@"%@", product.product_price];
    [priceString addAttribute:NSFontAttributeName value:YXCharacterFont(20)
                        range:[price rangeOfString:pricString]];
    NSRange range = NSMakeRange(pricString.length + 1, price.length - pricString.length - 1);
    [priceString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                        range:range];
    [priceString addAttribute:NSForegroundColorAttributeName
     
                        value:RGB(60, 60, 60)
     
                        range:range];
    CGSize textSize = [priceString boundingRectWithSize:CGSizeMake(ScreenWidth/2, 40) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    _right.frame = CGRectMake(self.width - textSize.width -30, self.height - 40, textSize.width + 20, 40);
    _right.attributedText = priceString;
}
@end
