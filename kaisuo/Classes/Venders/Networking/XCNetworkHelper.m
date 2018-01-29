//
//  XCNetworkHelper.m
//
//  Created by XenonChau on 26/07/2017.
//  Copyright © 2017 EasyCoding Co.,Ltd. All rights reserved.
//

#import "XCNetworkHelper.h"
#import "XCUtils.h"

@implementation XCNetworkHelper

+ (NSDictionary *)addSignature:(NSArray *)originParams {
    NSMutableDictionary *newDict = [@{} mutableCopy];
    
    
    /**
      原业务逻辑是将字典按字母表排序，然后再加签名。
    NSArray *sortedKeys = [originParams.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
     */
    
    
    NSString *dictString = @"";
    for (int i = 0; i < originParams.count; i++) {
        NSDictionary *item = originParams[i];
        NSString *key = item.allKeys[0];//业务逻辑：每个字典只允许有一个元素。
        NSString *value = item.allValues[0];
        newDict[key] = value;
        NSString *key_value = @"";
        if (i) {
            key_value = [NSString stringWithFormat:@"&%@=%@", key, value];
        } else {
            key_value = [NSString stringWithFormat:@"%@=%@", key, value];
        }

        dictString = [dictString stringByAppendingString:key_value];
    }
//
    NSString *md5_encrypt = [dictString MD5Digest];
    
    newDict[@"sign"] = md5_encrypt;
    
    return [newDict copy];
}

@end
