//
//  PayView.h
//  YXClient
//
//  Created by 何军 on 17/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#define WEIX @"wx"
#define ALIPAY @"alipay"
@interface PayView : UIView
@property (nonatomic,copy) void(^payChange)(NSString *);
@end
