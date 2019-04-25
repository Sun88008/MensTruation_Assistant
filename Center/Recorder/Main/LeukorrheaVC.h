//
//  LeukorrheaVC.h
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GetLeukorrheaValueDelegate <NSObject>

- (void)getLeukorrheaValue:(NSString *)string;

@end

@interface LeukorrheaVC : UIViewController

@property(nonatomic,assign)id<GetLeukorrheaValueDelegate>delegate;
@end
