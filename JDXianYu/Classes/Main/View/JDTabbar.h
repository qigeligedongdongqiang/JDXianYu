//
//  JDTabbar.h
//  JDXianYu
//
//  Created by JADON on 16/8/24.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDTabbar;

@protocol JDTabbarDelegate <NSObject>

- (void)tabBarPlusBtnClick:(JDTabbar *)tabbar;

@end

@interface JDTabbar : UITabBar

@property (nonatomic, weak) id<JDTabbarDelegate> delegate;

@end
