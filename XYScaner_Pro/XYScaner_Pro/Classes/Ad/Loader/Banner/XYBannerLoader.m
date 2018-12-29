//
//  XYBannerLoader.m
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2018/12/26.
//  Copyright © 2018 xiangyu.zhao. All rights reserved.
//

#import "XYBannerLoader.h"
#import "XYBannerManager.h"

@interface XYBannerLoader()

@property (nonatomic, strong) NSArray<XYBasicAdapter *> *adapterList;

//delegate
@property (nonatomic, weak) id<LoadBasicDelegate> delegate;

@end

static XYBannerLoader *_singleton = nil;

@implementation XYBannerLoader

+(void)setDelegate:(id<LoadBasicDelegate>)delegate{
    [self shareInstance];
    _singleton.delegate = delegate;
}

+ (void)loadWithCount:(int)count{
    [[self shareInstance] load:1];
}

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[self alloc] init];
    });
    return _singleton;
}

- (void)load:(int)count{
    for (XYBasicAdapter *adapter in self.adapterList) {
        [adapter loadAd];
    }
}

- (NSArray<XYBasicAdapter *> *)adapterList{
    if (_adapterList == nil) {
        NSMutableArray *tempList = [[NSMutableArray alloc] init];
        XYBasicAdapter *tempAdapter = [XYBasicAdapter creatAdapterWithClassName:@"XYAdmobBannerAdapter"];
        tempAdapter.delegate = self.delegate;
        [tempList addObject:tempAdapter];
        _adapterList = [tempList copy];
    }
    return _adapterList;
}

+ (BOOL)showBannerInView:(UIView *)view{
    BOOL canShown = [[XYBannerManager shareInstance] showInView:view];
    return canShown;
}

@end
