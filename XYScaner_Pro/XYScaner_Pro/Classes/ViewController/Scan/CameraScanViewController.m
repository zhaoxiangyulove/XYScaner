//
//  CameraScanViewController.m
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2018/12/24.
//  Copyright © 2018 xiangyu.zhao. All rights reserved.
//

#import "CameraScanViewController.h"
#import "XYScanView.h"
#import "Constants.h"
#import "ScanResultViewController.h"

@interface CameraScanViewController ()
@property (nonatomic, strong) XYScanView *scanView;
//scanLaser
@property (nonatomic, strong) UIImageView *scanLaser;;

@end

@implementation CameraScanViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self updateUI];
    // Do any additional setup after loading the view.
}

- (void)updateUI{
    [self setBackButton];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.scanView startScan];
    self.scanLaser.frame = CGRectMake(0, -60, SCREEN_WIDTH, 40);
    [UIView animateWithDuration:5 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        self.scanLaser.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 40);
    } completion:nil];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.scanView stopSan];
}

- (void)setBackButton{
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBackViewController) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(20, 40, 32, 32);
    [self.view addSubview:backBtn];
}

- (void)goBackViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleResult:(NSString *)result type:(XYCodeScannerType)type{
    UINavigationController *navCtr = [[UINavigationController alloc] initWithRootViewController:[ScanResultViewController creatResultControllerWithBarcodeStr:result type:type]];
    [self presentViewController:navCtr animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark getter methods

- (XYScanView *)scanView{
    if (_scanView == nil) {
        XYScanView *scanView = [[XYScanView alloc] init];
        scanView.frame = self.view.bounds;
        __weak typeof(self)weakSelf = self;
        scanView.resultBlock = ^(NSString * _Nonnull value, XYCodeScannerType type) {
            [weakSelf handleResult:value type:type];
        };
        [self.view insertSubview:scanView atIndex:0];
        _scanView = scanView;
    }
    return _scanView;
}

- (UIImageView *)scanLaser{
    if (_scanLaser == nil) {
        UIImageView *scanLaser = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_laser"]];
        [self.view insertSubview:scanLaser aboveSubview:_scanView];
        _scanLaser = scanLaser;
    }
    return _scanLaser;
}
@end
