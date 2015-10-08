//
//  ToolService.m
//  YXFit
//
//  Created by 何军 on 24/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ToolService.h"

@implementation ToolService
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//加载各种第三方库
    });
}
@end
