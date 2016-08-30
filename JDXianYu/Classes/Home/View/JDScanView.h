//
//  JDScanView.h
//  JDXianYu
//
//  Created by JADON on 16/8/30.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import <UIKit/UIKit.h>
/*! 扫描成功发送通知（在代理实现的情况下不发送）*/
extern NSString * const JDSuccessScanQRCodeNotification;
/*! 通知传递数据中存储二维码信息的关键字*/
extern NSString * const JDScanQRCodeMessageKey;

@class JDScanView;

@protocol JDScanViewDelegate <NSObject>

- (void)scanView: (JDScanView *)scanView codeInfo: (NSString *)codeInfo;
- (void)scanViewDismissSuperViewController:(JDScanView *)scanView;

@end

@interface JDScanView : UIView

/*! 扫描回调代理人*/
@property (nonatomic, weak) id<JDScanViewDelegate> delegate;
/*! 创建扫描视图，建议使用JDScanCodeController*/
+ (instancetype)scanViewShowInController: (UIViewController *)controller;

/*! 开始扫描*/
- (void)start;
/*! 结束扫描*/
- (void)stop;
@end
