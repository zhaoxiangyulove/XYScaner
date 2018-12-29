//
//  BasicDelegate.h
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2018/12/28.
//  Copyright © 2018 xiangyu.zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYBasicAd;

@protocol LoadBasicDelegate <NSObject>

- (UIViewController *)rootViewController;
- (void)loadedAnAd:(XYBasicAd *)ad;

@end
