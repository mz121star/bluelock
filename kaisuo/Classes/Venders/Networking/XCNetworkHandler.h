//
//  XCNetworkHandler.h
//
//  Created by XenonChau on 26/07/2017.
//  Copyright © 2017 EasyCoding Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLBaseModel.h"
#import <MJExtension/MJExtension.h>
#import "XCNetworkHelper.h"

@interface XCNetworkHandler : NSObject

///////////////////////////POST请求/////////////////////////////////////

#pragma mark - POST请求

/**
 @param api 请求地址，不能为空。无参数。
 */
+ (void)xc_post:(NSString *_Nonnull)api
        success:(void(^_Nullable)(id _Nullable success))successCallback
        failure:(void(^_Nullable)(id _Nullable failure))failureCallback
          error:(void(^_Nullable)(NSError * _Nullable error))errorCallback;

/**
 @param api 请求地址，不能为空。
 @param token 布尔型：是否要加token。
 */
+ (void)xc_post:(NSString *_Nonnull)api
          token:(BOOL)token
        success:(void(^_Nullable)(id _Nullable success))successCallback
        failure:(void(^_Nullable)(id _Nullable failure))failureCallback
          error:(void(^_Nullable)(NSError * _Nullable error))errorCallback;

/**
 @param api 请求地址，不能为空。
 @param params 请求参数。
 @param token 布尔型：是否要加token。
 */
+ (void)xc_post:(NSString *_Nonnull)api
        paramas:(id _Nullable)params
      withToken:(BOOL)token
        success:(void(^_Nullable)(id _Nullable success))successCallback
        failure:(void(^_Nullable)(id _Nullable failure))failureCallback
          error:(void(^_Nullable)(NSError * _Nullable error))errorCallback;

/**
 @param api 请求地址，不能为空。
 @param params 请求参数。
 */
+ (void)xc_post:(NSString *_Nonnull)api
        paramas:(id _Nullable)params
        success:(void(^_Nullable)(id _Nullable success))successCallback
        failure:(void(^_Nullable)(id _Nullable failure))failureCallback
          error:(void(^_Nullable)(NSError * _Nullable error))errorCallback;

/**
 @param api 请求地址，不能为空。
 @param params 请求参数。
 @param token 布尔型：是否要加token。
 @param signature 布尔型：是否要使用加密规则制造签名。
 */
+ (void)xc_post:(NSString *_Nonnull)api
        paramas:(id _Nullable)params
      withToken:(BOOL)token
   andSignature:(BOOL)signature
        success:(void(^_Nullable)(id _Nullable success))successCallback
        failure:(void(^_Nullable)(id _Nullable failure))failureCallback
          error:(void(^_Nullable)(NSError * _Nullable error))errorCallback;

///////////////////////////GET请求/////////////////////////////////////

#pragma mark - GET请求

/**
 @param api 请求地址，不能为空。无参数。
 */
+ (void)xc_get:(NSString *_Nonnull)api
       success:(void(^_Nullable)(id _Nullable success))successCallback
       failure:(void(^_Nullable)(id _Nullable failure))failureCallback
         error:(void(^_Nullable)(NSError * _Nullable error))errorCallback;

/**
 @param api 请求地址，不能为空。
 @param params 请求参数。
 */
+ (void)xc_get:(NSString *_Nonnull)api
       paramas:(id _Nullable)params
       success:(void(^_Nullable)(id _Nullable success))successCallback
       failure:(void(^_Nullable)(id _Nullable failure))failureCallback
         error:(void(^_Nullable)(NSError * _Nullable error))errorCallback;

/**
 @param api 请求地址，不能为空。
 @param token 布尔型：是否要加token。
 */
+ (void)xc_get:(NSString *_Nonnull)api
         token:(BOOL)token
       success:(void(^_Nullable)(id _Nullable success))successCallback
       failure:(void(^_Nullable)(id _Nullable failure))failureCallback
         error:(void(^_Nullable)(NSError * _Nullable error))errorCallback;

/**
 @param api 请求地址，不能为空。
 @param params 请求参数。
 @param token 布尔型：是否要加token。
 */
+ (void)xc_get:(NSString *_Nonnull)api
       paramas:(id _Nullable)params
     withToken:(BOOL)token
       success:(void(^_Nullable)(id _Nullable success))successCallback
       failure:(void(^_Nullable)(id _Nullable failure))failureCallback
         error:(void(^_Nullable)(NSError * _Nullable error))errorCallback;

/**
 @param api 请求地址，不能为空。
 @param params 请求参数。
 @param token 布尔型：是否要加token。
 @param signature 布尔型：是否要使用加密规则制造签名。
 */
+ (void)xc_get:(NSString *_Nonnull)api
       paramas:(id _Nullable)params
     withToken:(BOOL)token
  andSignature:(BOOL)signature
       success:(void(^_Nullable)(id _Nullable success))successCallback
       failure:(void(^_Nullable)(id _Nullable failure))failureCallback
         error:(void(^_Nullable)(NSError * _Nullable error))errorCallback;


@end
