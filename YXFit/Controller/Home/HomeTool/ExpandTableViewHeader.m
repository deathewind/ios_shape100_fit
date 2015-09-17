//
//  ExpandTableViewHeader.m
//  YXFit
//
//  Created by 何军 on 7/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ExpandTableViewHeader.h"
#import "GradientView.h"
//static CGFloat kParallaxDeltaFactor = 0.5f;
#define kDefaultHeaderFrame CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
@interface ExpandTableViewHeader()
{
    UILabel *_price;
}
@property (weak, nonatomic) UIScrollView *imageScrollView;
@property (weak, nonatomic) UIImageView *imageView;
@end
@implementation ExpandTableViewHeader
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.imageScrollView = scrollView;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:scrollView.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
       // imageView.image = image;
        self.imageView = imageView;
        [self.imageScrollView addSubview:imageView];
        [self addSubview:self.imageScrollView];
        
        GradientView *gradient = [[GradientView alloc] initWithFrame:CGRectMake(0, self.imageScrollView.height - 60, self.imageScrollView.width, 60) type:TRANSPARENT_GRADIENT_TYPE];
        gradient.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:gradient];
        
        _price = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - 155, 20, 140, gradient.height - 20)];
        _price.textAlignment = NSTextAlignmentRight;
        // _price.backgroundColor = [UIColor redColor];
        _price.textColor = RGB(199, 21, 133);
        _price.font = YXCharacterFont(17);
        [gradient addSubview:_price];
    }
    return self;
}

- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset
{
  //  CGRect frame = self.imageScrollView.frame;
    
    if (offset.y > 0 && self.clipsToBounds == NO)
    {
//        frame.origin.y = MAX(offset.y *kParallaxDeltaFactor, 0);
//        self.imageScrollView.frame = frame;
        // self.bluredImageView.alpha =   1 / kDefaultHeaderFrame.size.height * offset.y * 2;
        self.clipsToBounds = YES;
    }
    else
    {
        CGFloat delta = 0.0f;
        CGRect rect = kDefaultHeaderFrame;
        delta = fabs(MIN(0.0f, offset.y));
        rect.origin.y -= delta;
        rect.size.height += delta;
        self.imageScrollView.frame = rect;
        self.clipsToBounds = NO;
        //  self.headerTitleLabel.alpha = 1 - (delta) * 1 / kMaxTitleAlphaOffset;
    }
}
- (void)setProduct:(Model_product *)product{
    NSString *str = [[product.product_pic_urls firstObject] objectForKey:@"thumbnail_pic"];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:str]];
    NSString *price = [NSString stringWithFormat:@"￥%@￥%@", product.product_price, product.product_standard_price];
    
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
//    CGSize textSize = [priceString boundingRectWithSize:CGSizeMake(ScreenWidth/2, 40) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
//    _right.frame = CGRectMake(self.width - textSize.width -30, self.height - 40, textSize.width + 20, 40);
    _price.attributedText = priceString;

}

- (void)setClub:(Model_club *)club{
    NSString *str = [[club.club_pic_urls firstObject] objectForKey:@"thumbnail_pic"];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:str]];
}
/*
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

 */

@end
