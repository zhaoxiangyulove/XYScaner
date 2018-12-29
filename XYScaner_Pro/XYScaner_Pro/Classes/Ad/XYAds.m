//
//  XYAds.m
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2018/12/28.
//  Copyright © 2018 xiangyu.zhao. All rights reserved.
//

#import "XYAds.h"
#import "XYBannerLoader.h"

@implementation XYAds

+ (void)initializeSDK{
    [XYBannerLoader loadWithCount:1];
}

@end
