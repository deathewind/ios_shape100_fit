//
//  YXIndicatorView.m
//  YXFit
//
//  Created by 何军 on 28/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXIndicatorView.h"
static CGFloat kRTSpinKitDegToRad = 0.0174532925;
@implementation YXIndicatorView
-(instancetype)initWithColor:(UIColor*)color {
    self = [super init];
    if (self) {
        _color = color;
        [self sizeToFit];
        
        NSTimeInterval beginTime = CACurrentMediaTime();
        CGFloat cubeSize = floor(CGRectGetWidth(self.bounds) / 3.0);
        CGFloat widthMinusCubeSize = CGRectGetWidth(self.bounds) - cubeSize;
        
        for (NSInteger i=0; i<2; i+=1) {
            CALayer *cube = [CALayer layer];
            cube.backgroundColor = color.CGColor;
            cube.frame = CGRectMake(0.0, 0.0, cubeSize, cubeSize);
            cube.anchorPoint = CGPointMake(0.5, 0.5);
            
            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            anim.removedOnCompletion = NO;
            anim.beginTime = beginTime - (i * 0.9);
            anim.duration = 1.8;
            anim.repeatCount = HUGE_VALF;
            
            anim.keyTimes = @[@(0.0), @(0.25), @(0.50), @(0.75), @(1.0)];
            
            anim.timingFunctions = @[
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                     ];
            
            CATransform3D t0 = CATransform3DIdentity;
            
            CATransform3D t1 = CATransform3DMakeTranslation(widthMinusCubeSize, 0.0, 0.0);
            t1 = CATransform3DRotate(t1, -90.0 * kRTSpinKitDegToRad, 0.0, 0.0, 1.0);
            t1 = CATransform3DScale(t1, 0.5, 0.5, 1.0);
            
            CATransform3D t2 = CATransform3DMakeTranslation(widthMinusCubeSize, widthMinusCubeSize, 0.0);
            t2 = CATransform3DRotate(t2, -180.0 * kRTSpinKitDegToRad, 0.0, 0.0, 1.0);
            t2 = CATransform3DScale(t2, 1.0, 1.0, 1.0);
            
            CATransform3D t3 = CATransform3DMakeTranslation(0.0, widthMinusCubeSize, 0.0);
            t3 = CATransform3DRotate(t3, -270.0 * kRTSpinKitDegToRad, 0.0, 0.0, 1.0);
            t3 = CATransform3DScale(t3, 0.5, 0.5, 1.0);
            
            CATransform3D t4 = CATransform3DMakeTranslation(0.0, 0.0, 0.0);
            t4 = CATransform3DRotate(t4, -360.0 * kRTSpinKitDegToRad, 0.0, 0.0, 1.0);
            t4 = CATransform3DScale(t4, 1.0, 1.0, 1.0);
            
            
            anim.values = @[[NSValue valueWithCATransform3D:t0],
                            [NSValue valueWithCATransform3D:t1],
                            [NSValue valueWithCATransform3D:t2],
                            [NSValue valueWithCATransform3D:t3],
                            [NSValue valueWithCATransform3D:t4]];
            
            [self.layer addSublayer:cube];
            [cube addAnimation:anim forKey:@"spinkit-anim"];
        }

    }
    return self;
}
-(void)startAnimating {
    self.hidden = NO;
    //self.stopped = NO;
    [self resumeLayers];
}

-(void)stopAnimating {
//    if (self.hidesWhenStopped) {
//        self.hidden = YES;
//    }
    
    //self.stopped = YES;
    [self pauseLayers];
}

-(void)pauseLayers {
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
    self.hidden = YES;
}

-(void)resumeLayers {
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

-(CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(37.0, 37.0);
}

-(void)setColor:(UIColor *)color {
    _color = color;
    
    for (CALayer *l in self.layer.sublayers) {
        l.backgroundColor = color.CGColor;
    }
}

@end
