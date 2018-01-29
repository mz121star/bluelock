//
//  XCNetworkHelper.h
//
//  Created by XenonChau on 26/07/2017.
//  Copyright © 2017 EasyCoding Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RequestAPI) {
    
    ReqSignIn = 0,        // 登录           POST
    ReqSignOut,       // 登出           POST
    ReqCaptcha,       // 验证码         POST
    ReqTotalAssets,   // 用户资产（钱包） POST
    ReqTransactions,  // 查看明细       GET为明细，POST为转账
    ReqPromotions,    // 我的邀请       GET
    ReqAddress,       // 获取地址       POST
    
};

static NSString * _Nullable RequestURL[] = {
    [ReqSignIn] = @"/api/app/getUserInfo",/*登录*/
//    [ReqSignOut] = @"/api/user/logout/",/*注销*/\
//    [ReqCaptcha] = @"/api/verify/code/",/*请求验证码*/\
//    [ReqTotalAssets] = @"/api/user/wallet/",/*个人资产*/\
//    [ReqTransactions] = @"/api/user/transactions/",/*账单(明细)*/\
//    [ReqPromotions] = @"/api/user/invite/",/*我的邀请*/\
//    [ReqAddress] = @"/api/user/address/", /*获取地址*/\
    
};

#if DEBUG
static NSString * _Nullable baseURLString = @"http://door-dev.vjingwu.com"; // 测试环境
#else
static NSString * _Nullable baseURLString = @"http://door.vjingwu.com"; // 测试环境
#endif

// 私钥
static NSString *privateKey = @"6b0d745935494807a1113138bdb434d8";

@interface XCNetworkHelper : NSObject

+ (NSDictionary *_Nonnull)addSignature:(NSDictionary *_Nonnull)originParams;

@end
