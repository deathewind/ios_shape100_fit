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
@property(nonatomic, strong) NSString *order_channel;
@property(nonatomic, strong) NSString *order_num;

@property(nonatomic, strong) NSString *buyer_id;
@property(nonatomic, strong) NSString *buyer_name;
@property(nonatomic, strong) NSString *class_address;
@property(nonatomic, strong) NSString *class_date;
@property(nonatomic, strong) NSString *class_start_time;
@property(nonatomic, strong) NSString *class_end_time;
@property(nonatomic, strong) NSString *consign_time;
@property(nonatomic, strong) NSString *end_time;

@property(nonatomic, strong) NSString *seller_id;
@property(nonatomic, strong) NSString *seller_name;
@property(nonatomic, strong) NSString *transaction_no;
@property(nonatomic, strong) NSString *pay_time;

+ (id)orderWithDictionary:(NSDictionary *)dict;
@end
