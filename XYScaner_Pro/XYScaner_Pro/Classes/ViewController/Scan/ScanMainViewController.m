//
//  ScanMainViewController.m
//  XYScaner_Pro
//
//  Created by zhaoxiangyu on 2018/12/24.
//  Copyright © 2018 xiangyu.zhao. All rights reserved.
//

#import "ScanMainViewController.h"
#import "CameraScanViewController.h"



@interface ScanMainViewController ()

@end


@implementation ScanMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)ScanWithCamera:(UIButton *)sender {
    [self presentViewController:[[CameraScanViewController alloc] init] animated:YES completion:^{
        
    }];
}

@end
