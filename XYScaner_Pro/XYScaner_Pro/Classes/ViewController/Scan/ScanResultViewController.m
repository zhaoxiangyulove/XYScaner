//
//  ScanResultViewController.m
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2018/12/25.
//  Copyright © 2018 xiangyu.zhao. All rights reserved.
//

#import "ScanResultViewController.h"
#import <WebKit/WebKit.h>
#import "Constants.h"
#import "XYBannerManager.h"
#import "XYQRCodeResultView.h"
#import "XYAdmobRewardedVideoAdapter.h"

@import GoogleMobileAds;

@interface ScanResultViewController ()<WKUIDelegate, WKNavigationDelegate, LoadBasicDelegate, XYQRCodeResultViewDelegate>{
    NSString *_barcodeStr;
    XYCodeScannerType _barcodeType;
}

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) XYAdmobRewardedVideoAdapter *adapter;

@end

@implementation ScanResultViewController

+ (instancetype)creatResultControllerWithBarcodeStr:(NSString *)barcodeStr type:(XYCodeScannerType)type {
    return [[self alloc] initWithBarcodeStr:barcodeStr type:type];
}

- (instancetype)initWithBarcodeStr:(NSString *)barcodeStr type:(XYCodeScannerType)type {
    self = [super init];
    if (self) {
        _barcodeStr = barcodeStr;
        _barcodeType = type;
    }
    return self;
}

- (void)setBackItem{
    UIButton *back = [UIButton buttonWithType:UIButtonTypeSystem];
    [back setTitle:@"Back" forState:UIControlStateNormal];
    back.frame = CGRectMake(0, 0, 50, 32);
    [back addTarget:self action:@selector(goBackViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}
- (void)setRightItemWithQRType:(QRType)qrType{
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeSystem];
    switch (qrType) {
        case urlType:
            [rightItem setTitle:@"Open" forState:UIControlStateNormal];
            [rightItem addTarget:self action:@selector(openInSafari) forControlEvents:UIControlEventTouchUpInside];
            break;
        case cardType:
            [rightItem setTitle:@"Add" forState:UIControlStateNormal];
            break;
        case emailType:
        case emailAddressType:
            [rightItem setTitle:@"Send" forState:UIControlStateNormal];
            break;
        case smsType:
            [rightItem setTitle:@"XXXX" forState:UIControlStateNormal];
            break;
        case eventType:
            [rightItem setTitle:@"XXXX" forState:UIControlStateNormal];
            break;
        case telType:
            [rightItem setTitle:@"Call" forState:UIControlStateNormal];
            break;
        case mapType:
            [rightItem setTitle:@"XXXX" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    rightItem.frame = CGRectMake(0, 0, 50, 32);
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)goBackViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark QRcode RightItem methods

- (void)openInSafari{
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
    }
}

#pragma mark ViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setBackItem];
    // Do any additional setup after loading the view.
    if (_barcodeType == XYCodeScannerTypeBarcode) {
        self.navigationItem.title = @"loading...";
        [self showResultWithWebView];
    }else if(_barcodeType == XYCodeScannerTypeQRCode){
        self.navigationItem.title = @"QRCode Result";
        [self showQRCodeResult];
    }
//    [self loadAd];
    _adapter = [[XYAdmobRewardedVideoAdapter alloc] init];
    [_adapter loadAd];
    [self showAd];
    
}

- (void)showResultWithWebView{
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50)];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.upcitemdb.com/upc/%@",_barcodeStr]]]];
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
}

- (void)showQRCodeResult{
    XYQRCodeResultView *resultView = [XYQRCodeResultView resultViewWithQRCodeString:_barcodeStr];
    resultView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50);
    [self setRightItemWithQRType:resultView.qrType];
//    resultView.delegate = self;
    [self.view addSubview:resultView];
}

- (void)loadAd{
}

- (void)showAd{
    BOOL AdShown = [[XYBannerManager shareInstance] showInView:self.view];
    if (AdShown == NO) {
        //处理一次展示机会失败
        [self loadAd];
    }
}

#pragma mark LoadBasicDelegate methods

- (UIViewController *)rootViewController{
    return self;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//#pragma mark WKUIDelegate methods
//
//- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo{
//    NSLog(elementInfo.linkURL.absoluteString);
//    return YES;
//}

#pragma mark WKNavigationDelegate methods

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
}
// 当内容开始到达时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSString *removeAD_JS_Str = @"var ads = document.getElementsByClassName('adsbygoogle');var count = ads.length;while(count--){ads[count].style.display='none'}";
    [self.webView evaluateJavaScript:removeAD_JS_Str completionHandler:nil];
    NSString *jsToGetHTMLSource = @"document.title";
    __weak typeof(self)weakSelf = self;
    [webView evaluateJavaScript:jsToGetHTMLSource completionHandler:^(id _Nullable HTMLsource, NSError * _Nullable error) {
        weakSelf.title = HTMLsource?:@"Production Detail";
    }];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"%s",__func__);
}

@end
