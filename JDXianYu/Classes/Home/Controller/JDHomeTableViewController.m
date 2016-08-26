//
//  JDHomeTableViewController.m
//  JDXianYu
//
//  Created by JADON on 16/8/24.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import "JDHomeTableViewController.h"
#import "Masonry.h"

@interface JDHomeTableViewController ()
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation JDHomeTableViewController
- (void)viewWillAppear:(BOOL)animated {
    [self setNavBar];
    
}
    

- (void)setNavBar {
    //设置导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_bg"] forBarMetrics:UIBarMetricsDefault];
    //设置leftButtonItem
    UIImage *img = [[UIImage imageNamed:@"home_bar_scan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(searchCode)];
    //设置搜索框
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 260, 44)];
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    //去除搜索框的灰色背景
    if (version == 7.0) {
        
        
        _searchBar.backgroundColor = [UIColor clearColor];
        
        _searchBar.barTintColor = [UIColor clearColor];
        
        
    }else{
        
        for(int i =  0 ;i < _searchBar.subviews.count;i++){
            
            UIView * backView = _searchBar.subviews[i];
            
            if ([backView isKindOfClass:NSClassFromString(@"UISearchBarBackground")] == YES) {
                
                
                [backView removeFromSuperview];
                [_searchBar setBackgroundColor:[UIColor clearColor]];
                break;
                
            }else{
                
                
                NSArray * arr = _searchBar.subviews[i].subviews;
                
                for(int j = 0;j<arr.count;j++   ){
                    
                    UIView * barView = arr[i];
                    
                    
                    
                    if ([barView isKindOfClass:NSClassFromString(@"UISearchBarBackground")] == YES) {
                        
                        
                        [barView removeFromSuperview];
                        [_searchBar setBackgroundColor:[UIColor clearColor]];
                        break;
                        
                    }
                }
            }
        }
    }
    
    
    //    [self.searchBar setTintColor:[UIColor blackColor]];
    [self.searchBar setPlaceholder:@"请输入宝贝关键字或@用户名"];
    
    UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
    [searchField setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    
    
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 44)];
    [searchView addSubview:self.searchBar];
    self.navigationItem.titleView = searchView;
    
    //设置rightButtonItem
    UIImage *imgR = [[UIImage imageNamed:@"home_category_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:imgR style:UIBarButtonItemStylePlain target:self action:@selector(moreGategory)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
