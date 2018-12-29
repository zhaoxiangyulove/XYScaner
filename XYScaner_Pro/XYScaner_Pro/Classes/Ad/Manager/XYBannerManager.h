//
//  XYBannerManager.h
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2018/12/28.
//  Copyright © 2018 xiangyu.zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYBasicManager.h"
#import "XYBasicAd.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYBannerManager : XYBasicManager

+ (instancetype)shareInstance;

- (BOOL)insertAdtoPool:(XYBasicAd *)ad;

- (BOOL)showInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
