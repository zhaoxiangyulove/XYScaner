//
//  ScanResultViewController.h
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2018/12/25.
//  Copyright © 2018 xiangyu.zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYScanView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScanResultViewController : UIViewController

+ (instancetype)creatResultControllerWithBarcodeStr:(NSString *)barcodeStr type:(XYCodeScannerType)type;

@end

NS_ASSUME_NONNULL_END
