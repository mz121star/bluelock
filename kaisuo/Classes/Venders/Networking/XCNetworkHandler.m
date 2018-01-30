//
//  XCNetworkHandler.m
//
//  Created by XenonChau on 26/07/2017.
//  Copyright © 2017 EasyCoding Co.,Ltd. All rights reserved.
//

#import "XCNetworkHandler.h"
#import "AFNetworking.h"

#import "BLAppDelegate.h"

static AFHTTPSessionManager *kSessionManager = nil;

@interface XCNetworkHandler ()

@end

@implementation XCNetworkHandler

#pragma mark - POST
+ (void)xc_post:(NSString *)api
        paramas:(id)params
      withToken:(BOOL)token
   andSignature:(BOOL)signature
        success:(void(^)(id success))successCallback
        failure:(void(^)(id failure))failureCallback
          error:(void(^)(NSError *error))errorCallback {
    
    if (!kSessionManager) {
        kSessionManager = [[AFHTTPSessionManager alloc]
                           initWithBaseURL:[NSURL URLWithString:baseURLString]];
    }
    //kSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    kSessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    kSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    kSessionManager.requestSerializer.timeoutInterval = 30;
    kSessionManager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    //[kSessionManager.requestSerializer setValue:@"text" forHTTPHeaderField:@"Content-Type"];
    if (token) {
//#if DEBUG
//        // 测试环境给出断言检查 token 。
//        NSAssert([UserInfo userToken], @"Token为空，请检查代码逻辑！");
//#else
        // 生产环境强制用户重新登录。
//        if (![UserInfo userToken]) {
//            [self invalidUserInfoAlert];
//            return;
//        }
//#endif
        
        //[kSessionManager.requestSerializer setValue:[UserInfo userToken] forHTTPHeaderField:@"token"];
    }
    if (signature) {
        // 开锁业务：如果是带签名的，传入的是[{str:str}]结构，增加sign后返回{str:str}结构。
        params = [XCNetworkHelper addSignature:params];
    }
    
    [kSessionManager
     POST:api
     parameters:params
     progress:^(NSProgress * _Nonnull uploadProgress) {
         NSLog(@"%@", uploadProgress);
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         if ([responseObject[@"status"] integerValue] == 1) {
             !successCallback ? : successCallback(responseObject);
         } else {
             !failureCallback ? : failureCallback(responseObject);
         }
         

     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         NSLog(@"500之后给出的信息：%@", error.localizedDescription);
         // 回调给controller
         !errorCallback ? : errorCallback(error);
     }];
    
    
}

#pragma mark - GET
+ (void)xc_get:(NSString *)api
       paramas:(id)params
     withToken:(BOOL)token
  andSignature:(BOOL)signature
       success:(void(^)(id success))successCallback
       failure:(void(^)(id failure))failureCallback
         error:(void(^)(NSError *error))errorCallback {
    
    if (!kSessionManager) {
        kSessionManager = [[AFHTTPSessionManager alloc]
                           initWithBaseURL:[NSURL URLWithString:baseURLString]];
    }
    //kSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    kSessionManager.requestSerializer.timeoutInterval = 30;
    kSessionManager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    //[kSessionManager.requestSerializer setValue:@"text" forHTTPHeaderField:@"Content-Type"];
    if (token) {
//#if DEBUG
//        // 测试环境给出断言检查 token 。
//        NSAssert([UserInfo userToken], @"Token为空，请检查代码逻辑！");
//#else
          // 生产环境强制用户重新登录。
//        if (![UserInfo userToken]) {
//            [self invalidUserInfoAlert];
//            return;
//        }
//#endif
        
        //[kSessionManager.requestSerializer setValue:[UserInfo userToken] forHTTPHeaderField:@"token"];
    }
    if (signature) {
        params = [XCNetworkHelper addSignature:params];
    }
    
    [kSessionManager
     GET:api
     parameters:params
     progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         //RDBaseModel *model = [RDBaseModel mj_objectWithKeyValues:responseObject];
         // 回调给controller
         
//         if (!model.code.integerValue) { // code == 0 成功
//             if (model.token) {
//                 [UserInfo userToken:model.token];
//             }
//             NSLog(@"成功给的数据====%@", model.data);
//             !successCallback ? : successCallback(model.data);
//         } else {
//             NSLog(@"服务器返回的错误信息：%@", model.msg);
//             if ([model.msg isEqualToString:@"token已过期"] || [model.msg isEqualToString:@"token不存在"]) {
//                 [self invalidUserInfoAlert];
//             }
//             !failureCallback ? : failureCallback(model.msg);
//         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         NSLog(@"500之后给出的信息：%@", error.localizedDescription);
         // 回调给controller
         !errorCallback ? : errorCallback(error);
     }];
    
    
}


