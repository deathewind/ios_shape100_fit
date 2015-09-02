//
//  Model_product.m
//  YXClient
//
//  Created by 何军 on 17/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import "Model_product.h"

@implementation Model_product
+ (id)productWithDictionary:(NSDictionary *)dict{
    Model_product *product = [[Model_product alloc] init];
    product.product_id = [dict objectForKey:@"product_id"];
    product.product_name = [dict objectForKey:@"name"];
    NSString *price;
    if ([[dict objectForKey:@"price"] intValue]<100) {
        price = [NSString stringWithFormat:@"%.2f",[[dict objectForKey:@"price"] floatValue]/100];
    }else{
        price = [NSString stringWithFormat:@"%d",[[dict objectForKey:@"price"] intValue]/100];
    }
    product.product_price = price;
    
    NSString *stand_price;
    if ([[dict objectForKey:@"standard_price"] intValue]<100) {
        stand_price = [NSString stringWithFormat:@"%.2f",[[dict objectForKey:@"standard_price"] floatValue]/100];
    }else{
        stand_price = [NSString stringWithFormat:@"%d",[[dict objectForKey:@"standard_price"] intValue]/100];
    }
    product.product_standard_price = stand_price;
    product.product_num = [NSString stringWithFormat:@"%@", [dict objectForKey:@"num"]];
    product.product_description = [dict objectForKey:@"description"];
    product.product_created = [dict objectForKey:@"created"];
    product.product_modified = [dict objectForKey:@"modified"];
    product.product_pic_urls = [dict objectForKey:@"pic_urls"];
    return product;
}
@end
