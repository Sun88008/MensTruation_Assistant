//
//  HCGResultVC.h
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GetHCGResultDelegate <NSObject>

- (void)getHCGResultWithImage:(UIImage *)image andTime:(NSString *)time andValue:(NSString *)value;

@end

@interface HCGResultVC : UIViewController

@property(nonatomic,strong)UIImage *resultImage;

@property(nonatomic,assign)id<GetHCGResultDelegate>delegate;

@end
