//
//  PayView.m
//  YXClient
//
//  Created by 何军 on 17/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "PayView.h"
@interface PayView()
{
    UIImageView *_wxImage;
    UIImageView *_alipayImage;
}
@end
@implementation PayView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *first = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        first.backgroundColor = [UIColor clearColor];
        [self addSubview:first];
        UILabel *label_pay = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, first.frame.size.width - 10 * 2, 40)];
        label_pay.text = @"选择支付方式";
        label_pay.backgroundColor = [UIColor clearColor];
        label_pay.textAlignment = NSTextAlignmentLeft;
        label_pay.textColor = RGB(40, 40, 40);
        label_pay.font = YXCharacterFont(15);
        [first addSubview:label_pay];
        
        UIButton *weix_pay = [UIButton buttonWithType:UIButtonTypeCustom];
        weix_pay.frame = CGRectMake(0, label_pay.frame.size.height + 2, self.frame.size.width, 44);
        weix_pay.backgroundColor = [UIColor whiteColor];
        [weix_pay addTarget:self action:@selector(payWay:) forControlEvents:UIControlEventTouchUpInside];
        weix_pay.tag = 100;
        [self addSubview:weix_pay];
        [self addSubviewBy:@"weixin" payName:@"微信支付" color:[UIColor greenColor] button:weix_pay];
        
        UIButton *alipay = [UIButton buttonWithType:UIButtonTypeCustom];
        alipay.frame = CGRectMake(0, weix_pay.frame.size.height + weix_pay.frame.origin.y + 2, self.frame.size.width, 44);
        alipay.backgroundColor = [UIColor whiteColor];
        [alipay addTarget:self action:@selector(payWay:) forControlEvents:UIControlEventTouchUpInside];
        alipay.tag = 101;
        [self addSubview:alipay];
        [self addSubviewBy:@"alipay" payName:@"支付宝" color:[UIColor orangeColor] button:alipay];
        
//        UIView *totel = [[UIView alloc] initWithFrame:CGRectMake(0, alipay.frame.origin.y + alipay.frame.size.height + 20, self.frame.size.width, 44)];
//        [self addSubview:totel];
//        [self addLabelWith:@"" right:@"" view:totel];
//        
//        UIView *coupon = [[UIView alloc] initWithFrame:CGRectMake(0, totel.frame.origin.y + totel.frame.size.height + 2, self.frame.size.width, 44)];
//        [self addSubview:coupon];
//        [self addLabelWith:@"" right:@"" view:coupon];
//        
//        UIView *balance = [[UIView alloc] initWithFrame:CGRectMake(0, coupon.frame.origin.y + coupon.frame.size.height + 2, self.frame.size.width, 44)];
//        [self addSubview:balance];
//        [self addLabelWith:@"" right:@"" view:balance];
//        
//        UIView *payOnline = [[UIView alloc] initWithFrame:CGRectMake(0, balance.frame.origin.y + balance.frame.size.height + 2, self.frame.size.width, 44)];
//        [self addSubview:payOnline];
//        [self addLabelWith:@"" right:@"" view:payOnline];
    }
    return self;
}
- (void)addSubviewBy:(NSString *)imageName payName:(NSString *)payName color:(UIColor *)color button:(UIButton *)view{
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 34, 34)];
    //image.backgroundColor = [UIColor redColor];
    image.contentMode = UIViewContentModeScaleAspectFit;
    image.image = [UIImage imageFileName:imageName];
    [view addSubview:image];
    
    CGSize  textSize = [payName sizeWithFont:YXCharacterBoldFont(16) constrainedToSize:CGSizeMake(200, 100) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(image.frame.size.width + image.frame.origin.x + 10, 9, textSize.width + 10, 24)];
    label.backgroundColor = color;
    label.layer.cornerRadius = 5;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = payName;
    label.font = YXCharacterBoldFont(16);
    [view addSubview:label];
    
    UIImageView *check = [[UIImageView alloc] initWithFrame:CGRectMake(view.frame.size.width - 20 -20, 11, 20, 20)];
    if (view.tag == 100) {
        _wxImage = check;
        check.backgroundColor = [UIColor greenColor];
        check.image = [UIImage imageFileName:@"pay_check.png"];
    }else{
        check.backgroundColor = [UIColor grayColor];
        _alipayImage = check;
        check.image = [UIImage imageFileName:@"pay_uncheck.png"];
    }
    [view addSubview:check];
}
//- (void)addLabelWith:(NSString *)leftString right:(NSString *)rightString view:(UIView *)view{
//    UILabel *left = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width/2 - 40/2, view.frame.size.height)];
//    left.text = leftString;
//    left.textAlignment = NSTextAlignmentLeft;
//    [view addSubview:left];
//    
//    UILabel *right = [[UILabel alloc] initWithFrame:CGRectMake(left.frame.origin.x + left.frame.size.width, 0, left.frame.size.width, view.frame.size.height)];
//    right.text = rightString;
//    right.textAlignment = NSTextAlignmentRight;
//    [view addSubview:right];
//}
- (void)payWay:(UIButton *)button{
    NSString *payString = nil;
    if (button.tag == 100) {
        payString = @"wx";
        _wxImage.image = [UIImage imageFileName:@"pay_check.png"];
        _alipayImage.image = [UIImage imageFileName:@"pay_uncheck.png"];
    }else{
        _alipayImage.image = [UIImage imageFileName:@"pay_check.png"];
        _wxImage.image = [UIImage imageFileName:@"pay_uncheck.png"];
        payString = @"alipay";
    }
    _payChange(payString);
}
@end
