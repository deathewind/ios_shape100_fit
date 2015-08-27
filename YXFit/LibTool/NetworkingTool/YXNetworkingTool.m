//
//  YXNetworkingTool.m
//  YXFit
//
//  Created by 何军 on 24/8/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "YXNetworkingTool.h"
#import "AFNetworking.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonHMAC.h>
/**
 *  验证过程
 */
static NSString * const APP_VERSION             = @"1.0";
static NSString * const APP_SIGNATURE_METHOD    = @"HMAC-SHA1";
static NSString * const APP_CALLBACK            = @"oob";
/**
 *  接口地址
 */
//dev key
static NSString * const APP_KEY                 = @"01d8cd242b4d1b699fb73da981afbb75";
static NSString * const APP_SECRET              = @"7735ae22dd52b98d0e8ae4610cf57ddb";
static NSString * const YXHttp                  = @"http://api.dev.shape100.com/";
static NSString * const YXHttps                 = @"https://api.dev.shape100.com/";

/**
 *  用户注册
 */
static NSString * const YXGetMessage            = @"account/register/sms/invoke.json";
static NSString * const YXVerifyCode            = @"account/register/sms/confirm.json";
static NSString * const YXRegist                = @"account/register/sms/commit.json";
static NSString * const YXLogin                 = @"account/login.json";

static NSString * const YXChangePassword        = @"account/change_password.json";
static NSString * const YXResetPassword         = @"account/reset_password.json";
static NSString * const YXExitPhone             = @"account/update_sms.json";
/**
 *  用户信息及关系
 */
static NSString * const YXUserShow                          = @"users/show.json";
static NSString * const YXUserUpdate                        = @"account/update_profile.json";
/**
 *  版本检测
 */
static NSString * const YXCheckUpdate           = @"system/checkupdate.json";
/**
 *  图片上传
 */
static NSString * const YXUploadPic                = @"media/upload/pic.json";
static NSString * const YXUploadPicConfirm         = @"media/upload/pic_confirm.json";

/**
 *  支付相关
 */

static NSString * const YXPayTestKey = @"sk_test_4KGyXDm5q940nfPeDCSSmPyH";
static NSString * const YXPayURL = @"pay/charge.json";
static NSString * const YXProductList = @"product/list/homepage.json";
static NSString * const YXProductDetail = @"product/item/detail.json";
static NSString * const YXOrderCreate = @"trade/order/create.json";
static NSString * const YXTradeList = @"trade/list/bought.json";
static NSString * const YXOrderDetail = @"trade/order/detail.json";



