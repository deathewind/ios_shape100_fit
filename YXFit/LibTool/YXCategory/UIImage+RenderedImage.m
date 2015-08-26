//
//  UIImage+RenderedImage.m
//  SeaShoping
//
//  Created by 何军 on 8/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIImage+RenderedImage.h"

@implementation UIImage (RenderedImage)
+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size {
    
    UIImage *image = nil;
    UIGraphicsBeginImageContext(size);
    [color setFill];
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0., 0., size.width, size.height));
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 加载图片,不常驻内存 -
+ (UIImage *)imageFileName:(NSString *)filename{
    @autoreleasepool{
        NSString *imageFile = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], filename];
        UIImage *image =  [UIImage imageWithContentsOfFile:imageFile];
        if(image){
            return image;
        }
        else{
            UIImage *image_content =  [UIImage imageNamed:filename];
            return image_content;
        }
    }
}

/**
 *  加载网络图片
 */
+ (UIImage *)imageURLPath:(NSString *)urlPath
{
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlPath]];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}
@end
