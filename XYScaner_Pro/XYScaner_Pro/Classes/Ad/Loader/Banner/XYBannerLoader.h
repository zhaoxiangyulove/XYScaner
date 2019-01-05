//
//  XYBannerLoader.h
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2018/12/26.
//  Copyright © 2018 xiangyu.zhao. All rights reserved.
//

#import "XYBasicLoader.h"
#import "XYBasicAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYBannerLoader : XYBasicLoader

+ (void)setDelegate:(id <LoadBasicDelegate>)delegate;

+ (void)loadWithCount:(int)count;



@end

NS_ASSUME_NONNULL_END
