//
//  CHLCalendar.m
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import "CHLCalendar.h"
#import "NSCalendar+ST.h"
#import "CHLCalendarItem.h"
#import "Public.h"
#import "AlertLabel.h"

#define WidthCalendar  self.frame.size.width
#define HeightCalendar self.frame.size.height
#define ScreenWidth  CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

// 每周的天数
static NSInteger const DaysCount = 7;
static NSInteger const MonthCount = 6;

@interface CHLCalendar()
{
    NSInteger _predictNum;
    NSString *_selectedDate;
}

/** 1.开始的日期元件器 */
@property (nonatomic, strong, nullable)NSDateComponents *componentsBegin;
/** 2.结束的日期元件器 */
@property (nonatomic, strong, nullable)NSDateComponents *componentsEnd;
/** 3.已选择的日期元件器数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayCalendarSelected;

@end

@implementation CHLCalendar
/**
 *  1.初始化方法
 *
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //推测的月数
        _predictNum = 5;
        _selectedDate = @"";
        
        [self setupDefaultData];
        [self addGestureRecognizer];
        [self reloadData];
    }
    return self;
}

/**
 *  2.设置默认值
 */
- (void)setupDefaultData
{
    _year = [NSCalendar currentYear];
    _month = [NSCalendar currentMonth];
    _diameter = 34;
    _textNormalColor = safeColor;
    _textSelectedColor = RedColor;
    _backgroundNormalColor = [UIColor whiteColor];
    _backgroundSelectedColor = [UIColor whiteColor];
}

/**
 *  3.重载数据
 */
