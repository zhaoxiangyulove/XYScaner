//
//  XYQRCodeResultView.h
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2019/1/2.
//  Copyright © 2019 xiangyu.zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    infoType = 0,
    urlType,
    cardType,
    emailType,
    smsType,
    eventType,
    emailAddressType,
    telType,
    mapType,
} QRType;

@protocol XYQRCodeResultViewDelegate <NSObject>


@end

NS_ASSUME_NONNULL_BEGIN

@interface XYQRCodeResultView : UIView

//delegate
@property (nonatomic, weak) id<XYQRCodeResultViewDelegate> delegate;
//qrType
@property (nonatomic, assign) QRType qrType;

+ (instancetype)resultViewWithQRCodeString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
