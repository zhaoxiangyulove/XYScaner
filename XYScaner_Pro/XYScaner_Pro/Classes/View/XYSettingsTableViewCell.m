//
//  XYSettingsTableViewCell.m
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2019/1/19.
//  Copyright © 2019 xiangyu.zhao. All rights reserved.
//

#import "XYSettingsTableViewCell.h"

@interface XYSettingsTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *actionContainView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//watchAdBtn
@property (nonatomic, strong) UIButton *watchAdBtn;

@end

@implementation XYSettingsTableViewCell

+ (XYSettingsTableViewCell *)cellWithName:(NSString *)name{
    XYSettingsTableViewCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"XYSettingsTableViewCell" owner:self options:nil] lastObject];
    cell.titleLabel.text = name;
    return cell;
}

- (void)setNeedWatchAdCount:(NSInteger)needWatchAdCount{
    if (needWatchAdCount != 0) {
        [self watchAdBtn];
    }else{
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
}

- (void)setImageName:(NSString *)imageName{
    if (imageName) {
        self.iconImageView.image = [UIImage imageNamed:imageName];
    }
}
- (void)layoutIfNeeded{
    [super layoutIfNeeded];
    _watchAdBtn.frame = CGRectMake(_actionContainView.bounds.size.width - 100, 0, 100, 50);
}

- (UIButton *)watchAdBtn{
    if (_watchAdBtn == nil) {
        _watchAdBtn = [[UIButton alloc] init];
        [_watchAdBtn setTitle:@"watch ad to unlock" forState:UIControlStateNormal];
        _watchAdBtn.titleLabel.numberOfLines = 2;
        _watchAdBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_actionContainView addSubview:_watchAdBtn];
        _actionContainView.backgroundColor = [UIColor redColor];
    }
    return _watchAdBtn;
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