- (void)reloadData
{
    
    // 1.获取指定年月的第一天是周几和这个月的天数
    NSInteger firstWeekday = [NSCalendar getFirstWeekdayWithYear:self.year month:self.month];
    NSInteger daysMonth = [NSCalendar getDaysWithYear:self.year month:self.month];
//    NSLog(@"这个个月的天数：===%ld",daysMonth);
    
    // 2.移除子视图
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 3.设置子视图
//    CGFloat itemW = self.diameter;
    CGFloat itemW = (ScreenWidth-22)/7.0;
    CGFloat itemH = itemW;
    CGFloat widthRow = WidthCalendar / DaysCount;
    CGFloat heightRow = HeightCalendar / MonthCount;
    
    for (NSInteger i = firstWeekday-1; i < daysMonth + firstWeekday-1; i++) {
        
        NSString *stringDay = [NSString stringWithFormat:@"%ld", i - firstWeekday+2];
        
        CGFloat itemCenterX = (i % DaysCount + 0.5) * widthRow;
        CGFloat itemCenterY = (i / DaysCount + 0.5) * heightRow;
        CHLCalendarItem *calendarItem = [CHLCalendarItem calendarItemWithFrame:CGRectMake(0,
                                                                                        0,
                                                                                        itemW,
                                                                                        itemH)
                                                                       title:stringDay
                                                            colorNormalTitle:self.textNormalColor
                                                          colorSelectedTitle:RedColor
                                                                      center:CGPointMake(itemCenterX,
                                                                                         itemCenterY)];
        [calendarItem setBackgroundColor:self.backgroundNormalColor];
        [calendarItem setBackgroundImage:[self imageWithColor:WhiteColor] forState:UIControlStateNormal];
        [calendarItem setBackgroundImage:[self imageWithColor:yuceBackColor] forState:UIControlStateHighlighted];
        [calendarItem setBackgroundImage:[self imageWithColor:yuceBackColor] forState:UIControlStateSelected];
        calendarItem.layer.masksToBounds = YES;
        [calendarItem.layer setCornerRadius:self.diameter/4];
        [calendarItem addTarget:self
                         action:@selector(selectedDay:)
               forControlEvents:UIControlEventTouchUpInside];
        
        //日期格式
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy年M月d日"];
        
        //获取周期详情
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *newDayStr = [userDefault objectForKey:@"day"];
        NSString *newMonthStr = [userDefault objectForKey:@"month"];
        NSString *newDateStr = [userDefault objectForKey:@"date"];
        //周期---月经周期
        NSInteger circleNum = [newMonthStr integerValue];
        //周期---月经天数
        NSInteger dayNum = [newDayStr integerValue];
        //周期---上次月经日期
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd"];
        NSDate *fromdate = [format dateFromString:newDateStr];
        
        
        NSString *dateTime = [formatter stringFromDate:[NSDate date]];
        NSString *todayStr = [NSString stringWithFormat:@"%ld年%ld月%ld日",self.year,self.month,stringDay.integerValue];
        
        //********************* 月经周期记录 ******************
        
        for (NSInteger m = 0; m<circleNum*_predictNum; m=m+circleNum) {
            
            //月经期、预测期
            NSUInteger flags = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
            NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
            
            for (NSInteger i = 0; i<dayNum; i++) {
                NSDateComponents *compos = [calendar components:flags fromDate:fromdate];
                [compos setDay:([compos day]+i)];
                NSDate *beginningOfWeek = [calendar dateFromComponents:compos];
                NSString *str = [formatter stringFromDate:beginningOfWeek];
                if ([str isEqualToString:todayStr]) {
                    [calendarItem setTitleColor:NormalColor forState:UIControlStateNormal];
                }
            }
            //************ 排卵日 ************
            NSDateComponents *compos = [calendar components:flags fromDate:fromdate];
            [compos setDay:([compos day]-14)];
            NSDate *beginningOfWeek = [calendar dateFromComponents:compos];
            NSString *ovulateStr = [formatter stringFromDate:beginningOfWeek];
            if ([ovulateStr isEqualToString:todayStr]) {
                [calendarItem setTitleColor:pailuanColor forState:UIControlStateNormal];
                
                UIImageView *ovulateImageView = [[UIImageView alloc]initWithFrame:CGRectMake(itemW/3.0*2, itemH/4.0*3, itemW/4.0, itemW/4.0)];
                ovulateImageView.image = [[UIImage imageNamed:@"shixing"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                ovulateImageView.backgroundColor = [UIColor clearColor];
                [calendarItem addSubview:ovulateImageView];
            }
            //************ 易孕期 ************
            //排卵期前五天 后四天
            for (NSInteger i = 0; i<10; i++) {
                NSDateComponents *compos = [calendar components:flags fromDate:fromdate];
                [compos setDay:([compos day]-19+i)];
                NSDate *beginningOfWeek = [calendar dateFromComponents:compos];
                NSString *ovulateStr = [formatter stringFromDate:beginningOfWeek];
                if ([ovulateStr isEqualToString:todayStr]) {
                    [calendarItem setTitleColor:yiyunColor forState:UIControlStateNormal];
                }
            }
            
            NSDateComponents *compo = [calendar components:flags fromDate:fromdate];
            [compo setDay:([compo day]+circleNum)];
            fromdate = [calendar dateFromComponents:compo];
        }
        
        //********************* 月经周期记录 ******************
        
        //当前日期 今天
        if ([dateTime isEqualToString:todayStr]) {
//            calendarItem.layer.borderWidth = 0.5;
//            calendarItem.layer.borderColor = [UIColor redColor].CGColor;
            
            UILabel *todayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, itemH/4.0*3, itemW/3.0*2, itemW/4.0)];
            todayLabel.text = @"今天";
            todayLabel.font = [UIFont systemFontOfSize:10];
            todayLabel.textAlignment = 1;
            todayLabel.textColor = calendarItem.titleLabel.textColor;
            [calendarItem addSubview:todayLabel];
        }

        //选中的时候
        [self.arrayCalendarSelected enumerateObjectsUsingBlock:^(NSDateComponents *obj,
                                                                 NSUInteger idx,
                                                                 BOOL * _Nonnull stop) {
            NSDateComponents *dateComponents = obj;
            if (dateComponents.year == self.year &&
                dateComponents.month == self.month &&
                dateComponents.day == stringDay.integerValue) {
                [calendarItem setSelected:YES];
                calendarItem.backgroundColor = yuceBackColor;
            }
        }];
        
        //选中的日期
        if ([_selectedDate isEqualToString:todayStr]) {
            calendarItem.selected = YES;
        }
        
        [self addSubview:calendarItem];
    }
    
    NSString *stringDate;
    if (self.month<10) {
        stringDate = [NSString stringWithFormat:@"%ld年0%ld月", self.year, self.month];
    }else{
        stringDate = [NSString stringWithFormat:@"%ld年%ld月", self.year, self.month];
    }
    
    if (self.block) {
        self.block(stringDate);
    }
    
    [self setResultStyle];
}

/**
 *  设置按钮背景颜色
 */
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGFloat imageW = (ScreenWidth-22)/7.0;
    CGFloat imageH = imageW;
    
    // 1.开启基于位图的图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    // 2.画一个color颜色的矩形框
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    
    // 3.拿到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}


/**
 *  设置返回数据的样式
 */
- (void)setResultStyle
{
    NSString *beginDate = @"";
    if (self.componentsBegin.year > 0) {
        beginDate = [NSString stringWithFormat:@"%ld年%ld月%ld日", self.componentsBegin.year, self.componentsBegin.month, self.componentsBegin.day];
    }
    
    NSString *endDate = @"";
    if (self.componentsEnd.year > 0) {
        endDate = [NSString stringWithFormat:@" - %ld年%ld月%ld日", self.componentsEnd.year, self.componentsEnd.month, self.componentsEnd.day];
    }
    
    [self.delegate calendarResultWithBeginDate:beginDate
                                       endDate:endDate];
}

- (void)returnDate:(ReturnDateBlock)block
{
    self.block = block;
}
/**
 *  4.日期的点击事件
 */
