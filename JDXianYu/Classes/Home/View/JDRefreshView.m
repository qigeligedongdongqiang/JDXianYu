//
//  JDRefreshView.m
//  JDXianYu
//
//  Created by JADON on 16/8/29.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import "JDRefreshView.h"

@implementation JDRefreshView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
{
    UILabel *hintLabel;
    UILabel *timeLabel;
    
    UIImageView *stateImageView;
    UIActivityIndicatorView *indicatorView;
    
    JDRefreshViewType refreshType;
}

@synthesize state;

- (instancetype)initWithFrame:(CGRect)frame Type:(JDRefreshViewType)type{
    if (self = [super initWithFrame:frame])
    {
        refreshType = type;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        //下拉可以刷新、松开可以刷新、刷新中
        hintLabel = [[UILabel alloc] init];
        hintLabel.autoresizingMask =
        UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        hintLabel.font = [UIFont boldSystemFontOfSize:13.f];
        hintLabel.textColor        = [UIColor lightGrayColor];
        hintLabel.backgroundColor  = [UIColor clearColor];
        hintLabel.textAlignment    = NSTextAlignmentCenter;
        [self addSubview:hintLabel];
        
        //上次刷新时间
        timeLabel = [[UILabel alloc] init];
        timeLabel.autoresizingMask =
        UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        timeLabel.font = [UIFont systemFontOfSize:10.f];
        timeLabel.textColor = [UIColor lightGrayColor];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:timeLabel];
        
        //状态指示图片
        stateImageView = [[UIImageView alloc] init];
        stateImageView.contentMode = UIViewContentModeScaleAspectFit;
//        stateImageView.image = [UIImage imageNamed:@"idlefish_begin"];
        [self addSubview:stateImageView];
        
        indicatorView = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicatorView.hidesWhenStopped  = YES;
        [self addSubview:indicatorView];
        
        switch (type)
        {
            case JDRefreshViewTypeHeader:
            {
                
                hintLabel.frame = CGRectMake(0, (frame.size.height - 50.f) / 3,
                                             frame.size.width, 30.f);
                timeLabel.frame = CGRectMake(0, (frame.size.height - 50.f) / 3 + 30.f,
                                             frame.size.width, 20.f);
                
                stateImageView.frame = CGRectMake(80.f, (frame.size.height - 65.f) / 2,
                                                  23.f, 60.f);
                indicatorView.frame = CGRectMake(80.f, (frame.size.height - 20.0f)/2, 20.0f, 20.f);
            }
                break;
            case JDRefreshViewTypeFooter:
            {
    
                hintLabel.frame = CGRectMake(0, (frame.size.height - 30.f) / 2,
                                             frame.size.width, 30.f);
                timeLabel.frame = CGRectZero;
                
                stateImageView.frame = CGRectZero;
                indicatorView.frame = CGRectMake(100.f, (frame.size.height - 20.f) / 2,
                                                 20.f, 20.f);
            }
                break;
            default:
                break;
        }
        
        //默认状态
        [self setState:JDRefreshViewStateDragToRefresh];

    }
    
    return self;

}

#pragma mark - 设置刷新时间
- (void)setUpdateDate:(NSDate*)newDate {
    if (newDate)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        timeLabel.text = [NSString stringWithFormat:@"%@%@", @"更新于:", [formatter stringFromDate:newDate]];
    }
    else
    {
        timeLabel.text = @"从未更新";
    }
}

- (void)setCurrentDate
{
    [self setUpdateDate:[NSDate date]];
}

#pragma mark - 设置状态文本
- (void)setState:(JDRefreshViewState)newState
{
    state = newState;
    switch (newState)
    {
        case JDRefreshViewStateDragToRefresh:
        {
            switch (refreshType)
            {
                case JDRefreshViewTypeHeader:
                    hintLabel.text = @"下拉可以刷新";
                    break;
                case JDRefreshViewTypeFooter:
                    hintLabel.text = @"上拉加载更多";
                    break;
            }
            
            [self changeStateImage:newState];
            [self switchImage:NO];
            [self setCurrentDate];
        }
            break;
            
        case JDRefreshViewStateLooseToRefresh:
        {
            switch (refreshType)
            {
                case JDRefreshViewTypeHeader:
                    hintLabel.text = @"松开立即更新";
                    break;
                case JDRefreshViewTypeFooter:
                    hintLabel.text = @"松开加载更多";
                    break;
            }
            
            [self changeStateImage:newState];
            [self switchImage:NO];
        }
            break;
            
        case JDRefreshViewStateRefreshing:
        {
            hintLabel.text = @"加载中...";
            [self changeStateImage:newState];
            [self switchImage:YES];
        }
    }
}

#pragma mark - 状态标识和加载菊花
- (void)changeStateImage:(JDRefreshViewState)changedState
{
    switch (changedState) {
        case JDRefreshViewStateDragToRefresh:
            stateImageView.image = [UIImage imageNamed:@"idlefish_begin"];
            break;
        case JDRefreshViewStateLooseToRefresh:
            stateImageView.image = [UIImage imageNamed:@"refresh_end"];
            break;
        case JDRefreshViewStateRefreshing:
            stateImageView.image = [UIImage imageNamed:@"idlefish_loading@2x"];
            break;
        default:
            break;
    }
}

- (void)switchImage:(BOOL)shouldShowIndicator
{
    if (shouldShowIndicator)
    {
        [indicatorView startAnimating];
        stateImageView.hidden = YES;
    }
    else
    {
        [indicatorView stopAnimating];
        stateImageView.hidden = NO;
    }
}


@end
