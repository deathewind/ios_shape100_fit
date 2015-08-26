//
//  MyHeaderView.m
//  YXFit
//
//  Created by 何军 on 24/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MyHeaderView.h"
@interface MyHeaderView()
{
    UIImageView *_imageView;
    UILabel *_name;
}
@end
@implementation MyHeaderView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-80)* 0.5, 70, 80, 80)];
        _imageView.layer.cornerRadius = _imageView.bounds.size.width / 2;
        _imageView.layer.borderWidth = 1.0;
        _imageView.layer.borderColor = RGB(156, 210, 122).CGColor;
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
        _imageView.userInteractionEnabled =YES;
        [_imageView addGestureRecognizer:portraitTap];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(60, _imageView.frame.origin.y + _imageView.frame.size.height + 10, 200, 30)];
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
            _imageView.image = [UIImage imageWithContentsOfFile:myIcon];
        }else{
            _imageView.image = [UIImage imageFileName:@"info_dp_no.png"];
        }
        
    }
    return self;
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
        _imageView.image = [UIImage imageWithContentsOfFile:myIcon];
    }else{
        _imageView.image = [UIImage imageFileName:@"info_dp_no.png"];
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
