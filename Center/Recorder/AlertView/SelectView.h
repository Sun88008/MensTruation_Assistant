//
//  SelectView.h
//  CHLCalendar
//
//  Created by luomin on 16/3/1.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectView : UIView
{
    UILabel *_labelTitle;
    UILabel *_labelmessage;
    
    NSString *_title;
    NSString *_message;
}

@property(nonatomic,strong)UIView *coverView;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;
- (void)show;
- (void)dismiss;
@end
