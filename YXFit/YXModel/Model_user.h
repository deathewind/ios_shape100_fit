//
//  Model_user.h
//  YXFit
//
//  Created by 何军 on 24/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_user : NSObject
+ (Model_user *)sharedInstance;

@property (strong, nonatomic) NSString *string_token;
@property (strong, nonatomic) NSString *token_secret;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *screen_name;
@end
