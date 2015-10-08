//
//  Model_order.m
//  YXClient
//
//  Created by 何军 on 20/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "Model_order.h"

@implementation Model_order
+ (id)orderWithDictionary:(NSDictionary *)dict{
    Model_order *order = [[Model_order alloc] init];
    order.order_id = [NSString stringWithFormat:@"%@", [dict objectForKey:@"order_id"]];
    order.order_title = [dict objectForKey:@"title"];
    
    NSString *price;
    if ([[dict objectForKey:@"price"] intValue]<100) {
        price = [NSString stringWithFormat:@"%.2f",[[dict objectForKey:@"price"] floatValue]/100];
    }else{
        price = [NSString stringWithFormat:@"%d",[[dict objectForKey:@"price"] intValue]/100];
    }
    order.order_price = price;
    NSString *stand_price;
    if ([[dict objectForKey:@"payment"] intValue]<100) {
        stand_price = [NSString stringWithFormat:@"%.2f",[[dict objectForKey:@"payment"] floatValue]/100];
    }else{
        stand_price = [NSString stringWithFormat:@"%d",[[dict objectForKey:@"payment"] intValue]/100];
    }
    order.order_payment = stand_price;
  //  order.order_price = [dict objectForKey:@"price"];
    order.order_created = [dict objectForKey:@"created"];
    order.order_status = [NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
    order.order_count = [dict objectForKey:@"num"];
    order.order_pic_urls = [dict objectForKey:@"pic_urls"];
    return order;
}

-(NSString *)order_created{
    NSDateFormatter *dataTime = [[NSDateFormatter alloc] init];
    dataTime.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    dataTime.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    // 格式取出的字符串，获取时间对象
    NSDate *createdTime = [dataTime dateFromString:_order_created];
    dataTime.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *strDate = [dataTime stringFromDate:createdTime];
    return strDate;

}

@end
