//
//  BLUserModel.h
//  kaisuo
//
//  Created by XenonChau on 30/01/2018.
//  Copyright © 2018 苗壮. All rights reserved.
//

#import "BLBaseModel.h"

@interface BLDeviceModel : BLBaseModel

@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *deviceName;
@property (nonatomic, copy) NSString *devicePSW;
@property (nonatomic, copy) NSString *deviceImg;
@end

@interface BLResidentialModel : BLBaseModel

@property (nonatomic, copy) NSString *enterpriseName;
@property (nonatomic, copy) NSString *name;

@end

@interface BLUserModel : BLBaseModel

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary;

@property (nonatomic, copy) NSArray<BLDeviceModel *> *devices;
@property (nonatomic, strong) BLResidentialModel *residential;

@end


