//
//  CountView.h
//  YXClient
//
//  Created by 何军 on 12/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountView : UIView
@property(nonatomic, strong) NSString *maxCount;
@property(nonatomic,copy) void(^countChange)(NSString *);
@end
