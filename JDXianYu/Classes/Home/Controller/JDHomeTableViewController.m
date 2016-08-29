//
//  JDHomeTableViewController.m
//  JDXianYu
//
//  Created by JADON on 16/8/24.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import "JDHomeTableViewController.h"
#import "Masonry.h"
#import "JDHomeADView.h"
#import "JDHomeNormalCell.h"
#import "JDHomeCell.h"
#import "JDRefreshView.h"


@interface JDHomeTableViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *homeCells;

@end

@implementation JDHomeTableViewController
{
    JDRefreshView *dragHeaderView;
    JDRefreshView *dragFooterView;
    
    BOOL headerRefreshing;
    BOOL footerRefreshing;
}


- (instancetype)initWithStyle:(UITableViewStyle)style showDragRefreshHeader:(BOOL)showDragRefreshHeader showDragRefreshFooter:(BOOL)showDragRefreshFooter {
    if (self = [super initWithStyle:style]) {
//        self.shouldShowDragHeader = showDragRefreshHeader;
//        self.shouldShowDragFooter = showDragRefreshFooter;
        
        self.dragHeaderHeight = 65.f;
        self.dragFooterHeight = 65.f;
        
        if (showDragRefreshHeader)
        {
            [self addDragHeaderView];
        }
        
        if (showDragRefreshFooter)
        {
            [self addDragFooterView];
        }

    }
    return  self;
}


- (void)addDragHeaderView
{
    if (!dragHeaderView)
    {
        CGRect frame = CGRectMake(0, -self.dragHeaderHeight,self.view.bounds.size.width, self.dragHeaderHeight);
        dragHeaderView = [[JDRefreshView alloc] initWithFrame:frame Type:JDRefreshViewTypeHeader];
        [self.view addSubview:dragHeaderView];
    }
}

- (void)addDragFooterView
{
    if (!dragFooterView)
    {
        CGFloat height = MAX(self.tableView.contentSize.height, self.view.frame.size.height);
        CGRect frame = CGRectMake(0, height,
                                  self.view.bounds.size.width, self.dragFooterHeight);
        dragFooterView = [[JDRefreshView alloc] initWithFrame:frame Type:JDRefreshViewTypeFooter];
        self.tableView.tableFooterView = dragFooterView;
//         [self.view addSubview:dragFooterView];
    }
}


- (NSMutableArray *)homeCells{
    if(_homeCells==nil){
        _homeCells=[JDHomeNormalCell homeCellsList];
    }
    return _homeCells;
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:imgR style:UIBarButtonItemStylePlain target:self action:@selector(moreCategory)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%f",self.tableView.contentSize.height);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    [self setNavBar];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [JDHomeADView homeADView];
    
}

- (void)searchCode {
    NSLog(@"%s",__func__);
}

- (void)moreCategory {
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.homeCells.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    JDHomeCell *cell = [JDHomeCell homeCellWithTableView:tableView];
    JDHomeNormalCell *homeCell = self.homeCells[indexPath.row];
    cell.homeCell = homeCell;
    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //动态修改headerView的位置
    if (headerRefreshing)
    {
        if (scrollView.contentOffset.y >= -scrollView.contentInset.top
            && scrollView.contentOffset.y < 0)
            
        {
            //注意:修改scrollView.contentInset时，若使当前界面显示位置发生变化，会触发scrollViewDidScroll:，从而导致死循环。
            //因此此处scrollView.contentInset.top必须为-scrollView.contentOffset.y
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if (scrollView.contentOffset.y == 0)//到0说明headerView已经在tableView最上方，不需要再修改了
        {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
    }
    
    //other code here...
   
    
    //拉动足够距离，头部刷新控件状态变更为“松开....” ，底部刷新控件状态直接变为“加载中”
    if (scrollView.contentOffset.y < -self.dragHeaderHeight - 64-10 && !headerRefreshing && !footerRefreshing) {
        if (dragHeaderView)
        {
            if (dragHeaderView.state == JDRefreshViewStateDragToRefresh)
            {
                [dragHeaderView setState:JDRefreshViewStateLooseToRefresh];
            }
        }

    } else if (scrollView.contentOffset.y>0 && scrollView.contentOffset.y<=self.dragFooterHeight && !headerRefreshing && !footerRefreshing){
        if (dragFooterView){
            [dragFooterView setState:JDRefreshViewStateRefreshing];
            footerRefreshing = YES;
            dispatch_async(dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT), ^{
                for (int i=0; i<999; i++) {
                    for (int j=0; j<9; j++) {
                        NSLog(@"%i",i);
                    }
                }
                [self completeDragRefresh:JDRefreshViewTypeFooter];
            });
        }
    }
    
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //拉动足够距离，松开后，状态变更为“加载中...”
    
        if (dragHeaderView.state == JDRefreshViewStateLooseToRefresh
            && scrollView.contentOffset.y < -self.dragHeaderHeight - 64 - 10
            && !headerRefreshing
            && !footerRefreshing)//每次只允许上拉或者下拉其中一个执行
        {
            headerRefreshing = YES;
            //使refresh panel保持显示
            self.tableView.contentInset = UIEdgeInsetsMake(self.dragHeaderHeight+64, 0, 0, 0);
            [dragHeaderView setState:JDRefreshViewStateRefreshing];
            
        }
    if (headerRefreshing) {
        dispatch_async(dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT), ^{
            for (int i=0; i<999; i++) {
                for (int j=0; j<9; j++) {
                    NSLog(@"%i",i);
                }
            }
            [self completeDragRefresh:JDRefreshViewTypeHeader];
        });
        

    }
}



#pragma mark - Other
- (void)completeDragRefresh:(JDRefreshViewType)type
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (type == JDRefreshViewTypeHeader) {
            self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        }
        
        [dragHeaderView setState:JDRefreshViewStateDragToRefresh];
        
    }) ;
       
    
    headerRefreshing = NO;
    footerRefreshing = NO;
}




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
