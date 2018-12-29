//
//  BasicAd.h
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2018/12/28.
//  Copyright © 2018 xiangyu.zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYBasicAd : NSObject

//adView
@property (nonatomic, strong, readonly) UIView *adView;

- (instancetype)initWithRecievedAdView:(UIView *)adView;

@end

NS_ASSUME_NONNULL_END
