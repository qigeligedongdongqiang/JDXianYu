//
//  JDPostViewController.m
//  JDXianYu
//
//  Created by JADON on 16/8/24.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import "JDPostViewController.h"
#import "JDPostMenuButton.h"

#define KPostMargin 11.5

//屏幕尺寸
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//自定义颜色rgba
#define ColorWithRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0] //<<< 用10进制表示颜色，例如（255,255,255）黑色

@interface JDPostViewController ()
@property (nonatomic, weak) UIButton *mainBtn;
@property (nonatomic, assign) BOOL show;
@property (nonatomic, strong) NSArray *menuImgAry;
@property (nonatomic, strong) NSMutableArray *itemButtons;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger upIndex;
@property (nonatomic, assign) NSInteger downIndex;
@end

@implementation JDPostViewController

- (NSMutableArray *)itemButtons {
    if (_itemButtons == nil) {
        _itemButtons = [NSMutableArray array];
    }
    return _itemButtons;
}

- (NSArray *)menuImgAry{
    
    if (_menuImgAry==nil) {
        
        _menuImgAry = [NSArray array];
        
        _menuImgAry = @[@"post_animate_camera",@"post_animate_album",@"post_animate_akey"];
    }
    
    return _menuImgAry;
}

//重新初始化主视图样式 透明->
-(void)loadView{
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [view setBackgroundColor:[UIColor whiteColor]];
    
    //获取截取的背景图片，便于达到模糊背景效果
    UIImageView *imgView = [[UIImageView alloc]initWithImage:_backImg];
    
    //模糊效果层
    UIView *blurView =[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [blurView setBackgroundColor:ColorWithRGBA(64, 64, 64, 0.9)];// [UIColor colorWithWhite:0.9 alpha:0.8]];
    
    [imgView addSubview:blurView];
    
    [view addSubview:imgView];
    
    self.view = view;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBtns];
    
    //定时器控制每个按钮弹出的时间
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(popupBtn) userInfo:nil repeats:YES];
    
    //添加手势点击事件
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissBtnClick)];
    [self.view addGestureRecognizer:touch];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionOverrideInheritedDuration animations:^{
        self.mainBtn.transform =CGAffineTransformMakeRotation(-M_PI_4);
    } completion:nil];
}

