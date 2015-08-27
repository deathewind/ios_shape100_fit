//
//  Model_product.h
//  YXClient
//
//  Created by 何军 on 17/8/15.
//  Copyright (c) 2015年 Shape100 Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_product : NSObject
@property(nonatomic, strong) NSString *product_id;
@property(nonatomic, strong) NSString *product_name;
@property(nonatomic, strong) NSString *product_price;
@property(nonatomic, strong) NSString *product_standard_price;
@property(nonatomic, strong) NSString *product_num;
@property(nonatomic, strong) NSString *product_description;
@property(nonatomic, strong) NSString *product_created;
@property(nonatomic, strong) NSString *product_modified;
@property(nonatomic, strong) NSArray  *product_pic_urls;
+ (id)productWithDictionary:(NSDictionary *)dict;
@end
