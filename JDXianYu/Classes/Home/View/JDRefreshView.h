//
//  JDRefreshView.h
//  JDXianYu
//
//  Created by JADON on 16/8/29.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    JDRefreshViewTypeHeader,
    JDRefreshViewTypeFooter
}JDRefreshViewType;

typedef enum {
    JDRefreshViewStateDragToRefresh,
    JDRefreshViewStateLooseToRefresh,
    JDRefreshViewStateRefreshing
}JDRefreshViewState;

@interface JDRefreshView : UIView
@property (nonatomic, assign) JDRefreshViewState state;
- (instancetype)initWithFrame:(CGRect)frame Type:(JDRefreshViewType)type;

@end