- (void)addBtns {
    UIButton *mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mainBtn setBackgroundImage:[UIImage imageNamed:@"post_animate_add"] forState:UIControlStateNormal];
    CGFloat mainBtnWH = 56;
    mainBtn.center = CGPointMake(self.view.center.x, self.view.bounds.size.height-KPostMargin-mainBtnWH/2);
    mainBtn.bounds = CGRectMake(0, 0, 56, 56);
    self.mainBtn = mainBtn;
    self.show = CGAffineTransformIsIdentity(self.mainBtn.transform);
    [self.view addSubview:mainBtn];
    [mainBtn addTarget:self action:@selector(dismissBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    for (int i = 0; i < self.menuImgAry.count; i++) {
        
        //NSArray *arrTitle = @[@"拍照",@"相册",@"淘宝一键转卖"];
        NSArray *arrTitle = @[@"拍照",@"相册",@"淘宝一键转卖"];
        
        
        JDPostMenuButton *btn = [JDPostMenuButton buttonWithType:UIButtonTypeCustom];
        
        //图标图片和文本
        UIImage *img = [UIImage imageNamed:self.menuImgAry[i]];
        NSString *title = arrTitle[i];
        
        [btn setImage:img forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        
        
        btn.frame = self.mainBtn.frame;
        
        btn.tag = 1000 + i;
        
        [btn addTarget:self action:@selector(dismissBtnClick)  forControlEvents:UIControlEventTouchUpInside];
        
        [self.itemButtons addObject:btn];
        
        _downIndex =self.itemButtons.count-1;
        
        [self.view addSubview:btn];
    }
    
    [self.view bringSubviewToFront:self.mainBtn];

}

- (void)popupBtn{
    
    if (_upIndex == self.itemButtons.count) {
        
        [self.timer invalidate];
        
        _upIndex = 0;
        
        return;
    }
    
    JDPostMenuButton *btn = self.itemButtons[_upIndex];
    
    [self setUpOneBtnAnim:btn];
    
    _upIndex++;
}

//设置按钮从第一个开始向上滑动显示
- (void)setUpOneBtnAnim:(UIButton *)btn
{
//    
//    [UIView animateWithDuration:3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        btn.transform = CGAffineTransformMakeTranslation(0, -100);
//        btn.bounds = CGRectMake(0, 0, 100, 100);
//    } completion:^(BOOL finished){
//        
//        //获取当前显示的菜单控件的索引
//        _downIndex = self.itemButtons.count - 1;
//    }];
    
    NSInteger cols = 3;
    NSInteger col = 0;
    NSInteger row = 0;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat wh = 100;
    
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width - cols * wh) / (cols + 1);
    
    //此处按照不同屏幕尺寸适配
    CGFloat oriY = 470;
    if (kScreenHeight == 480) {
        //4/4s
        oriY = 283;
    }else if (kScreenHeight == 568){
        //5/5s
        oriY = 370;
    }else if (kScreenHeight == 667){
        //6/6S
        oriY = 470;
    }else{
        //6P 736
        oriY = 539;
    }
    
    #warning 一个按钮对应一个组动画
    // 创建动画
    // 创建组组动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.3;
    
    // 添加一个 ”平移动画“
    CAKeyframeAnimation *positionAni = [CAKeyframeAnimation animation];
    positionAni.keyPath = @"position";
    
    
    // 添加一个 ”旋转的动画“
    CAKeyframeAnimation *rotationAni = [CAKeyframeAnimation animation];
    rotationAni.keyPath = @"transform.rotation";
    

    //重新设置每个按钮的位置
    //列数(个数除总列数取余)
    col = _upIndex % cols;
    //行数(个数除总列数取整)
    row = _upIndex / cols;
    //x 平均间隔 + 前图标宽度
    x = margin + col * (margin + wh);
    //y 起始y + 前宽度
    y = row * (margin + wh) + oriY;
    
    //
    
    // 最终显示的位置
    CGPoint showPosition = CGPointMake(x+wh/2, y+wh/2);
    
    //设置 "平移动画: 的 路径
    NSValue *value1 = [NSValue valueWithCGPoint:self.mainBtn.center];
    NSValue *value2 = [NSValue valueWithCGPoint:showPosition];
    positionAni.values = @[value1,value2,value2,value2];
        
    //设置 旋转的路径
    rotationAni.values = @[@(M_PI_4),@(-M_PI_4 * 0.1),@(M_PI_4 * 0.1),@0];
    
    //添加子动画
    group.animations = @[positionAni,rotationAni];
    
    //执行组动画
    [btn.layer addAnimation:group forKey:nil];
    btn.bounds = CGRectMake(0, 0, wh, wh);
    btn.center = showPosition;
}


- (void)dismissBtnClick {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(returnUpVC) userInfo:nil repeats:YES];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.mainBtn.transform =CGAffineTransformIdentity;
    }];
    
}

//设置按钮从后往前下落
- (void)returnUpVC{
    
    if (_downIndex == -1) {
        
        [self.timer invalidate];
        
        return;
    }
    
    JDPostMenuButton *btn = self.itemButtons[_downIndex];
    
    [self setDownOneBtnAnim:btn];
    
    _downIndex--;
}

//按钮下滑并返回上一个控制器
- (void)setDownOneBtnAnim:(UIButton *)btn
{
#warning 一个按钮对应一个组动画
    // 创建动画
    // 创建组组动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.3;
    
    // 添加一个 ”平移动画“
    CAKeyframeAnimation *positionAni = [CAKeyframeAnimation animation];
    positionAni.keyPath = @"position";
    
    
    // 添加一个 ”旋转的动画“
    CAKeyframeAnimation *rotationAni = [CAKeyframeAnimation animation];
    rotationAni.keyPath = @"transform.rotation";
    
    
    // 最终显示的位置
    CGPoint showPosition = self.mainBtn.center;
    
    //设置 "平移动画: 的 路径
    NSValue *value1 = [NSValue valueWithCGPoint:btn.center];
    NSValue *value2 = [NSValue valueWithCGPoint:showPosition];
    positionAni.values = @[value1,value2];
    
    //设置 旋转的路径
    rotationAni.values = @[@0,@(M_PI_4)];
    
    //添加子动画
    group.animations = @[positionAni,rotationAni];
    
    //执行组动画
    [btn.layer addAnimation:group forKey:nil];
    btn.bounds = self.mainBtn.bounds;
    btn.center = showPosition;
    if (_downIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
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