static YXNetworkingTool *networkManager = nil;
@implementation YXNetworkingTool
+ (YXNetworkingTool *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[self alloc] init];
    });
    return networkManager;
}
#pragma mark ----- 用户登录相关
//用户登录
- (void)userLogin:(NSString *)name password:(NSString *)password success:(Success)success failure:(Failure)failure{
    NSString *baseUrl = [YXHttp stringByAppendingString:YXLogin];
    //自定义部分
    NSMutableDictionary *info_custom = [NSMutableDictionary dictionaryWithObjectsAndKeys:password,@"password",name,@"screen_name", nil];
    //oath通用规则
    NSMutableDictionary *info = [self dicFromOauth];
    //拼接格式
    [info addEntriesFromDictionary:info_custom];
    //生成签名
    [self hmac_sha1_signature:@"POST" url:baseUrl param:info token_secret:nil];
    
    //生成oath报文头部
    NSString *oauthHeader = [self oathHeaderFromInfo:info];
    
    NSString *string_login = [YXHttp stringByAppendingString:YXLogin];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:string_login]];
    [theRequest setHTTPMethod:@"POST"];
    
    //接入自定义部分
    NSString *string_post = [self createPostURL:info_custom];
    [theRequest setHTTPBody:[string_post dataUsingEncoding:NSUTF8StringEncoding]];
    [theRequest setValue:oauthHeader forHTTPHeaderField:@"Authorization"];
    AFHTTPRequestOperation *operation= [[AFHTTPRequestOperationManager manager]HTTPRequestOperationWithRequest:theRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error,operation.responseObject);
    }];
    [[AFHTTPRequestOperationManager manager].operationQueue addOperation:operation];
}
//获取验证码
- (void)getVerifyCode:(NSString *)phoneNum success:(Success)success failure:(Failure)failure{
    NSString *string_url = [YXHttp stringByAppendingString:YXGetMessage];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:string_url]];
    [theRequest setHTTPMethod:@"POST"];
    NSString *string_post = [self createPostURL:@{@"phone":phoneNum}];
    [theRequest setHTTPBody:[string_post dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *operation= [[AFHTTPRequestOperationManager manager]HTTPRequestOperationWithRequest:theRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error,operation.responseObject);
    }];
    [[AFHTTPRequestOperationManager manager].operationQueue addOperation:operation];
}
//注册
- (void)registWith:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure{
    NSString *baseUrl = [YXHttp stringByAppendingString:YXRegist];
    NSString *nonce = [self generateNonce];
    NSString *timestamp = [self generateTimestamp];
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 APP_KEY,@"oauth_consumer_key",
                                 APP_SIGNATURE_METHOD,@"oauth_signature_method",
                                 timestamp,@"oauth_timestamp",
                                 nonce,@"oauth_nonce",
                                 APP_VERSION,@"oauth_version",
                                 APP_CALLBACK,@"oauth_callback",
                                 nil];
    
    [info addEntriesFromDictionary:parameters];
    [self hmac_sha1_signature:@"POST" url:baseUrl param:info token_secret:nil];
    NSString *oauthHeader = [NSString stringWithFormat:@"OAuth realm=%@,oauth_consumer_key=%@,oauth_signature_method=%@,oauth_timestamp=%@,oauth_nonce=%@,oauth_version=%@,oauth_signature=%@,oauth_callback=%@",@"",[info valueForKey:@"oauth_consumer_key"] ,[info valueForKey:@"oauth_signature_method"],[info valueForKey:@"oauth_timestamp"],[info valueForKey:@"oauth_nonce"],[info valueForKey:@"oauth_version"],[info valueForKey:@"oauth_signature"],[info valueForKey:@"oauth_callback"]];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseUrl]];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:oauthHeader forHTTPHeaderField:@"Authorization"];
    
    NSString *string_post = [self createPostURL:parameters];
    [theRequest setHTTPBody:[string_post dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation= [[AFHTTPRequestOperationManager manager]HTTPRequestOperationWithRequest:theRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error,operation.responseObject);
    }];
    [[AFHTTPRequestOperationManager manager].operationQueue addOperation:operation];
}

