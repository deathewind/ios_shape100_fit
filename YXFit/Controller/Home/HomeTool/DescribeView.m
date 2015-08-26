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
        self.backgroundColor = [UIColor whiteColor];
        
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        [self addSubview:_label];
        
    }
    return self;
}
- (void)setDescribe:(NSString *)describe{
    _label.text = describe;
}

@end
