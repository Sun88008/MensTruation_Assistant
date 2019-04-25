//
//  TextResultVC.h
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GetTextResultDelegate <NSObject>

- (void)getTextResultWithImage:(UIImage *)image andTime:(NSString *)time andValue:(NSString *)value;

@end

@interface TextResultVC : UIViewController

@property(nonatomic,strong)UIImage *resultImage;

@property(nonatomic,assign)id<GetTextResultDelegate>delegate;

@end
