//
//  AlertLabel.h
//  CHLCalendar
//
//  Created by luomin on 16/3/1.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertLabel : UILabel
/**
 *  显示提示Label
 *  要显示的提示文字内容
 */

+ (void)hudShowText:(NSString *)message;
/**
 * 要显示的提示文字内容
 */
- (void)hudShowText:(NSString *)message;

@end
