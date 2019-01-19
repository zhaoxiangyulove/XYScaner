//
//  XYSettingsTableViewCell.m
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2019/1/19.
//  Copyright © 2019 xiangyu.zhao. All rights reserved.
//

#import "XYSettingsTableViewCell.h"

@implementation XYSettingsTableViewCell

+ (XYSettingsTableViewCell *)cellWithName:(NSString *)name{
    XYSettingsTableViewCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"XYSettingsTableViewCell" owner:self options:nil] lastObject];
    return cell;
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
