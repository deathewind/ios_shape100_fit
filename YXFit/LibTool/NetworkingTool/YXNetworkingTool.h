//
//  YXNetworkingTool.h
//  YXFit
//
//  Created by 何军 on 24/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^Success)(id JSON);
typedef void (^Failure)(NSError *error,id JSON);

typedef NS_ENUM(int, RequestMethod){
    GET,
    POST,
    PUT
};

@interface YXNetworkingTool : NSObject
+ (YXNetworkingTool *)sharedInstance;
#pragma mark - 用户登录相关
- (void)userLogin:(NSString *)name password:(NSString *)password success:(Success)success failure:(Failure)failure;
- (void)getVerifyCode:(NSString *)phoneNum success:(Success)success failure:(Failure)failure;
- (void)registWith:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;
- (void)findPassword:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;
#pragma mark - 用户信息相关
- (void)uploadImagePath:(NSString *)path success:(Success)success failure:(Failure)failure;
- (void)updataUserInfo:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;
//获取用户信息
- (void)getUserInfomation:(NSString *)userID success:(Success)success failure:(Failure)failure;
#pragma mark - 支付相关
//商品列表
- (void)getProductListSuccess:(Success)success failure:(Failure)failure;
- (void)getProductDetailWithID:(NSString *)productID success:(Success)success failure:(Failure)failure;
- (void)payWithOrder:(NSString *)order channel:(NSString *)channel success:(Success)success failure:(Failure)failure;
- (void)createOrderWithProduct:(NSString *)productID count:(NSString *)count success:(Success)success failure:(Failure)failure;
- (void)getTradeList:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;
- (void)getOrderDetailWithID:(NSString *)orderID success:(Success)success failure:(Failure)failure;

@end
