//
//  CHLCalendar.h
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CHLCalendarDelegate <NSObject>

- (void)calendarResultWithBeginDate:(NSString *_Nullable)beginDate
                            endDate:(NSString *_Nullable)endDate;

@end

typedef void(^ReturnDateBlock)(NSString *_Nullable stringDate);

@interface CHLCalendar : UIView

// 1.年数
@property (nonatomic, assign)NSInteger year;
// 2.月数
@property (nonatomic, assign)NSInteger month;
// 3.日期直径,默认 34
@property (nonatomic) NSInteger diameter;
// 4.字体的普通色,默认 [UIColor lightGrayColor]
@property (nonatomic, strong, nullable) UIColor *textNormalColor;
// 5.字体的选中色,默认 [UIColor redColor]
@property (nonatomic, strong, nullable) UIColor *textSelectedColor;
// 6.背景的普通色,默认 [UIColor whiteColor]
@property (nonatomic, strong, nullable) UIColor *backgroundNormalColor;
// 7.背景的选中色,默认 [UIColor orangeColor]
@property (nonatomic, strong, nullable) UIColor *backgroundSelectedColor;
// 8.返回选择的日期
@property ( nonatomic, weak, nullable) id <CHLCalendarDelegate>delegate;
// 9.返回现在界面的日期,如2015年12月
@property (nonatomic, copy, nullable)ReturnDateBlock block; 
- (void)returnDate:(ReturnDateBlock _Nullable)block;
@end
