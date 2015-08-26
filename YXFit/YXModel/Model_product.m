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
    product.product_price = [dict objectForKey:@"price"];
    product.product_standard_price = [dict objectForKey:@"standard_price"];
    product.product_count = [dict objectForKey:@"count"];
    product.product_description = [dict objectForKey:@"description"];
    product.product_created = [dict objectForKey:@"created"];
    product.product_modified = [dict objectForKey:@"modified"];
    product.product_pic_urls = [dict objectForKey:@"pic_urls"];
    return product;
}
@end
