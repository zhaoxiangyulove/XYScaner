//
//  BasicAdapter.m
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2018/12/26.
//  Copyright © 2018 xiangyu.zhao. All rights reserved.
//

#import "XYBasicAdapter.h"

@implementation XYBasicAdapter

+ (instancetype)creatAdapterWithClassName:(NSString *)className{
    if (className) {
        XYBasicAdapter *adapter = [[NSClassFromString(className) alloc] init];
        if (adapter) {
            return adapter;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

- (void)loadAd{
    
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        NSInteger subCount = [rootViewController.view subviews].count - 1;
        for (NSInteger index = subCount; index >=0 ; --index)
        {
            UIView *view = [[rootViewController.view subviews] objectAtIndex:index];
            id subViewController = [view nextResponder];    // Key property which most of us are unaware of / rarely use.
            if ( subViewController && [subViewController isKindOfClass:[UIViewController class]])
            {
                return [self topViewControllerWithRootViewController:subViewController];
            }
        }
        return rootViewController;
    }
}

@end
