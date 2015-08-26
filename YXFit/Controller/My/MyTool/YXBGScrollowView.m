//
//  YXPeopleBGView.m
//  YXClient
//
//  Created by 何军 on 25/6/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "YXBGScrollowView.h"
@interface YXBGScrollowView()<UIScrollViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIImageView     *_bgImageView;
    UIView          *_foregroundView;
    UITableView     *_foregroundTableView;
    UIScrollView    *_backgroundScrollView;
    UIScrollView    *_foregroundScrollView;
}
@property (nonatomic, assign)       CGFloat                     backgroundHeight;
@property (nonatomic, weak)         id<UIScrollViewDelegate>    scrollViewDelegate;
@end
@implementation YXBGScrollowView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}
- (void)layoutSubviews{
    if (!_bgImageView) {
        [self addBGView];
    }
    if (!_backgroundScrollView) {
        [self backgroundView];
    }
    if (!_foregroundView) {
        [self addForegroundView];
    }
    if (!_foregroundScrollView) {
        [self addForeScrollView];
    }
    [self setBackgroundHeight:260.0f];
}
- (void)addBGView{
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, BGImageHeight)];
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    NSData *dataImage = UIImagePNGRepresentation([UIImage imageWithContentsOfFile:kUserBackgroundPath]);
    if (dataImage != 0) {
        _bgImageView.image = [UIImage imageWithContentsOfFile:kUserBackgroundPath];
    } else {
        _bgImageView.image = [UIImage imageFileName:@"myCenter_back_one.png"];
    }

}
- (void)backgroundView{
    _backgroundScrollView = [[UIScrollView alloc] init];
    _backgroundScrollView.backgroundColor = [UIColor clearColor];
    _backgroundScrollView.showsHorizontalScrollIndicator = NO;
    _backgroundScrollView.showsVerticalScrollIndicator = NO;
    [_backgroundScrollView addSubview:_bgImageView];
    [self addSubview:_backgroundScrollView];

    
}
- (void)addForegroundView{
    _foregroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    _foregroundView.backgroundColor = [UIColor clearColor];
    if ([_delegate respondsToSelector:@selector(detailsForegroundView:)]) {
        [_delegate detailsForegroundView:_foregroundView];
    }
}
- (void)addForeScrollView{
    _foregroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 220)];
    _foregroundScrollView.backgroundColor = [UIColor clearColor];
    _foregroundScrollView.delegate = self;
    _foregroundScrollView.showsHorizontalScrollIndicator = NO;
    _foregroundScrollView.showsVerticalScrollIndicator = NO;
    [_foregroundScrollView addSubview:_foregroundView];
    _foregroundScrollView.contentSize = CGSizeMake(self.frame.size.width, 700);
    [self addSubview:_foregroundScrollView];
}
- (void)changeLong:(UILongPressGestureRecognizer *)sender{
  //  NSLog(@"1111");
}
#pragma mark - Internal Methods -
- (void)setBackgroundHeight:(CGFloat)backgroundHeight{
    _backgroundHeight = backgroundHeight;
    [self updateBackgroundFrame];
    [self updateForegroundFrame];
    [self updateContentOffset];
}
- (void)updateBackgroundFrame{
    _backgroundScrollView.frame = CGRectMake(0.0f,
                                                 -20,
                                                 self.frame.size.width,
                                                 self.frame.size.height);
    _backgroundScrollView.contentSize = CGSizeMake(self.frame.size.width,
                                                       self.frame.size.height);
    _backgroundScrollView.contentOffset = CGPointZero;
    _bgImageView.frame =
    CGRectMake(0.0f,
               floorf((_backgroundHeight - _bgImageView.frame.size.height)* 0.5),
               self.frame.size.width,
               _bgImageView.frame.size.height);
}
- (void)updateForegroundFrame{
    _foregroundView.frame = CGRectMake(0.0f,
                                           0.0,
                                           _foregroundView.frame.size.width,
                                           _foregroundView.frame.size.height - 10);
    _foregroundScrollView.frame = self.bounds;
    _foregroundScrollView.contentSize =
    CGSizeMake(_foregroundView.frame.size.width,
               570);
}
/** 双scroll叠层 视觉差效果调节**/
- (void)updateContentOffset
{
    CGFloat offsetY   = _foregroundScrollView.contentOffset.y;
    CGFloat threshold = _bgImageView.frame.size.height - _backgroundHeight;
    if (-offsetY > threshold && offsetY < 0.0f)
    {
        _bgImageView.frame = CGRectMake(0 + offsetY, 28 + offsetY, 320 - offsetY * 2, 201 - offsetY * 2);
        _backgroundScrollView.contentOffset = CGPointMake(0.0f, floorf(offsetY* 0.5));
    }
    else if (offsetY < 0.0f)
    {
        _bgImageView.frame = CGRectMake(0 + offsetY,  28 + offsetY, 320 - offsetY * 2, 201 - offsetY * 2);
        _backgroundScrollView.contentOffset = CGPointMake(0.0f, offsetY + floorf(threshold* 0.5));
    }
    else
    {   /** 上推视觉差**/
        if(offsetY == 0)
        {
            return;
        }
        //NSLog(@"%f",floorf(offsetY/3.8));
        //_backgroundView.frame = CGRectMake(0,  0, 320, 201);
        _backgroundScrollView.contentOffset = CGPointMake(0.0f,floorf(offsetY/3.8));
    }
}

#pragma mark - UIScrollViewDelegate Protocol Methods -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self updateContentOffset];
//    if ([self.scrollViewDelegate respondsToSelector:_cmd]) {
//        [self.scrollViewDelegate scrollViewDidScroll:scrollView];
//    }
}
- (void)setScrollEnble:(BOOL)scrollEnble{
    _foregroundScrollView.scrollEnabled = scrollEnble;
}

- (void)changeBGImage:(UIImage *)image{
    _bgImageView.image = image;
}
@end
