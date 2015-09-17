//
//  MyHeaderExpandView.m
//  YXFit
//
//  Created by 何军 on 9/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MyHeaderExpandView.h"


#define kDefaultHeaderFrame CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
@interface MyHeaderExpandView()

@property (weak, nonatomic) UIScrollView *imageScrollView;
//@property (weak, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIImageView *headerView;
@end
@implementation MyHeaderExpandView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.imageScrollView = scrollView;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:scrollView.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        // imageView.image = image;
        imageView.image = [UIImage imageFileName:@"myCenter_back_one.png"];
       // self.imageView = imageView;
        [self.imageScrollView addSubview:imageView];
        [self addSubview:self.imageScrollView];
        
        
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-70)* 0.5, 55, 70, 70)];
        _headerView.layer.cornerRadius = _headerView.bounds.size.width / 2;
        _headerView.layer.borderWidth = 1.0;
        _headerView.layer.borderColor = RGB(156, 210, 122).CGColor;
        _headerView.clipsToBounds = YES;
        _headerView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_headerView];
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
        _headerView.userInteractionEnabled =YES;
        [_headerView addGestureRecognizer:portraitTap];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(60, _headerView.frame.origin.y + _headerView.frame.size.height + 5, 200, 30)];
        _name.backgroundColor = [UIColor clearColor];
        _name.textColor = [UIColor whiteColor];
        _name.textAlignment = NSTextAlignmentCenter;
        _name.font = YXCharacterBoldFont(16);
        [self addSubview:_name];
        
        NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:YXUserName];
        if (user) {
            _name.text = user;
        }else{
            _name.text = @"快速登录";
        }
        NSString *myIcon = [[NSUserDefaults standardUserDefaults] objectForKey:YXUserIcon];
        if (myIcon) {
            _headerView.image = [UIImage imageWithContentsOfFile:myIcon];
        }else{
            _headerView.image = [UIImage imageFileName:@"info_dp_no.png"];
        }

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

- (void)setNameAndImage{
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:YXUserName];
    if (user) {
        _name.text = user;
    }else{
        _name.text = @"快速登录";
    }
    NSString *myIcon = [[NSUserDefaults standardUserDefaults] objectForKey:YXUserIcon];
    if (myIcon) {
        _headerView.image = [UIImage imageWithContentsOfFile:myIcon];
    }else{
        _headerView.image = [UIImage imageFileName:@"info_dp_no.png"];
    }
    
}
- (void)editPortrait:(UITapGestureRecognizer *)tap{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:YXToken];
    if (token == nil) {
        if ([_delegate respondsToSelector:@selector(showPortrait:)]) {
            [_delegate showPortrait:tap];
        }
    }
}
@end