- (void)selectedDay:(CHLCalendarItem *)calendarItem
{
//    [calendarItem setSelected:!calendarItem.selected];
    
    NSString *day = calendarItem.titleLabel.text;
//    NSString *stringSeleted = [NSString stringWithFormat:@"%ld-%ld-%@", (long)self.year, (long)self.month, day];
//    NSDateComponents *components = [NSCalendar dateComponentsWithString:stringSeleted];
    
    _selectedDate = [NSString stringWithFormat:@"%ld年%ld月%@日", (long)self.year, (long)self.month, day];
    
    //如果按钮被选中
    if (calendarItem.selected) {
//        [self addSelectedDataWithComponents:components];
        NSLog(@"又点击了一遍被选中的按钮");
    }else {
//        [self subtractSelectedDataWithComponents:components];
        
        //如果按钮没有被选中
        for (CHLCalendarItem *item in self.subviews) {
            if (item.selected == YES) {
                item.selected = NO;
            }
        }
        calendarItem.selected = YES;
    }
    
//    NSLog(@"%@",stringSeleted);
    
    [self reloadData];
}

/**
 *  下面两个逻辑方法，需要加上描述，逻辑太费劲了，累死宝宝了
 */
- (void)addSelectedDataWithComponents:(NSDateComponents *)components
{
    
    if (!self.componentsBegin.year) {
        self.componentsBegin = components;
    }else if (self.componentsBegin.year && !self.componentsEnd.year) {
        if ([NSCalendar compareWithComponentsOne:components
                                   componentsTwo:self.componentsBegin] == NSOrderedAscending) {
            NSDateComponents *componentsChanger = self.componentsBegin;
            self.componentsEnd = componentsChanger;
            self.componentsBegin = components;
        } else {
            self.componentsEnd = components;
        }
    }else {
        if ([NSCalendar compareWithComponentsOne:self.componentsBegin
                                   componentsTwo:self.componentsEnd] == NSOrderedDescending) {
            NSDateComponents *components = self.componentsEnd;
            self.componentsEnd = self.componentsBegin;
            self.componentsBegin = components;
        }
        
        
        if ([NSCalendar compareWithComponentsOne:components
                                   componentsTwo:self.componentsBegin] == NSOrderedAscending) {
            self.componentsBegin = components;
        } else {
            self.componentsEnd = components;
        }
    }
    
    [self.arrayCalendarSelected removeAllObjects];
    
    if (!self.componentsEnd.year) {
        [self.arrayCalendarSelected addObject:self.componentsBegin];
    } else {
        self.arrayCalendarSelected =  [NSCalendar arrayComponentsWithComponentsOne:self.componentsBegin
                                                                     componentsTwo:self.componentsEnd];
    }
    
    [self reloadData];
}

- (void)subtractSelectedDataWithComponents:(NSDateComponents *)components
{
    [self.arrayCalendarSelected removeAllObjects];
    
    if ([NSCalendar compareWithComponentsOne:components
                               componentsTwo:self.componentsBegin] == NSOrderedSame) {
        self.componentsBegin = self.componentsEnd;
        self.componentsEnd = nil;
    }
    
    if ([NSCalendar compareWithComponentsOne:components
                               componentsTwo:self.componentsEnd] == NSOrderedSame) {
        self.componentsEnd = nil;
    }
    
    if (!self.componentsEnd.year && self.componentsBegin.year) {
        [self.arrayCalendarSelected addObject:self.componentsBegin];
    }
    
    
    if ([NSCalendar compareWithComponentsOne:components
                               componentsTwo:self.componentsBegin] == NSOrderedDescending &&
        [NSCalendar compareWithComponentsOne:components
                               componentsTwo:self.componentsEnd] == NSOrderedAscending) {
        self.componentsEnd = components;
        self.arrayCalendarSelected =  [NSCalendar arrayComponentsWithComponentsOne:self.componentsBegin
                                                                     componentsTwo:self.componentsEnd];
    }
    
    [self reloadData];
}

/**
 *  5.添加手势
 */
- (void)addGestureRecognizer
{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(swipeView:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(swipeView:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight ];
    [self addGestureRecognizer:swipeRight];
}

/**
 *  6.手势的点击事件
 */
//向左滑 下一个月  向右划 上一个月
- (void)swipeView:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        ++self.month;
        _predictNum ++;
    } else {
       --self.month;
    }
}

/**
 *  7.数据的Set方法
 */
- (void)setMonth:(NSInteger)month
{
    if (month > 12) {
        ++self.year;
        month = 1;
    }
    
    if (month < 1) {
        --self.year;
        month = 12;
    }    
    _month = month;
    
    [self reloadData];
}

- (void)setYear:(NSInteger)year
{
    _year = year;
}

- (NSMutableArray *)arrayCalendarSelected
{
    if (!_arrayCalendarSelected) {
        _arrayCalendarSelected = [NSMutableArray array];
    }
    return _arrayCalendarSelected;
}
@end
