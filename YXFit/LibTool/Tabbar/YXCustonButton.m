

//
//  YXCustonButton.m
//  YXClient
//
//  Created by 何军 on 18/5/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "YXCustonButton.h"

@implementation YXCustonButton
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * 0.6;
    
    return CGRectMake(0, 0, imageW, imageH);
}
 - (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height *0.6;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);
}

- (void)popOutsideWithDuration:(NSTimeInterval)duration {
    __weak typeof(self) weakSelf = self;
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{
            typeof(self) strongSelf = weakSelf;
            strongSelf.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations: ^{
            typeof(self) strongSelf = weakSelf;
            strongSelf.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations: ^{
            typeof(self) strongSelf = weakSelf;
            strongSelf.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    } completion:nil];
}

- (void)popInsideWithDuration:(NSTimeInterval)duration {
    __weak typeof(self) weakSelf = self;
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 2.0 animations: ^{
            typeof(self) strongSelf = weakSelf;
            strongSelf.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/2.0 relativeDuration:1/2.0 animations: ^{
            typeof(self) strongSelf = weakSelf;
            strongSelf.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    } completion:nil];
}
@end
/*
 
 #import "JKUIButton.h"
 @interface JKUIButton()
 @property (strong,nonatomic) CAShapeLayer *circleLayer;
 @property (assign,nonatomic) CGSize size;
 @property (strong,nonatomic) CAShapeLayer *firstLayer;
 @property (strong,nonatomic) CAShapeLayer *secondLayer;
 @end
 @implementation JKUIButton
 -(instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color{
 if([self initWithFrame:frame]){
 self.color = color;
 
 [self prepareLayers];
 }
 return self;
 }
 
 -(void)prepareLayers{
 
 CGSize size = self.size = self.bounds.size;
 self.circleLayer = [CAShapeLayer layer];
 self.circleLayer.frame = self.bounds;
 [self.layer addSublayer:self.circleLayer];
 
 self.circleLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width/2, size.height/2) radius:size.width/2 startAngle:-M_PI endAngle:M_PI clockwise:YES].CGPath;
 self.circleLayer.fillColor = [UIColor clearColor].CGColor;
 self.circleLayer.strokeColor = self.color.CGColor;
 self.circleLayer.lineWidth = 0.6f;
 //self.circleLayer.hidden = YES;
 
 //    CGMutablePathRef linePath1 = CGPathCreateMutable();
 //    CGPathMoveToPoint(linePath1, NULL, size.width*0.2, size.height*0.5);
 //    CGPathAddLineToPoint(linePath1, NULL, size.width*0.8, size.height*0.5);
 //
 //    self.firstLayer = [CAShapeLayer layer];
 //    self.firstLayer.frame = self.bounds;
 //    self.firstLayer.lineCap = kCALineCapRound;
 //    self.firstLayer.strokeColor = self.color.CGColor;
 //    self.firstLayer.lineWidth = 2.0f;
 //    self.firstLayer.path = linePath1;
 //    CGPathRelease(linePath1);
 //    [self.layer addSublayer:self.firstLayer];
 
 CGMutablePathRef linePath2 = CGPathCreateMutable();
 CGPathMoveToPoint(linePath2, NULL, size.width*0.5, size.height*0.3);
 CGPathAddLineToPoint(linePath2, NULL, size.width*0.5, size.height*0.7);
 
 self.secondLayer = [CAShapeLayer layer];
 self.secondLayer.frame = self.bounds;
 self.secondLayer.lineCap = kCALineCapRound;
 self.secondLayer.strokeColor = self.color.CGColor;
 self.secondLayer.lineWidth = 1.0f;
 self.secondLayer.path = linePath2;
 CGPathRelease(linePath2);
 [self.layer addSublayer:self.secondLayer];
 
 CGMutablePathRef linePath3 = CGPathCreateMutable();
 CGPathMoveToPoint(linePath3, NULL, size.width*0.3, size.height*0.7);
 CGPathAddLineToPoint(linePath3, NULL, size.width*0.6, size.height*0.7);
 
 
 
 //  self.firstLayer.hidden = YES;
 //  self.secondLayer.hidden = YES;
 
 }
 - (id)initWithFrame:(CGRect)frame
 {
 self = [super initWithFrame:frame];
 if (self) {
 
 }
 return self;
 }
 @end
 */
