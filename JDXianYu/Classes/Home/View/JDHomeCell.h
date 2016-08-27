//
//  JDHomeCell.h
//  JDXianYu
//
//  Created by JADON on 16/8/26.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDHomeNormalCell;

@interface JDHomeCell : UITableViewCell
@property (nonatomic, strong) JDHomeNormalCell *homeCell;

+ (instancetype)homeCellWithTableView:(UITableView *)tableView;
@end
