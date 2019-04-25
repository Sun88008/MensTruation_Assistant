//
//  TextPaperCell.m
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import "TextPaperCell.h"
#import "Public.h"
#import "AlertLabel.h"
@implementation TextPaperCell

- (void)awakeFromNib {
    self.textView.frame = CGRectMake(10, 10, __kScreenWidth-20, 100);
    self.textImgView.frame = CGRectMake(0, 0, __kScreenWidth-20, 80);
    self.textTimeLabel.frame = CGRectMake(10, 80, 200, 20);
    self.textValueLabel.frame = CGRectMake(__kScreenWidth-80, 80, 50, 20);
    
    self.textImgView.layer.masksToBounds = YES;
    self.textImgView.layer.cornerRadius = 5.0;
    
    self.textTimeLabel.textColor = [UIColor grayColor];
    self.textValueLabel.textColor = RedColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
