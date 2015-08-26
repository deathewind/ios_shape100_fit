//
//  Model_user.m
//  YXFit
//
//  Created by 何军 on 24/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "Model_user.h"

@implementation Model_user
static Model_user *UserManagerInstance = nil;
+ (Model_user *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UserManagerInstance = [[self alloc] init];
    });
    return UserManagerInstance;
}
@end
