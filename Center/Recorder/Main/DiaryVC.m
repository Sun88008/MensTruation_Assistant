//
//  DiaryVC.m
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import "DiaryVC.h"
#import "Public.h"
#import "AlertLabel.h"

@interface DiaryVC ()<UITextViewDelegate>
{
    UILabel *_placeholderLabel;
    UITextView *_diaryTextView;
    NSString *_diaryStr;
}
@end

@implementation DiaryVC

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackgroundColor;
    [self createNavView];
    [self createTopDateView];
    [self createDiaryUI];
}

#pragma mark ============== 创建导航栏项
- (void)createNavView
{
    //导航栏
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth, 64)];
    navView.backgroundColor = RedColor;
    [self.view addSubview:navView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x-50, 20, 100, 44)];
    titleLabel.text = @"好孕日记";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [navView addSubview:titleLabel];
    
    //返回按钮
    UIImage *imageback = [[UIImage imageNamed:@"iconfont-arrow-left-copy"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 32, 20, 20);
    [button setImage:imageback forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backToSuper) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:button];
    
    //保存按钮
    UIButton *inverseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    inverseBtn.frame = CGRectMake(__kScreenWidth-55, 32, 40, 20);
    inverseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [inverseBtn setTitle:@"保存" forState:UIControlStateNormal];
    [inverseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [inverseBtn addTarget:self action:@selector(saveDiaryBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:inverseBtn];
}

//返回
- (void)backToSuper
{
    [self.navigationController popViewControllerAnimated:YES];
}

//保存按钮
- (void)saveDiaryBtnClick
{
    [_diaryTextView resignFirstResponder];
    if (_diaryStr.length == 0) {
        [AlertLabel hudShowText:@"请输入内容"];
        return;
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"edit" object:self userInfo:@{@"edit":@"已填写"}];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark ====================== 导航栏下显示日期的View
- (void)createTopDateView
{
    //背景图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth, __kScreenHeight-64)];
    imageView.image = [[UIImage imageNamed:@"pinkBackground"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.view addSubview:imageView];
    
    //当前日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM月dd日"];
    NSString *dateTimeStr = [formatter stringFromDate:[NSDate date]];
    
    //显示日期的view
    UIView *dateView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth, 50)];
    dateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dateView];
    //日期label
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 105, 50)];
    dateLabel.text = dateTimeStr;
    dateLabel.font = [UIFont systemFontOfSize:23];
    dateLabel.textColor = RedColor;
    dateLabel.backgroundColor = [UIColor clearColor];
    [dateView addSubview:dateLabel];
    //星期
    UILabel *weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 5, 100, 20)];
    weekLabel.text = [self convertDateToWeek];
    weekLabel.font = [UIFont systemFontOfSize:14];
    weekLabel.textColor = RedColor;
    weekLabel.backgroundColor = [UIColor clearColor];
    [dateView addSubview:weekLabel];
    //农历
    UILabel *chineseCalendarLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 25, 100, 20)];
    chineseCalendarLabel.text = [self convertDateToNongli];
    chineseCalendarLabel.font = [UIFont systemFontOfSize:14];
    chineseCalendarLabel.textColor = [UIColor grayColor];
    chineseCalendarLabel.backgroundColor = [UIColor clearColor];
    [dateView addSubview:chineseCalendarLabel];
    
    //提示语
    _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, __kScreenHeight/2.0-20, __kScreenWidth, 40)];
    _placeholderLabel.text = @"写下今天的心情，记录一段回忆......";
    _placeholderLabel.textAlignment = 1;
    _placeholderLabel.textColor = PinkColor;
    _placeholderLabel.alpha = 0.6;
    _placeholderLabel.font = [UIFont systemFontOfSize:15];
    _placeholderLabel.hidden = NO;
    _placeholderLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_placeholderLabel];

}

#pragma mark ====================== 创建日记文本
- (void)createDiaryUI
{
    _diaryTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 120, __kScreenWidth-20, __kScreenHeight/2.0)];
    _diaryTextView.tintColor = RedColor;
    _diaryTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _diaryTextView.delegate = self;
    _diaryTextView.bounces = NO;
    _diaryTextView.scrollEnabled = NO;
    _diaryTextView.showsVerticalScrollIndicator = NO;
    _diaryTextView.font = [UIFont systemFontOfSize:17];
    _diaryTextView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_diaryTextView];
}

#pragma mark ==================== 日期阳历转换为农历
- (NSString *)convertDateToNongli
{
    NSDate *dateTemp = [NSDate date];
    NSDateFormatter *chineseDateFormater = [[NSDateFormatter alloc]init];
    [chineseDateFormater setDateFormat:@"yyyy-MM-dd"];
    NSCalendar* calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSChineseCalendar];
    NSDateComponents* components = [calendar components:NSMonthCalendarUnit|NSDayCalendarUnit fromDate:dateTemp];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    numberFormatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    NSString *monthString = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:components.month]];
    NSString *dayString = [numberFormatter stringFromNumber:[NSNumber numberWithInteger:components.day]];
    NSString *nongliStr = [NSString stringWithFormat:@"农历%@月%@",monthString,dayString];
    
    return nongliStr;
}

#pragma mark ==================== 星期几
- (NSString *)convertDateToWeek
{
    NSArray *weekArr = [NSArray arrayWithObjects:[NSNull null],@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    NSInteger comps = [calendar component:calendarUnit fromDate:date];
    NSString *weekDay = [weekArr objectAtIndex:comps];
    
    return weekDay;
}

#pragma mark ============== textView代理方法
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _placeholderLabel.hidden = YES;
}

//编辑内容发生改变的时候
- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"%@",textView.text);
    _diaryStr = textView.text;
}
@end