//找回密码
- (void)findPassword:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure{
    NSString *postUrl=[YXHttp stringByAppendingString:YXResetPassword];
    [self noLoginWithRequest:POST baseurl:postUrl paremeter:parameters success:^(id JSON) {
        success(JSON);
    } failure:^(NSError *error, id JSON) {
        failure(error, JSON);
    }];

}
#pragma mark --- 用户信息相关
//获取用户信息
- (void)getUserInfomation:(NSString *)userID success:(Success)success failure:(Failure)failure{
    NSString *string_url = [YXHttp stringByAppendingString:YXUserShow];
    [self loginWithRequest:GET baseurl:string_url paremeter:@{@"user_id" : userID} success:^(id JSON) {
        success(JSON);
    } failure:^(NSError *error, id JSON) {
        failure(error, JSON);
    }];
}
//上传头像
- (void)uploadImagePath:(NSString *)path success:(Success)success failure:(Failure)failure{
    NSString *string_url = [YXHttp stringByAppendingString:YXUploadPic];
    [self loginWithRequest:GET baseurl:string_url paremeter:@{@"pic" : path} success:^(id JSON) {
        NSString *pic_id = JSON[@"pic_id"];
        NSString *put_url = JSON[@"put_url"];
        [self noLoginWithRequest:PUT baseurl:put_url paremeter:@{@"imagePath":path} success:^(id JSON) {
            NSString *comfireUrl = [YXHttp stringByAppendingString:YXUploadPicConfirm];
            [self loginWithRequest:POST baseurl:comfireUrl paremeter:@{@"pic_id":pic_id} success:^(id JSON) {
                success(JSON);
            } failure:^(NSError *error, id JSON) {
                YXLog(@"上传第三步错误%@", JSON);
                failure(error, JSON);
            }];
        } failure:^(NSError *error, id JSON) {
            YXLog(@"上传第二步错误%@", JSON);
            failure(error, JSON);
        }];
    } failure:^(NSError *error, id JSON) {
        YXLog(@"上传第一步错误%@", JSON);
        failure(error, JSON);
    }];

}
- (void)checkVersionSuccess:(Success)success failure:(Failure)failure{
    NSString *string_url = [YXHttp stringByAppendingString:YXCheckUpdate];
    NSString *appCurVersion = [NSString stringWithFormat:@"%@.%@",[UIUtils Version],[UIUtils buildVersion]];
    [self noLoginWithRequest:GET baseurl:string_url paremeter:@{@"app_key" : APP_KEY, @"version" : appCurVersion} success:^(id JSON) {
        NSString *hasVersion = [NSString stringWithFormat:@"%@",JSON[@"has_new_version"]];
        if ([hasVersion isEqualToString:@"1"]) {
            success(JSON);
        }else{
            failure(nil, nil);
        }
    } failure:^(NSError *error, id JSON) {
        failure(error, JSON);
    }];
}
//修改用户信息
- (void)updataUserInfo:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure{
    NSString *string_url = [YXHttp stringByAppendingString:YXUserUpdate];
    [self loginWithRequest:POST baseurl:string_url paremeter:parameters success:^(id JSON) {
        success(JSON);
    } failure:^(NSError *error, id JSON) {
        failure(error, JSON);
    }];
    
}
#pragma mark --- 订单相关
//商品列表
- (void)getProductListSuccess:(Success)success failure:(Failure)failure{
    NSString *string_url = [YXHttp stringByAppendingString:YXProductList];
    [self noLoginWithRequest:GET baseurl:string_url paremeter:nil success:^(id JSON) {
        YXLog(@"%@", JSON);
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[JSON count]];
        for (NSDictionary *attributes in JSON) {
            Model_product *product = [Model_product productWithDictionary:attributes];
            [mutablePosts addObject:product];
        }
        success(mutablePosts);
    } failure:^(NSError *error, id JSON) {
        failure(error, JSON);
    }];
}
//商品详情
- (void)getProductDetailWithID:(NSString *)productID success:(Success)success failure:(Failure)failure{
    NSString *string_url = [YXHttp stringByAppendingString:YXProductDetail];
    [self noLoginWithRequest:GET baseurl:string_url paremeter:@{@"product_id":productID} success:^(id JSON) {
        YXLog(@"%@", JSON);
        success(JSON);
    } failure:^(NSError *error, id JSON) {
        failure(error, JSON);
    }];

    
}
//创建订单
- (void)createOrderWithProduct:(NSString *)productID count:(NSString *)count success:(Success)success failure:(Failure)failure{
    NSString *string_url = [YXHttp stringByAppendingString:YXOrderCreate];
    NSDictionary *dic = @{@"product_id":productID,@"num":[NSString stringWithFormat:@"%@", count]};
    [self loginWithRequest:POST baseurl:string_url paremeter:dic success:^(id JSON) {
        YXLog(@"%@", JSON);
        success(JSON);
    } failure:^(NSError *error, id JSON) {
        failure(error, JSON);
    }];
}
//订单管理
- (void)getTradeList:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure{
    NSString *string_url = [YXHttp stringByAppendingString:YXTradeList];
    [self loginWithRequest:GET baseurl:string_url paremeter:parameters success:^(id JSON) {
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[JSON count]];
        for (NSDictionary *attributes in JSON) {
            Model_order *order = [Model_order orderWithDictionary:attributes];
            [mutablePosts addObject:order];
        }
        success(mutablePosts);
    } failure:^(NSError *error, id JSON) {
        failure(error, JSON);
    }];
}
//订单详情
- (void)getOrderDetailWithID:(NSString *)orderID success:(Success)success failure:(Failure)failure{
    NSString *string_url = [YXHttp stringByAppendingString:YXOrderDetail];
    [self loginWithRequest:GET baseurl:string_url paremeter:@{@"order_id":orderID} success:^(id JSON) {
        YXLog(@"%@", JSON);
        success(JSON);
    } failure:^(NSError *error, id JSON) {
        failure(error, JSON);
    }];

}
//支付
- (void)payWithOrder:(NSString *)order channel:(NSString *)channel success:(Success)success failure:(Failure)failure{
    NSString *string_url = [YXHttp stringByAppendingString:YXPayURL];
    NSDictionary *dic = @{@"order_id":[NSString stringWithFormat:@"%@", order],@"channel":channel};
    [self loginWithRequest:POST baseurl:string_url paremeter:dic success:^(id JSON) {
        success(JSON);
    } failure:^(NSError *error, id JSON) {
        failure(error, JSON);
    }];
}
// ---------------------------------------------------------------------------------//
#pragma mark 统一请求接口 需要登录
- (void)loginWithRequest:(RequestMethod)method baseurl:(NSString *)url paremeter:(NSDictionary*)parameters success:(Success)success failure:(Failure)failure{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:YXToken];
    if (token == nil) {
        YXLog(@"token = nil");
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"还未登录,是否现在登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert show];
      //  return;
    }
    NSMutableDictionary *info_custom = [NSMutableDictionary dictionaryWithObjectsAndKeys:token,@"oauth_token",nil];
    [info_custom addEntriesFromDictionary:parameters];
    //oath通用规则
    NSMutableDictionary *info = [self dicFromOauth];
    //拼接格式
    [info addEntriesFromDictionary:info_custom];
    //   YXLog(@"%@", info);
    //生成签名(注意 传入token_secret)
    NSString *requestMthodString=nil;
    if (method==GET) {
        requestMthodString=@"GET";
    }else if (method==POST){
        requestMthodString=@"POST";
    }
    NSString *tokenSecret = [[NSUserDefaults standardUserDefaults] objectForKey:YXTokenSecret];
    [self hmac_sha1_signature:requestMthodString url:url param:info token_secret:tokenSecret];
    //生成oath报文头部(带有token的)
    NSString *oauthHeader = [self oathHeaderFromInfoWithToken:info];
    //  YXLog(@"oauthHeader = %@", oauthHeader);
    
    NSMutableURLRequest *theRequest=nil;
    
    if (method==GET) {
        if (parameters.count>0) {
            url=[url stringByAppendingString:[NSString stringWithFormat:@"?%@",[self createPostURL:parameters]]];
            //YXLog(@"%@", url);
        }
        //  theRequest.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
        //  theRequest.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
        theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [theRequest setHTTPMethod:@"GET"];
    }else if(method==POST){
        theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [theRequest setHTTPMethod:@"POST"];
        if (parameters.count>0) {
            NSString *string_post = [self createPostURL:parameters];
            //  YXLog(@"string_post = %@",  string_post);
            NSData *post_data = [string_post dataUsingEncoding:NSUTF8StringEncoding];
            [theRequest setHTTPBody:post_data];
            
        }
    }
    theRequest.timeoutInterval = 30.f;
    
    // theRequest.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    [theRequest setValue:oauthHeader forHTTPHeaderField:@"Authorization"];
    
    AFHTTPRequestOperation *operation= [[AFHTTPRequestOperationManager manager] HTTPRequestOperationWithRequest:theRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  failure(error,operation.responseObject);
        failure(error, operation.response);
        // YXLog(@"error是%@",error);
        ////  YXLog(@"状态码是%ld",(long)operation.responseObject);
        YXLog(@"operation.response = %@ ", operation);
        YXLog(@"状态码是%ld",(long)operation.response.statusCode);
        if (operation.response.statusCode==401) {
           // [[NSNotificationCenter defaultCenter] postNotificationName:YXLoggingTokenOutdatedError object:nil];
        }
    }];
    [[AFHTTPRequestOperationManager manager].operationQueue addOperation:operation];

}
- (void)noLoginWithRequest:(RequestMethod)method baseurl:(NSString *)url paremeter:(NSDictionary*)parameters success:(Success)success failure:(Failure)failure{
    NSMutableURLRequest *theRequest=nil;
    if (method==GET) {
        if (parameters.count>0) {
            url=[url stringByAppendingString:[NSString stringWithFormat:@"?%@",[self createPostURL:parameters]]];
        }
        theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [theRequest setHTTPMethod:@"GET"];
    } else if(method==POST){
        theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [theRequest setHTTPMethod:@"POST"];
        if (parameters.count>0) {
            NSString *string_post = [self createPostURL:parameters];
            [theRequest setHTTPBody:[string_post dataUsingEncoding:NSUTF8StringEncoding]];
        }
    } else if(method==PUT){
        theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [theRequest setHTTPMethod:@"PUT"];
        [theRequest setValue:@"" forHTTPHeaderField:@"Content-Type"];
        
        if (parameters.count>0) {
            NSInputStream *stream = [NSInputStream inputStreamWithFileAtPath:[parameters objectForKey:@"imagePath"]];
            [theRequest setHTTPBodyStream:stream];
            
        }
    }
    // theRequest.timeoutInterval = 10;
    //  theRequest.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    //  manager.requestSerializer.timeoutInterval = 10.f;
    AFHTTPRequestOperation *operation= [[AFHTTPRequestOperationManager manager]HTTPRequestOperationWithRequest:theRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error,operation.responseObject);
    }];
    [[AFHTTPRequestOperationManager manager].operationQueue addOperation:operation];

    
}

