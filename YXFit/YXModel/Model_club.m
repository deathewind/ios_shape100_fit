//
//  Model_club.m
//  YXFit
//
//  Created by 何军 on 10/9/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "Model_club.h"

@implementation Model_club

+ (id)clubWithDictionary:(NSDictionary *)dict{
    Model_club *club = [[Model_club alloc] init];
    club.club_name = [dict objectForKey:@"name"];
    club.club_id = [dict objectForKey:@"id"];
    club.club_street = [dict objectForKey:@"street"];
    club.club_phone = [dict objectForKey:@"phone"];
    club.club_city = [dict objectForKey:@"city"];
    club.club_district = [dict objectForKey:@"district"];
    club.club_province = [dict objectForKey:@"province"];
    club.club_logo_url = [dict objectForKey:@"logo_url"];
    club.club_lat = [dict objectForKey:@"lat"];
    club.club_lon = [dict objectForKey:@"lon"];
    club.club_description = [dict objectForKey:@"description"];
    
    club.club_pic_urls = [dict objectForKey:@"pic_urls"];
    club.club_email = [dict objectForKey:@"email"];
    club.club_address = [dict objectForKey:@"address"];
    club.club_distance = [NSString stringWithFormat:@"%@", [dict objectForKey:@"distance"]];
    return club;
}
@end
