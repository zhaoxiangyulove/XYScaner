//
//  XYAdmobRewardedVideoAdapter.m
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2019/1/3.
//  Copyright © 2019 xiangyu.zhao. All rights reserved.
//

#import "XYAdmobRewardedVideoAdapter.h"

@import GoogleMobileAds;

@interface XYAdmobRewardedVideoAdapter()<GADRewardBasedVideoAdDelegate>

@end

@implementation XYAdmobRewardedVideoAdapter
+ (void)initialize{
    [super initialize];
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-7983146809499701~6114532779"];
}

- (void)loadAd{
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:[GADRequest request]
                                           withAdUnitID:@"ca-app-pub-7983146809499701/4858604509"];
    
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
//    NSString *rewardMessage = [NSString stringWithFormat:@"Reward received with currency %@ , amount %lf",reward.type,[reward.amount doubleValue]];
}

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is received.");
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Opened reward based video ad.");
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad started playing.");
}

- (void)rewardBasedVideoAdDidCompletePlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad has completed.");
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:[GADRequest request]
                                           withAdUnitID:@"ca-app-pub-7983146809499701/9229503476"];
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad will leave application.");
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    NSLog(@"Reward based video ad failed to load.");
}

@end