- (NSString *)createPostURL:(NSDictionary *)params{
    NSString *postString=@"";
    for(NSString *key in [params allKeys]){
        NSString *value=[params objectForKey:key];
        postString=[postString stringByAppendingFormat:@"%@=%@&",key,value];
    }
    if([postString length]>1){
        postString=[postString substringToIndex:[postString length]-1];
    }
    return postString;
}

#pragma mark - oath认证通用部分 -
/**
 *  oauth认证通用部分
 */
- (NSMutableDictionary *)dicFromOauth{
    NSString *nonce = [self generateNonce];
    NSString *timestamp = [self generateTimestamp];
    NSMutableDictionary* info = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 APP_KEY,@"oauth_consumer_key",
                                 APP_SIGNATURE_METHOD,@"oauth_signature_method",
                                 timestamp,@"oauth_timestamp",
                                 nonce,@"oauth_nonce",
                                 APP_VERSION,@"oauth_version",
                                 APP_CALLBACK,@"oauth_callback",nil];
    return info;
}

- (NSString *)oathHeaderFromInfo:(NSDictionary *)info{
    NSString *oauthHeader = [NSString stringWithFormat:@"OAuth realm=%@,oauth_consumer_key=%@,oauth_signature_method=%@,oauth_signature=%@,oauth_timestamp=%@,oauth_nonce=%@,oauth_version=%@,oauth_callback=%@",@"",[info valueForKey:@"oauth_consumer_key"],[info valueForKey:@"oauth_signature_method"],[info valueForKey:@"oauth_signature"],[info valueForKey:@"oauth_timestamp"],[info valueForKey:@"oauth_nonce"],[info valueForKey:@"oauth_version"],[info valueForKey:@"oauth_callback"]];
    return oauthHeader;
}
#pragma mark - 获得时间戳 -
/**
 *  获得时间戳
 */
