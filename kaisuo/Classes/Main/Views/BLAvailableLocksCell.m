//
//  BLAvailableLocksCell.m
//  kaisuo
//
//  Created by XenonChau on 01/03/2018.
//  Copyright © 2018 苗壮. All rights reserved.
//

#import "BLAvailableLocksCell.h"
#import "BLAvailableLocksModel.h"// .h中声明了一个@class，防止循环引用。

@implementation BLAvailableLocksCell

- (void)updateCellWithModel:(BLAvailableLocksModel *)model {
    self.lockNameLabel.text = model.lockName;
    self.lockSwitch.on = model.lockStatus;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
