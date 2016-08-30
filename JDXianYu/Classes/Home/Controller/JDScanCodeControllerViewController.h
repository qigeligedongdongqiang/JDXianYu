//
//  JDScanCodeControllerViewController.h
//  JDXianYu
//
//  Created by JADON on 16/8/30.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDScanCodeControllerViewController;
@protocol JDScanCodeControllerViewControllerDelegate <NSObject>

- (void)scanCodeController: (JDScanCodeControllerViewController *)scanCodeController codeInfo: (NSString *)codeInfo;

@end


@interface JDScanCodeControllerViewController : UIViewController
/*! 扫描回调代理人*/
@property (nonatomic, weak) id<JDScanCodeControllerViewControllerDelegate> scanDelegate;

/*! 扫描构造器*/
+ (instancetype)scanCodeController;
@end
