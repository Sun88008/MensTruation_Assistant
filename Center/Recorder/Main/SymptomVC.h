//
//  SymptomVC.h
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GetSymptomsValueDelegate <NSObject>

- (void)getSymptomsValue:(NSString *)symptomStr;

@end
@interface SymptomVC : UIViewController

@property(nonatomic,assign)id<GetSymptomsValueDelegate>delegate;
@end
