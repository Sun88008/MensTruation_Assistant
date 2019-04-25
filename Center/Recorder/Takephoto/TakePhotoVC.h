//
//  TakePhotoVC.h
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol RACustomCameraControllerDelegate <NSObject>

@optional
- (void)photoCapViewController:(UIViewController *)viewController didFinishDismissWithImage:(UIImage *)image;

@end

@interface TakePhotoVC : UIViewController

@property(nonatomic,weak)id<RACustomCameraControllerDelegate> delegate;

@end
