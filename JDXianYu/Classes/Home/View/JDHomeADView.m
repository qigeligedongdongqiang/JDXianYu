//
//  JDHomeADView.m
//  JDXianYu
//
//  Created by JADON on 16/8/26.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import "JDHomeADView.h"
#import "UIImageView+WebCache.h"
@interface JDHomeADView()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;


@end



@implementation JDHomeADView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)homeADView {
    JDHomeADView *homeADView = [[[NSBundle mainBundle] loadNibNamed:@"JDHomeADView" owner:nil options:nil] lastObject];
    return homeADView;
}

- (void)awakeFromNib{
    int imgCount=4;
    CGFloat imgW=self.scrollView.frame.size.width;
    CGFloat imgH=self.scrollView.frame.size.height;
    
    //通过接口获取图片
    NSURL *url = [NSURL URLWithString:@"http://parnote.com:5000/dongge"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic;
        if (data) {
            dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        }
    
        for(int i=0;i<imgCount;i++){
            UIImageView *imgView=[[UIImageView alloc] init];
            if (!error) {
                NSString *urlStr = [NSString stringWithFormat:@"%@.jpg", dic[@"img"][i]];
                NSURL *url =[NSURL URLWithString:urlStr];
                [imgView sd_setImageWithURL:url];
            } else {
                NSString *imgName=[NSString stringWithFormat:@"ad_%d",i];
                imgView.image=[UIImage imageNamed:imgName];
            }
            
            CGFloat imgX=i * imgW;
            CGFloat imgY=0;
            imgView.frame=CGRectMake(imgX, imgY, imgW, imgH);
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调到主线程添加子控件
                [self.scrollView addSubview:imgView];
            }) ;
        }
    }];
    [task resume];
    
    self.scrollView.contentSize=CGSizeMake(imgW*imgCount, 0);
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.pagingEnabled=YES;
    self.scrollView.delegate=self;
    
    self.pageControl.numberOfPages=imgCount;
    
    [self addTimer];
    }

- (void)addTimer{
    NSTimer *timer=[NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    self.timer=timer;
    NSRunLoop *runloop=[NSRunLoop currentRunLoop];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)nextImage{
    NSInteger page=self.pageControl.currentPage;
    if (page==self.pageControl.numberOfPages-1) {
        page=0;
    }else{
        page++;
    }
    //    self.pageControl.currentPage=page;
    CGFloat offsetX=page*self.scrollView.frame.size.width;
    [UIView animateWithDuration:1.0 animations:^{
        self.scrollView.contentOffset=CGPointMake(offsetX, 0);
    }];
    
}

#pragma mark-scrollView的Delegate方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page=(scrollView.contentOffset.x+scrollView.frame.size.width/2)/scrollView.frame.size.width;
    self.pageControl.currentPage=page;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //    self.timer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [self addTimer];
}



@end
