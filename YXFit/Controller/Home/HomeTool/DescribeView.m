//
//  DescribeView.m
//  YXClient
//
//  Created by 何军 on 17/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "DescribeView.h"
@interface DescribeView()
{
    UILabel *_label;
}
@end
@implementation DescribeView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.width - 10 * 2, self.height)];
        _label.font = YXCharacterFont(16);
        _label.numberOfLines = 0;
        [self addSubview:_label];
        
    }
    return self;
}
- (void)setDescribe:(NSString *)describe{
//    CGSize textSize = [describe boundingRectWithSize:CGSizeMake(ScreenWidth - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:YXCharacterFont(16)} context:nil].size;
//    self.frame = CGRectMake(0, 0, ScreenHeight, textSize.height);
//    _label.frame = CGRectMake(10, 0, self.width - 10 * 2, self.height);
    _label.text = describe;
}

@end
