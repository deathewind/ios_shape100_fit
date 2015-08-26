//
//  UIImage+RenderedImage.h
//  SeaShoping
//
//  Created by 何军 on 8/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RenderedImage)
+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size;

+ (UIImage *)imageFileName:(NSString *)filename;

+ (UIImage *)imageURLPath:(NSString *)urlPath;
@end
