//
//  JDHomeNormalCell.m
//  JDXianYu
//
//  Created by JADON on 16/8/26.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import "JDHomeNormalCell.h"

@implementation JDHomeNormalCell

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)homeCellWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

+ (NSMutableArray *)homeCellsList{
    NSBundle *bundle= [NSBundle mainBundle];
    NSString *path= [bundle pathForResource:@"JDHomeNormalCell" ofType:@"plist"];
    NSArray *dicArray= [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *tempArray=[NSMutableArray array];
    for(NSDictionary *dic in dicArray){
        JDHomeNormalCell *homeCell=[JDHomeNormalCell homeCellWithDic:dic];
        [tempArray addObject:homeCell];
    }
    return tempArray;
}

@end
