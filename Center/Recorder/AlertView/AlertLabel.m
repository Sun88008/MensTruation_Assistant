//
//  AlertLabel.m
//  CHLCalendar
//
//  Created by luomin on 16/3/1.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import "AlertLabel.h"
#import "Public.h"
#import "AlertLabel.h"

//  快速生成颜色
#define CustomColor(r , g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0  blue:(b)/255.0  alpha:(a)/1.0 ]

@implementation AlertLabel

+ (void)hudShowText:(NSString *)message
{
    AlertLabel *tempLabel = [[AlertLabel alloc] init];
    
    [tempLabel hudShowText:message];
}

- (void)hudShowText:(NSString *)message
{
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    
    self.text = message;
    self.numberOfLines = 0;
    self.textAlignment = NSTextAlignmentCenter;
    self.backgroundColor = CustomColor(0, 0, 0, 1.0);//黑色
    self.textColor = [UIColor whiteColor];
    self.alpha = 0.7;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    //  设置宽高限制
    CGSize sizesize = CGSizeMake(__kScreenWidth - 2 * 50, MAXFLOAT);
    //  用文字计算出Size
    CGSize sizeTop = [self stringWithSizeLine:self.text font:self.font size:sizesize];
    //  设置frame
    self.frame = CGRectMake(0, 0, sizeTop.width+15, sizeTop.height+15);
    self.center = CGPointMake(__kScreenWidth *0.5, __kScreenHeight * 0.5);
    //  动画
    [UIView animateWithDuration:0.7 animations:^{
        self.alpha = 0.7;
        [mainWindow addSubview:self];
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.7 animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        });
        
    }];
}

-(CGSize )stringWithSizeLine:(NSString *)str font:(UIFont *)font size:(CGSize)size
{
    NSMutableDictionary * Att= [NSMutableDictionary dictionary];
    Att[NSFontAttributeName] = font;
    return  [str boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:Att context:nil].size;
}

@end