- (NSString *)generateTimestamp{
    return [NSString stringWithFormat:@"%ld",time(NULL)];
}

#pragma mark - 获得随时字符串 -
/**
 *  获得随时字符串
 */
- (NSString *)generateNonce{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    NSString *s2ndUuid = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, theUUID);
    return s2ndUuid;
}

#pragma mark - 带token的oath头部 -
/**
 *  带token的oath头部
 */
- (NSString *)oathHeaderFromInfoWithToken:(NSDictionary *)info{
    NSString *oauthHeader = [NSString stringWithFormat:@"OAuth realm=%@,oauth_consumer_key=%@,oauth_signature_method=%@,oauth_signature=%@,oauth_timestamp=%@,oauth_nonce=%@,oauth_version=%@,oauth_callback=%@,oauth_token=%@",
                             @"",
                             [info valueForKey:@"oauth_consumer_key"],
                             [info valueForKey:@"oauth_signature_method"],
                             [info valueForKey:@"oauth_signature"],
                             [info valueForKey:@"oauth_timestamp"],
                             [info valueForKey:@"oauth_nonce"],
                             [info valueForKey:@"oauth_version"],
                             [info valueForKey:@"oauth_callback"],
                             [info valueForKey:@"oauth_token"]];
    return oauthHeader;
}
- (NSString *)authBase64:(NSString *)authStr{
    
    //将字符串转换成二进制数局
    NSData *data = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

#pragma mark - 生成签名证书 -
/**
 *  生成签名证书
 */
- (void)hmac_sha1_signature:(NSString*)method url:(NSString*)baseUrl param:(NSDictionary*) param token_secret:(NSString*)token_secret{
    
    NSArray *sortedkeys = [[param allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSMutableString *mutUrlParam = [NSMutableString stringWithString:@""];
    // NSMutableString *mutUrlParam = [[NSMutableString alloc] init];
    
    unsigned i, c = (unsigned)[sortedkeys count];
    for (i=0; i<c; i++) {
        NSString *k=[sortedkeys objectAtIndex:i];
        NSString *v=[param objectForKey:k];
        if(i>0){
            [mutUrlParam appendString:@"&"];
        }
        [mutUrlParam appendString:k];
        [mutUrlParam appendString:@"="];
        [mutUrlParam appendString:[self ab_RFC3986EncodedString:v]];// URI 编码
    }
    
    NSString *urlEncodeBaseUrl = [self ab_RFC3986EncodedString:baseUrl]; // URI 编码
    NSString *urlParam = (NSString*)mutUrlParam;
    urlParam = [self ab_RFC3986EncodedString:urlParam]; // URI 编码
    NSString *sbs = [NSString stringWithFormat:@"%@&%@&%@", method, urlEncodeBaseUrl, urlParam];
    //  YXLog(@"sbs == %@", sbs);
    NSString *key;
    if(token_secret){
        key = [NSString stringWithFormat:@"%@&%@",APP_SECRET,token_secret];
    } else {
        key = [NSString stringWithFormat:@"%@&",APP_SECRET];
    }
    NSString *oauth_signature = [self hmac_sha1:key text:sbs];
    //   YXLog(@"oauth_signature = %@", oauth_signature);
    [param setValue:oauth_signature forKey:@"oauth_signature"];
    
    NSMutableString *urlParams = [NSMutableString stringWithString:@""];
    NSArray *keys=[param allKeys];
    c=(unsigned)[keys count];
    for (i=0; i<c; i++) {
        NSString *k=[keys objectAtIndex:i];
        NSString *v=[param objectForKey:k];
        //  YXLog(@"v = %@", v);
        NSString *paramStr = [NSString stringWithFormat:@"&%@=%@",k,[self ab_RFC3986EncodedString:v]];
        [urlParams appendString:paramStr];
    }
    [urlParams replaceCharactersInRange:NSMakeRange(0,1) withString:@""];
    //   YXLog(@"signature = %@", urlParams);
    
}

- (NSString *)hmac_sha1:(NSString *)key text:(NSString *)text{
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSData *data_tmp  = [GTMBase64 encodeData:HMAC];
    NSString *base64String = [[NSString alloc] initWithData:data_tmp encoding:NSUTF8StringEncoding];
    return base64String;
}

- (NSString *)ab_RFC3986EncodedString:(NSString *)v{
    NSMutableString *result = [NSMutableString string];
    v = [NSString stringWithFormat:@"%@", v];
    const char *p = [v UTF8String];
    // YXLog(@"p = %s", p);
    unsigned char c;
    for(; (c = *p); p++){
        //  YXLog(@"c = %c", c);
        switch(c)
        {
            case '0' ... '9':
            case 'A' ... 'Z':
            case 'a' ... 'z':
            case '.':
            case '-':
            case '~':
            case '_':
                [result appendFormat:@"%c", c];
                //  YXLog(@"result1 = %@", result);
                break;
            default:
                
                if ([[NSString stringWithFormat:@"%%%X", c] isEqualToString:@"%A"]) {
                    [result appendFormat:@"%%0A"];
                }else{
                    [result appendFormat:@"%%%X", c];
                }
                //  [result appendFormat:@"%%%X", c];
                //  YXLog(@"result2 = %@", result);
        }
    }
    //    if ([result rangeOfString:@"%A%"].length>0) {
    //        result = [result stringByReplacingOccurrencesOfString:@"square" withString:@"large"];
    //    }
    
    return result;
}

@end
