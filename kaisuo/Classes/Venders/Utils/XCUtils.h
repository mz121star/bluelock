//
//  XCUtils.h
//
//  Created by XenonChau on 25/07/2017.
//  Copyright © 2017 EasyCoding Co.,Ltd. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XCUtils : NSObject

+ (__kindof UIViewController *)applicationRootViewController;

@end

@interface UserInfo : NSObject
/*!
 @remarks 不要跟我讲什么“Archive”了、什么“FMDB”！拿 “NSUserDefaults” 就是干！
 */
#pragma mark - 用户 Token
+ (void)userToken:(NSString *)token;
+ (NSString *)userToken;
#pragma mark - 用户名
+ (void)username:(NSString *)username;
+ (NSString *)username;
#pragma mark - 用户id
+ (void)uID:(NSString *)userID;
+ (NSString *)uID;
#pragma mark - 用户邀请码
+ (void)inviteCode:(NSString *)inviteCode;
+ (NSString *)inviteCode;
#pragma mark - Addresses
+ (void)addressBTC:(NSString *)btc_address;
+ (NSString *)addressBTC;
+ (void)addressCOC:(NSString *)coc_address;
+ (NSString *)addressCOC;
+ (void)addressETC:(NSString *)etc_address;
+ (NSString *)addressETC;
+ (void)addressETH:(NSString *)eth_address;
+ (NSString *)addressETH;
+ (void)addressZEC:(NSString *)zec_address;
+ (NSString *)addressZEC;

@end

@interface NSString (MD5)

- (NSString *)MD5Digest;

@end

static NSString *notificationLoadDeposit = @"notificationLoadDeposit";
static NSString *notificationLoadWithdraw = @"notificationLoadWithdraw";

@interface XCGlobal : NSObject

+ (instancetype)global;
+ (UIWindow *)keyWindow;

@end

