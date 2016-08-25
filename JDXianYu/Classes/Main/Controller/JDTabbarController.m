//
//  JDTabbarController.m
//  JDXianYu
//
//  Created by JADON on 16/8/24.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import "JDTabbarController.h"
#import "JDNavigationController.h"
#import "JDHomeTableViewController.h"
#import "JDFishTableViewController.h"
#import "JDMessageTableViewController.h"
#import "JDMineTableViewController.h"
#import "JDPostViewController.h"
#import "JDTabbar.h"
#import "UIImage+Extension.h"

@interface JDTabbarController ()<JDTabbarDelegate>

@end

@implementation JDTabbarController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:8];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:8];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpAllChildVc];
    
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    JDTabbar *tabbar = [[JDTabbar alloc] init];
    tabbar.delegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];

}

#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc
{
    
    
    JDHomeTableViewController *HomeVC = [[JDHomeTableViewController alloc] init];
    [self setUpOneChildVcWithVc:HomeVC Image:@"home_normal" selectedImage:@"home_highlight" title:@"闲鱼"];
    
    JDFishTableViewController *FishVC = [[JDFishTableViewController alloc] init];
    [self setUpOneChildVcWithVc:FishVC Image:@"fishpond_normal" selectedImage:@"fishpond_highlight" title:@"鱼塘"];
    
    JDMessageTableViewController *MessageVC = [[JDMessageTableViewController alloc] init];
    [self setUpOneChildVcWithVc:MessageVC Image:@"message_normal" selectedImage:@"message_highlight" title:@"消息"];
    
    JDMineTableViewController *MineVC = [[JDMineTableViewController alloc] init];
    [self setUpOneChildVcWithVc:MineVC Image:@"account_normal" selectedImage:@"account_highlight" title:@"我的"];
}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    JDNavigationController *nav = [[JDNavigationController alloc] initWithRootViewController:Vc];
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Vc.tabBarItem.selectedImage = mySelectedImage;
    
    Vc.tabBarItem.title = title;
    
    [self addChildViewController:nav];
    
}

#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(JDTabbar *)tabbar
{
    JDPostViewController *plusVC = [[JDPostViewController alloc] init];
    //虚化背景
    UIImage *image = [UIImage imageWithCaputureView:self.view];
    plusVC.backImg = image;
    
    [plusVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:plusVC animated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
