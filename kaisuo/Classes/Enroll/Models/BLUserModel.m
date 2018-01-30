//
//  BLUserModel.m
//  kaisuo
//
//  Created by XenonChau on 30/01/2018.
//  Copyright © 2018 苗壮. All rights reserved.
//

#import "BLUserModel.h"


@implementation BLDeviceModel

@end


@implementation BLResidentialModel

@end


@implementation BLUserModel

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary
{
    self = [super init];
    if (self) {
        [self parseDictionary:otherDictionary];
    }
    return self;
}


- (void)parseDictionary:(NSDictionary *)dict {
    
    if ([dict[@"devices"] count]) {
        self.devices = [BLDeviceModel mj_objectArrayWithKeyValuesArray:dict[@"devices"]];
    }
    
    if (dict[@"residential"]) {
        self.residential = [BLResidentialModel mj_objectWithKeyValues:dict[@"residential"]];
    }
}


@end

