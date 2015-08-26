//
//  Model_order.h
//  YXClient
//
//  Created by 何军 on 20/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_order : NSObject
@property(nonatomic, strong) NSString *order_id;
@property(nonatomic, strong) NSString *order_title;
@property(nonatomic, strong) NSString *order_price;
@property(nonatomic, strong) NSString *order_created;
@property(nonatomic, strong) NSString *order_count;
@property(nonatomic, strong) NSString *order_status;
@property(nonatomic, strong) NSString *order_payment;
@property(nonatomic, strong) NSArray  *order_pic_urls;
+ (id)orderWithDictionary:(NSDictionary *)dict;
@end
