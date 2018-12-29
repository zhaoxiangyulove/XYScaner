//
//  BasicAd.m
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2018/12/28.
//  Copyright © 2018 xiangyu.zhao. All rights reserved.
//

#import "XYBasicAd.h"

@implementation XYBasicAd


- (instancetype)initWithRecievedAdView:(UIView *)adView
{
    self = [super init];
    if (self) {
        _adView = adView;
    }
    return self;
}


@end
