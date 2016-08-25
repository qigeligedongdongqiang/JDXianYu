//
//  JDAdLaunchView.h
//  JDXianYu
//
//  Created by JADON on 16/8/22.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDAdLaunchView;

@protocol JDAdLaunchViewDelegate <NSObject>

- (void)adLaunch:(JDAdLaunchView *)adLaunchView;

@end

@interface JDAdLaunchView : UIView

@property (nonatomic, weak) id<JDAdLaunchViewDelegate> delegate;

@end
