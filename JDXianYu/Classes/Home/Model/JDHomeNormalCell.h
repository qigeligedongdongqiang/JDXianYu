//
//  JDHomeNormalCell.h
//  JDXianYu
//
//  Created by JADON on 16/8/26.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDHomeNormalCell : NSObject
@property (nonatomic, copy) NSString *head;
@property (nonatomic, copy) NSString *selfDescription;
@property (nonatomic, copy) NSString *foot;
@property (nonatomic, copy) NSString *img1;
@property (nonatomic, copy) NSString *img2;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)homeCellWithDic:(NSDictionary *)dic;

+ (NSMutableArray *)homeCellsList;
@end
