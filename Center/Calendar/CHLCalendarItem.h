//
//  CHLCalendarItem.h
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  1.这个类型的继承最好是UIView,可以对日历单元定制
 */
@interface CHLCalendarItem : UIButton
+ (instancetype)calendarItemWithFrame:(CGRect)frame
                                title:(NSString *)title
                     colorNormalTitle:(UIColor *)colorNormalTitle
                   colorSelectedTitle:(UIColor *)colorSelectedTitle
                               center:(CGPoint)center;
@end
