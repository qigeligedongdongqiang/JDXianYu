//
//  JDScanCodeControllerViewController.m
//  JDXianYu
//
//  Created by JADON on 16/8/30.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import "JDScanCodeControllerViewController.h"
#import "JDScanView.h"

@interface JDScanCodeControllerViewController ()<JDScanViewDelegate>

@property (nonatomic, strong) JDScanView * scanView;

@end

@implementation JDScanCodeControllerViewController


#pragma mark - initial
+ (instancetype)scanCodeController
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.scanView = [JDScanView scanViewShowInController: self];
    }
    return self;
}


#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:YES];
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
//    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview: self.scanView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self.scanView start];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear: animated];
    [self.scanView stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [self.scanView stop];
}


#pragma mark - JDScanCodeController
/**
 *  扫描成功时回调
 */
- (void)scanView:(JDScanView *)scanView codeInfo:(NSString *)codeInfo
{
    if ([_scanDelegate respondsToSelector: @selector(scanCodeController:codeInfo:)]) {
        [_scanDelegate scanCodeController: self codeInfo: codeInfo];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName: JDSuccessScanQRCodeNotification object: self userInfo: @{ JDScanQRCodeMessageKey: codeInfo }];
    }
}

- (void)scanViewDismissSuperViewController:(JDScanView *)scanView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
