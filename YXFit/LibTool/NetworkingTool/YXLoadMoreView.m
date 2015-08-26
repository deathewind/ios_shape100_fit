//
//  YXLoadMoreView.m
//  YXClient
//
//  Created by 何军 on 5/2/15.
//  Copyright (c) 2015年 张明磊. All rights reserved.
//

#import "YXLoadMoreView.h"

@implementation YXLoadMoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *back = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 10, 3)];
//        back.layer.cornerRadius = 4.0;
//        back.layer.borderWidth = 1.0;
//        back.layer.borderColor = [UIColor lightGrayColor].CGColor;
        back.backgroundColor = [UIColor clearColor];
        [self addSubview:back];
        _activeView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(back.frame.size.width/2-(30+150)/2, back.frame.size.height/2-30/2, 30, 30)];
        _activeView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [back addSubview:_activeView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(back.frame.size.width/2 - 150/2, back.frame.size.height/2-34/2, 150, 34)];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.textAlignment = 1;
        _titleLabel.font = YXCharacterFont(13);
        [back addSubview:_titleLabel];
    }
    return self;
}
-(void)setErrorInter:(BOOL)errorInter{
    _errorInter = errorInter;
    if (errorInter) {
        _titleLabel.userInteractionEnabled = YES;
        _titleLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _titleLabel.layer.borderWidth = 1;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reloadNew:)];
        [_titleLabel addGestureRecognizer:tap];
    }else{
        _titleLabel.userInteractionEnabled = NO;
        _titleLabel.layer.borderColor = [UIColor clearColor].CGColor;
    }
}
- (void)reloadNew:(UITapGestureRecognizer*)tap{
    [self.delegate loadNewDate];
}
@end