#pragma mark - 短参数方法
+ (void)xc_post:(NSString *_Nonnull)api
          token:(BOOL)token
        success:(void(^_Nullable)(id _Nullable success))successCallback
        failure:(void(^_Nullable)(id _Nullable failure))failureCallback
          error:(void(^_Nullable)(NSError * _Nullable error))errorCallback {
    [self xc_post:api paramas:nil withToken:token andSignature:NO success:successCallback failure:failureCallback error:errorCallback];
}

+ (void)xc_post:(NSString *_Nonnull)api
        paramas:(id _Nullable)params
      withToken:(BOOL)token
        success:(void(^_Nullable)(id _Nullable success))successCallback
        failure:(void(^_Nullable)(id _Nullable failure))failureCallback
          error:(void(^_Nullable)(NSError * _Nullable error))errorCallback {
    [self xc_post:api paramas:params withToken:token andSignature:NO success:successCallback failure:failureCallback error:errorCallback];
}

+ (void)xc_post:(NSString *)api
        paramas:(id)params
        success:(void(^)(id success))success
        failure:(void(^)(id failure))failure
          error:(void(^)(NSError *error))error {
    [self xc_post:api paramas:params withToken:NO andSignature:NO success:success failure:false error:error];
}

+ (void)xc_post:(NSString *)api
        success:(void(^)(id success))success
        failure:(void(^)(id failure))failure
          error:(void(^)(NSError *error))error {
    [self xc_post:api paramas:nil withToken:NO andSignature:NO success:success failure:false error:error];
}


+ (void)xc_get:(NSString *_Nonnull)api
         token:(BOOL)token
       success:(void(^_Nullable)(id _Nullable success))successCallback
       failure:(void(^_Nullable)(id _Nullable failure))failureCallback
         error:(void(^_Nullable)(NSError * _Nullable error))errorCallback {
    [self xc_get:api paramas:nil withToken:token andSignature:NO success:successCallback failure:failureCallback error:errorCallback];
}

+ (void)xc_get:(NSString *_Nonnull)api
       paramas:(id _Nullable)params
     withToken:(BOOL)token
       success:(void(^_Nullable)(id _Nullable success))successCallback
       failure:(void(^_Nullable)(id _Nullable failure))failureCallback
         error:(void(^_Nullable)(NSError * _Nullable error))errorCallback {
    [self xc_get:api paramas:params withToken:token andSignature:NO success:successCallback failure:failureCallback error:errorCallback];
}

+ (void)xc_get:(NSString *)api
       paramas:(id)params
       success:(void(^)(id success))successCallback
       failure:(void(^)(id failure))failureCallback
         error:(void(^)(NSError *error))errorCallback {
    [self xc_get:api paramas:params withToken:NO andSignature:NO success:successCallback failure:failureCallback error:errorCallback];
}

+ (void)xc_get:(NSString *)api
       success:(void(^)(id success))success
       failure:(void(^)(id failure))failure
         error:(void(^)(NSError *error))error {
    [self xc_get:api paramas:nil withToken:NO andSignature:NO success:success failure:false error:error];
}

#pragma mark - 生产环境因用户信息不全导致闪退的解决方案
+ (void)invalidUserInfoAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"登录状态异常，\n请重新登录。" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //[(BLAppDelegate *)[UIApplication sharedApplication].delegate loginViewController];
    }];
    [alert addAction:ok];
    [[[UIApplication sharedApplication] windows] enumerateObjectsUsingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isKeyWindow) {
            [obj.rootViewController presentViewController:alert animated:YES completion:nil];
            return;
        }
    }];
}

@end
