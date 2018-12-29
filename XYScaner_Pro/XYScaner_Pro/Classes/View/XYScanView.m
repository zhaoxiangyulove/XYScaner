//
//  XYScanView.m
//  CodeScanner
//
//  Created by zhaoxiangyu on 2018/12/20.
//  Copyright © 2018 wangyuxiang. All rights reserved.
//

#import "XYScanView.h"
#import <AVFoundation/AVFoundation.h>

@interface XYScanView()<AVCaptureMetadataOutputObjectsDelegate>{
    BOOL _inProcessing;
}

@property (nonatomic, strong) AVCaptureSession *session;


@end

@implementation XYScanView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init{
    return [self initWithScanType:XYCodeScannerTypeAll];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    return [self initWithScanType:XYCodeScannerTypeAll];
}

- (instancetype)initWithScanType:(XYCodeScannerType)type
{
    self = [super init];
    if (self) {
        //判断权限
        __weak typeof(self)weakSelf = self;
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    [weakSelf setCameraViewWithScanType:type];
                    [weakSelf startScan];
                    self->_inProcessing = NO;
                } else {
                    NSString *title = @"请在iPhone的”设置-隐私-相机“选项中，允许App访问你的相机";
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:@"" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
                    [alertView show];
                }
                
            });
        }];
        
    }
    return self;
}
- (void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    if (layer == self.layer) {
        layer.sublayers.firstObject.frame = self.layer.bounds;
    }
}

- (void)setCameraViewWithScanType:(XYCodeScannerType)scanType{
    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    self.session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:input]) {
        [self.session addInput:input];
    }
    if ([self.session canAddOutput:output]) {
        [self.session addOutput:output];
    }
    //设置扫码支持的编码格式
    switch (scanType) {
        case XYCodeScannerTypeAll:
            output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,
                                         AVMetadataObjectTypeEAN13Code,
                                         AVMetadataObjectTypeEAN8Code,
                                         AVMetadataObjectTypeUPCECode,
                                         AVMetadataObjectTypeCode39Code,
                                         AVMetadataObjectTypeCode39Mod43Code,
                                         AVMetadataObjectTypeCode93Code,
                                         AVMetadataObjectTypeCode128Code,
                                         AVMetadataObjectTypePDF417Code];
            break;
            
        case XYCodeScannerTypeQRCode:
            output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode];
            break;
            
        case XYCodeScannerTypeBarcode:
            output.metadataObjectTypes=@[AVMetadataObjectTypeEAN13Code,
                                         AVMetadataObjectTypeEAN8Code,
                                         AVMetadataObjectTypeUPCECode,
                                         AVMetadataObjectTypeCode39Code,
                                         AVMetadataObjectTypeCode39Mod43Code,
                                         AVMetadataObjectTypeCode93Code,
                                         AVMetadataObjectTypeCode128Code,
                                         AVMetadataObjectTypePDF417Code];
            break;
            
        default:
            break;
    }
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.layer.bounds;
    [self.layer insertSublayer:layer atIndex:0];
}

- (BOOL)isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera];
}

- (void)startScan{
    if (self.session && [self isCameraAvailable]) {
        [self.session startRunning];
    }
    _inProcessing = NO;
}

- (void)stopSan{
    [self.session stopRunning];
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (_inProcessing) {
        return;
    }
    if (metadataObjects.count > 0) {
        _inProcessing = YES;
        XYCodeScannerType type;
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
        if ([metadataObject.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            type = XYCodeScannerTypeQRCode;
        }else{
            type = XYCodeScannerTypeBarcode;
        }
        NSString *result = metadataObject.stringValue;
        if (_resultBlock) {
            _resultBlock(result,type);
        }
    }
}

@end
