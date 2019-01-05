//
//  AdmobAdapter.m
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2018/12/26.
//  Copyright © 2018 xiangyu.zhao. All rights reserved.
//

#import "XYAdmobBannerAdapter.h"
#import "XYBasicAd.h"
#import "XYBannerManager.h"

@import GoogleMobileAds;

@interface XYAdmobBannerAdapter()<GADBannerViewDelegate>

@property(nonatomic, strong) GADBannerView *bannerView;
//rootViewController
@property (nonatomic, strong) UIViewController *rootViewController;

@end

@implementation XYAdmobBannerAdapter
+ (void)initialize{
    [super initialize];
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-7983146809499701~6114532779"];
}

- (void)loadAd{
    self.bannerView = [[GADBannerView alloc]
                       initWithAdSize:kGADAdSizeSmartBannerPortrait];
    //test ID ca-app-pub-3940256099942544/2934735716

    self.bannerView.adUnitID = @"ca-app-pub-7983146809499701/1658915463";
#if DEBUG
//    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
#endif
    self.bannerView.rootViewController = self.rootViewController;
    self.bannerView.delegate = self;
    [self.bannerView loadRequest:[GADRequest request]];
}

- (UIViewController *)rootViewController{
    _rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (_rootViewController == nil) {
        _rootViewController = [[UIViewController alloc] init];
    }
    return _rootViewController;
}

#pragma mark GADBannerViewDelegate methods

/// Tells the delegate that an ad request successfully received an ad. The delegate may want to add
/// the banner view to the view hierarchy if it hasn't been added yet.
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView{
    XYBasicAd *ad = [[XYBasicAd alloc] initWithRecievedAdView:bannerView];
    [[XYBannerManager shareInstance] insertAdtoPool:ad];
}

/// Tells the delegate that an ad request failed. The failure is normally due to network
/// connectivity or ad availablility (i.e., no fill).
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error{
    NSLog(@"%s",__func__);
}

#pragma mark Click-Time Lifecycle Notifications

/// Tells the delegate that a full screen view will be presented in response to the user clicking on
/// an ad. The delegate may want to pause animations and time sensitive interactions.
- (void)adViewWillPresentScreen:(GADBannerView *)bannerView{
    
}

/// Tells the delegate that the full screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)bannerView{
    
}

/// Tells the delegate that the full screen view has been dismissed. The delegate should restart
/// anything paused while handling adViewWillPresentScreen:.
- (void)adViewDidDismissScreen:(GADBannerView *)bannerView{
    
}

/// Tells the delegate that the user click will open another app, backgrounding the current
/// application. The standard UIApplicationDelegate methods, like applicationDidEnterBackground:,
/// are called immediately before this method is called.
- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView{
    
}
@end
