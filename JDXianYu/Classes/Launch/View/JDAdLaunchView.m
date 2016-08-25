//
//  JDAdLaunchView.m
//  JDXianYu
//
//  Created by JADON on 16/8/22.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import "JDAdLaunchView.h"
#import "DACircularProgressView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"


@interface JDAdLaunchView()
@property (nonatomic, strong) UIView *adBackground;
@property (nonatomic, strong) DACircularProgressView *progressView;
@property (nonatomic, strong) UIButton *progressButtonView;
@property (nonatomic, strong) NSString *imgURL;
@property (nonatomic, strong) UIImageView *adImageView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger timeSecond;

@end

@implementation JDAdLaunchView

- (instancetype)initWithFrame:(CGRect)frame {
//    NSLog(@"%@",NSHomeDirectory());
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.adBackground];
        [self displayCachedAd];
        [self requestBanner];
        [self showProgressView];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
    return self;
}

#pragma mark - 加载背景View
- (UIView *)adBackground {
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGFloat backgoundW = screenRect.size.width;
    CGFloat backgroundH = screenRect.size.height;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, backgroundH-128, backgoundW, 128)];
    footer.backgroundColor = [UIColor whiteColor];
    
    UIImageView *slogan = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splash_screen_btm"]];
    [footer addSubview:slogan];
    
    [slogan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(footer);
    }];
    
    UIView *adBackgroundView = [[UIView alloc] initWithFrame:screenRect];
    adBackgroundView.backgroundColor = [UIColor whiteColor];
    [adBackgroundView addSubview:footer];
    
    return adBackgroundView;
}

#pragma mark - 获取本地图片缓存，如果没有广告则结束
- (void)displayCachedAd {
    SDWebImageManager *manager = [[SDWebImageManager alloc] init];
    NSURL *url = [NSURL URLWithString:self.imgURL];
    if ([[manager cacheKeyForURL:url] isEqualToString:@""]) {
        self.hidden = YES;
    } else {
        [self showImage];
    }
}

#pragma mark - 展示图片
- (void)showImage {
    self.adImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 128)];
    [self.adImageView sd_setImageWithURL:[NSURL URLWithString:self.imgURL]];
    [self.adImageView setUserInteractionEnabled: YES];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(singleTap)];
    [self.adImageView addGestureRecognizer: singleTap];
    [self addSubview: self.adImageView];
}

#pragma mark - 下载图片,实时更新缓存
- (void)requestBanner {
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.imgURL] options:SDWebImageRefreshCached progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        NSLog(@"图片下载成功");
    }];
}

#pragma mark - 图片点击事件
- (void) singleTap {
    if ([self.delegate respondsToSelector:@selector(adLaunch:)]) {
        [self.delegate adLaunch: self];
    }
    [self toHidenState];
}

#pragma mark - 消失动画
- (void)toHidenState {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

#pragma mark - 展示跳过按钮
- (void)showProgressView {
    self.progressButtonView = [[UIButton alloc] initWithFrame: CGRectMake([UIScreen mainScreen].bounds.size.width - 64, 20, 44, 44)];
    [self.progressButtonView setTitle:@"\n4s" forState: UIControlStateNormal];
    self.progressButtonView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.progressButtonView setBackgroundImage:[UIImage imageNamed:@"splash_skip"] forState:UIControlStateNormal];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeFlow) userInfo:nil repeats:YES];
    self.timer = timer;
    self.progressButtonView.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.progressButtonView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.progressButtonView.titleLabel.numberOfLines = 2;
//    self.progressButtonView.backgroundColor = [UIColor clearColor];
    [self.progressButtonView addTarget: self
                                action: @selector(toHidenState)
                      forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: self.progressButtonView];
    
    self.progressView = [[DACircularProgressView alloc] initWithFrame: CGRectMake([UIScreen mainScreen].bounds.size.width - 64, 20, 44, 44)];
    self.progressView.userInteractionEnabled = NO;
    self.progressView.trackTintColor = [UIColor clearColor];
    self.progressView. innerTintColor = [UIColor clearColor];
    self.progressView.thicknessRatio = 0.1;
    self.progressView.progress = 0;
    [self addSubview: self.progressView];
    [self.progressView setProgress: 1 animated: YES initialDelay:0 withDuration:4];
}

- (void)timeFlow {
    [self.progressButtonView setTitle:[NSString stringWithFormat:@"\n%lds",3-self.timeSecond] forState: UIControlStateNormal];
    self.timeSecond++;
    if (self.timeSecond == 4) {
        [self.timer invalidate];
    }
}

- (NSString *)imgURL {
    NSString *url = @"http://mg.soupingguo.com/bizhi/big/10/258/043/10258043.jpg";
    return url;
}


@end
