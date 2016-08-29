//
//  JDHomeTableViewController.h
//  JDXianYu
//
//  Created by JADON on 16/8/24.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDRefreshView.h"
typedef void(^DragEndBlock)(JDRefreshViewType);

@interface JDHomeTableViewController : UITableViewController
@property (nonatomic, assign) BOOL shouldShowDragHeader;
@property (nonatomic, assign) BOOL shouldShowDragFooter;

@property (nonatomic, assign) CGFloat dragHeaderHeight;
@property (nonatomic, assign) CGFloat dragFooterHeight;

@property (nonatomic, copy) DragEndBlock dragEndBlock;

- (instancetype)initWithStyle:(UITableViewStyle)style showDragRefreshHeader:(BOOL)showDragRefreshHeader showDragRefreshFooter:(BOOL)showDragRefreshFooter;
@end
