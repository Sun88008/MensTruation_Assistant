//
//  TextPaperCell.h
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextPaperCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *textImgView;
@property (weak, nonatomic) IBOutlet UILabel *textTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *textValueLabel;
@end
