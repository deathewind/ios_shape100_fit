//
//  Model_club.h
//  YXFit
//
//  Created by 何军 on 10/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_club : NSObject
@property(nonatomic, strong) NSString *club_address;
@property(nonatomic, strong) NSString *club_city;
@property(nonatomic, strong) NSString *club_id;
@property(nonatomic, strong) NSString *club_district;
@property(nonatomic, strong) NSString *club_email;
@property(nonatomic, strong) NSString *club_name;
@property(nonatomic, strong) NSString *club_phone;
@property(nonatomic, strong) NSArray  *club_pic_urls;
@property(nonatomic, strong) NSString *club_logo_url;
@property(nonatomic, strong) NSString *club_street;
@property(nonatomic, strong) NSString *club_province;

@property(nonatomic, strong) NSString *club_lat;
@property(nonatomic, strong) NSString *club_lon;
@property(nonatomic, strong) NSString *club_description;
@property(nonatomic, strong) NSString *club_distance;
+ (id)clubWithDictionary:(NSDictionary *)dict;
@end
