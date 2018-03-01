//
//  BLAvailableLocksCell.h
//  kaisuo
//
//  Created by XenonChau on 01/03/2018.
//  Copyright © 2018 苗壮. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLAvailableLocksModel;

@interface BLAvailableLocksCell : UITableViewCell

- (void)updateCellWithModel:(BLAvailableLocksModel *)model;

// 如果用了上面的update方法，下面这两个属性无需开放给controller。
@property (weak, nonatomic) IBOutlet UILabel *lockNameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *lockSwitch;

@end
