//
//  XYScanView.h
//  CodeScanner
//
//  Created by zhaoxiangyu on 2018/12/20.
//  Copyright © 2018 wangyuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XYCodeScannerType) {
    XYCodeScannerTypeAll = 0,   //default, scan QRCode and barcode
    XYCodeScannerTypeQRCode,    //scan QRCode only
    XYCodeScannerTypeBarcode,   //scan barcode only
};

@interface XYScanView : UIView

//resultBlock
@property (nonatomic, strong) void (^resultBlock)(NSString *value, XYCodeScannerType type);

- (instancetype)initWithScanType:(XYCodeScannerType)type;

- (void)startScan;
- (void)stopSan;

@end

NS_ASSUME_NONNULL_END
