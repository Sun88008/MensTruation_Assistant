//
//  CHLCalendarItem.m
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import "CHLCalendarItem.h"

@implementation CHLCalendarItem

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
             colorNormalTitle:(UIColor *)colorNormalTitle
           colorSelectedTitle:(UIColor *)colorSelectedTitle
                       center:(CGPoint)center
{
    CHLCalendarItem *calendarItem = [[CHLCalendarItem alloc]initWithFrame:frame];
    [calendarItem setTitle:title forState:UIControlStateNormal];
    [calendarItem setTitleColor:colorNormalTitle forState:UIControlStateNormal];
    [calendarItem setTitleColor:colorSelectedTitle forState:UIControlStateSelected];
    [calendarItem setCenter:center];
    return calendarItem;
}

+ (instancetype)calendarItemWithFrame:(CGRect)frame
                                title:(NSString *)title
                     colorNormalTitle:(UIColor *)colorNormalTitle
                   colorSelectedTitle:(UIColor *)colorSelectedTitle
                               center:(CGPoint)center {
    return [[CHLCalendarItem alloc]initWithFrame:frame
                                          title:title
                               colorNormalTitle:colorNormalTitle
                             colorSelectedTitle:(UIColor *)colorSelectedTitle
                                         center:center];
}
@end
