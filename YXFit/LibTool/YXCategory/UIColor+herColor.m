//
//  UIColor+herColor.m
//  SeaShoping
//
//  Created by 何军 on 8/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIColor+herColor.h"

@implementation UIColor (herColor)
+ (UIColor *)hexFloatColor:(NSString *)hexStr {
    if (hexStr.length < 6)
        return nil;
    
    unsigned int red_, green_, blue_;
    NSRange exceptionRange;
    exceptionRange.length = 2;
    
    //red
    exceptionRange.location = 0;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&red_];
    
    //green
    exceptionRange.location = 2;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&green_];
    
    //blue
    exceptionRange.location = 4;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&blue_];
    
    UIColor *resultColor = RGB(red_, green_, blue_);
    return resultColor;
}
@end
