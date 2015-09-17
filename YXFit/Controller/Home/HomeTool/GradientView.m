//
//  GradientView.m
//  YXFit
//
//  Created by 何军 on 11/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView
- (id)initWithFrame:(CGRect)frame type:(int) type{
    self = [super initWithFrame:frame];
    if (self) {
        if (type == TRANSPARENT_GRADIENT_TYPE) {
            [self insertTransparentGradient];
        }else if (type == COLOR_GRADIENT_TYPE){
            [self insertColorGradient];
        }else {
            
        }
    }
    return self;
    
}
//Transparent Gradient Layer 透明度渐变
- (void) insertTransparentGradient {
    UIColor *colorOne = [UIColor colorWithRed:(33/255.0)  green:(33/255.0)  blue:(33/255.0)  alpha:0.0];
    UIColor *colorTwo = [UIColor colorWithRed:(33/255.0)  green:(33/255.0)  blue:(33/255.0)  alpha:0.4];
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    //crate gradient layer
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    headerLayer.frame = self.bounds;
    
    [self.layer insertSublayer:headerLayer atIndex:0];

}

//color gradient layer 颜色渐变不透明
- (void) insertColorGradient {
    
    UIColor *colorOne = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:(0/255.0)  green:(0/255.0)  blue:(0/255.0)  alpha:1.0];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    headerLayer.frame = self.bounds;
    
    [self.layer insertSublayer:headerLayer above:0];
    
}
@end
