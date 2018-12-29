//
//  XYBannerManager.m
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2018/12/28.
//  Copyright © 2018 xiangyu.zhao. All rights reserved.
//

#import "XYBannerManager.h"
#import "XYBannerLoader.h"

@interface XYBannerManager()

@property (nonatomic, strong) NSMutableArray<XYBasicAd *> *AdPool;

@end

static XYBannerManager *_singleton = nil;

@implementation XYBannerManager

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[self alloc] init];
    });
    return _singleton;
}

- (BOOL)insertAdtoPool:(XYBasicAd *)ad{
    if (ad) {
        //后期用 CPM 排序
        [self.AdPool addObject:ad];
        return YES;
    }
    return NO;
}

- (BOOL)showInView:(UIView *)view{
    if (self.AdPool.firstObject) {
        UIView *adView = self.AdPool.firstObject.adView;
        if (adView) {
            CGRect frame = view.bounds;
            adView.frame = CGRectMake(0, frame.size.height - 50, frame.size.width, 50);
            [view addSubview:adView];
            return YES;
        }
    }
    return NO;
}

#pragma mark lazyLoading methods

- (NSMutableArray<XYBasicAd *> *)AdPool{
    if (_AdPool == nil) {
        _AdPool = [[NSMutableArray alloc] init];
    }
    return _AdPool;
}

@end
