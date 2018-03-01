//
//  KCStatusTableViewCell.h
//  kaisuo
//
//  Created by 苗壮 on 2018/3/1.
//  Copyright © 2018年 苗壮. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
@class BLDeviceModel;

@interface KCStatusTableViewCell : UITableViewCell

#pragma mark 微博对象
@property (nonatomic,strong) BLDeviceModel *device;

#pragma mark 单元格高度
@property (assign,nonatomic) CGFloat height;

@end

