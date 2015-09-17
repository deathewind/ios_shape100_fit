//
//  YXCollectionViewCell.m
//  YXFit
//
//  Created by 何军 on 9/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXCollectionViewCell.h"

@implementation YXCollectionViewCell
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        _dateLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _dateLabel.textColor = RGB(60, 60, 60);
        _dateLabel.textAlignment = NSTextAlignmentCenter;
       // _dateLabel.font = YXCharacterBoldFont(16);
        _dateLabel.font = YXCharacterFont(17);
       // _dateLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_dateLabel];
//        self.layer.borderWidth = 1;
//        self.layer.borderColor = RGB(210, 210, 210).CGColor;
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, CellLine)];
//        line.backgroundColor = RGB(210, 210, 210);
//        [self.contentView addSubview:line];
//        
//        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - CellLine, 0, CellLine, frame.size.height)];
//        line1.backgroundColor = RGB(210, 210, 210);
//        [self.contentView addSubview:line1];
    }
    return self;
}

- (void)setWeekend:(BOOL)weekend{
    _weekend = weekend;
    if (weekend) {
        _dateLabel.textColor = [UIColor orangeColor];
    }else{
        _dateLabel.textColor = RGB(60, 60, 60);
    }
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        _dateLabel.layer.cornerRadius = _dateLabel.frame.size.height / 2;
        _dateLabel.clipsToBounds = YES;
        _dateLabel.backgroundColor = RGB(199, 21, 133);
        _dateLabel.textColor = [UIColor whiteColor];
    } else {
        _dateLabel.backgroundColor = [UIColor clearColor];
        if (_weekend) {
            _dateLabel.textColor = [UIColor orangeColor];
        }else{
            _dateLabel.textColor = RGB(60, 60, 60);
        }

    }
    [super setSelected:selected];
}

@end

@implementation YXCollectionHeaderView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = RGB(245, 245, 245);
        _titleLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_titleLabel];

    }
    return self;
}
@end
@implementation YXCollectionFooterView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = self.bounds;
        [_button setTitle:@"加载更多" forState:UIControlStateNormal];
        [_button setTitleColor:RGB(136, 136, 136) forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:16];
        [_button addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
    }
    return self;
}
- (void)loadMore:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(loadMoreTime:)]) {
        [self.delegate loadMoreTime:button];
    }
}
@end