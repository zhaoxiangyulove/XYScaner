//
//  BasicAdapter.h
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2018/12/26.
//  Copyright © 2018 xiangyu.zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYBasicAdapter : NSObject

//delegate
@property (nonatomic, weak) id<LoadBasicDelegate> delegate;

+ (instancetype)creatAdapterWithClassName:(NSString *)className;

- (void)loadAd;

@end

NS_ASSUME_NONNULL_END
