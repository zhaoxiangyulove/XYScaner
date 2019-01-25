//
//  XYSettingsTableViewCell.h
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2019/1/19.
//  Copyright © 2019 xiangyu.zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYSettingsTableViewCell : UITableViewCell

//title
@property (nonatomic, strong) NSString *title;
//imageName
@property (nonatomic, strong) NSString *imageName;
//needWatchAdCount
@property (nonatomic, assign) NSInteger needWatchAdCount;

+ (XYSettingsTableViewCell *)cellWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
