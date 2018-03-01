//
//  BLAvailableLocksModel.h
//  kaisuo
//
//  Created by XenonChau on 01/03/2018.
//  Copyright © 2018 苗壮. All rights reserved.
//

#import "BLBaseModel.h"

@interface BLAvailableLocksModel : BLBaseModel

@property (strong, nonatomic) NSString *lockName;
@property (assign, nonatomic) BOOL lockStatus;

@end
