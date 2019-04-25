//
//  SelectView.m
//  CHLCalendar
//
//  Created by luomin on 16/3/1.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import "SelectView.h"
#import "Public.h"
#import "AlertLabel.h"
@implementation SelectView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message{
    self = [super init];
    if (self) {
        _title = title;
        _message = message;
        [self buildViews];
    }
    return self;
}

-(void)buildViews{
    self.frame = CGRectMake(20, __kScreenHeight/2.0-160, __kScreenWidth-40, 320);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 15.0;
    
    self.coverView = [[UIView alloc]initWithFrame:[self topView].bounds];
    self.coverView.backgroundColor = [UIColor blackColor];
    self.coverView.alpha = 0;
    self.coverView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [[self topView] addSubview:self.coverView];
    
    //title
    _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, __kScreenWidth-120, 30)];
    _labelTitle.font = [UIFont boldSystemFontOfSize:20];
    _labelTitle.textColor = [UIColor blackColor];
//    _labelTitle.backgroundColor = [UIColor yellowColor];
    _labelTitle.textAlignment = 1;
    _labelTitle.numberOfLines = 0;
    _labelTitle.text = _title;
    _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:_labelTitle];
    
    //message
    _labelmessage = [[UILabel alloc]initWithFrame:CGRectMake(40, 40, __kScreenWidth-120, 30)];
    _labelmessage.font = [UIFont systemFontOfSize:14];
    _labelmessage.textColor = [UIColor lightGrayColor];
    _labelmessage.textAlignment = 1;
    _labelmessage.text = _message;
    _labelmessage.numberOfLines = 0;
//    _labelmessage.backgroundColor = [UIColor orangeColor];
    _labelmessage.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:_labelmessage];
    
    //关闭按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(40+__kScreenWidth-120+10, 5, 25, 25);
    button.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 12.5;
    [button setImage:[UIImage imageNamed:@"iconfontcha"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

#pragma mark ============ show and dismiss

-(UIView *)topView{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return  window.subviews[0];
}

#pragma mark ============ 展示
- (void)show {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.alpha = 0.4;
    } completion:nil];
    
    [[self topView] addSubview:self];
    [self showAnimation];
}

#pragma mark ============ 消失
- (void)dismiss {
    [self hideAnimation];
}

#pragma mark ============ 呈现动画
- (void)showAnimation {
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.layer addAnimation:popAnimation forKey:nil];
}

#pragma mark ============ 隐藏动画
- (void)hideAnimation{
    
    [UIView animateWithDuration:0.4 animations:^{
        self.coverView.alpha = 0.0;
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
