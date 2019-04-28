//
//  RecorderVC.m
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import "RecorderVC.h"
#import "CHLCalendar.h"
#import "NSCalendar+ST.h"
#import "LeukorrheaVC.h"
#import "SymptomVC.h"
#import "TextPaperVC.h"
#import "HCGPaperVC.h"
#import "DiaryVC.h"
#import "Public.h"
#import "AlertLabel.h"

@interface RecorderVC ()<CHLCalendarDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,GetLeukorrheaValueDelegate,GetSymptomsValueDelegate>
{
    UITableView *_tableView;
    UIView *_selectView;
    //pickerView数组
    NSArray *_dataArray1;
    //列数
    int _listNum;
    //pickerView标识
    NSString *_identifier;
    //大姨妈来了
    BOOL _monthComing;
    //手势方向
    BOOL _isUp;
    //tableView高度状态
    BOOL _isHigh;
    //弹出选择器时的背景按钮
    UIButton *_backgroundBtn;
    //选择器
    UIPickerView *_pickerView;
    //选择器标题
    UILabel *_titlelabel;
    //选择器说明
    UILabel *_declarelabel;
    
    //点击控件的tag
    NSInteger _selectTag;
    NSString *_zeroStr;
    NSString *_oneStr;
    NSString *_selectStr;
}
@property (nonatomic, weak, nullable)CHLCalendar *calender; //
@property (nonatomic, weak, nullable)UILabel *labelDate; //
@property (nonatomic, weak, nullable)UILabel *labelResult; //

@property ( nonatomic, weak, nullable) UIButton *buttonNext; //
@property ( nonatomic, weak, nullable) UIButton *buttonUp; //
@property ( nonatomic, weak, nullable) UIButton *buttonCurrent; //
@end

@implementation RecorderVC

//隐藏导航栏
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
//    UIViewController *root = [[UIViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:root];
//    self.window.rootViewController = nav;
    
    RecorderVC *root = [[RecorderVC alloc]init];
    UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:root];
//    [self.navigationController presentViewController:navi animated:YES completion:nil];
    
    [super viewDidLoad];
    
    _dataArray1 = [[NSMutableArray alloc]init];
    
    _monthComing = NO;
    _isUp = NO;
    _isHigh = NO;
    
    [self createNavBar];
    [self createCalender];
    [self createWeek];
    [self declareColorMeaning];
    [self createPickerView];
    [self diaryEdit];
    
    self.view.backgroundColor = BackgroundColor;
}

//创建日历
- (void)createCalender
{
    self.labelDate.text = [self getCurrentTime];
    self.labelDate.textColor = [UIColor whiteColor];
    
    CHLCalendar *calender = [[CHLCalendar alloc]initWithFrame:CGRectMake(5,85,(__kScreenWidth-10),(__kScreenWidth-22)/7.0*6.0+14)];
    calender.backgroundColor = NormalColor;
    [calender returnDate:^(NSString * _Nullable stringDate) {
        self.labelDate.text = stringDate;
//        NSLog(@"返回现在界面的日期+++++++%@",stringDate);
    }];
    calender.delegate = self;
    [calender setTextSelectedColor:RedColor];
    [self.view addSubview:calender];
    self.calender = calender;
}

//获取当前年月
- (NSString *)getCurrentTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

//创建导航栏
- (void)createNavBar
{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth, 64)];
    navView.backgroundColor = RedColor;
    [self.view addSubview:navView];
    
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x-50, 20, 100, 44)];
    [dateLabel setTextAlignment:NSTextAlignmentCenter];
    [navView addSubview:dateLabel];
    self.labelDate = dateLabel;
    
//    //按钮 返回
//    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backbtn.frame = CGRectMake(10, 32, 40, 20);
//    [backbtn setTitle:@"返回" forState:UIControlStateNormal];
//    backbtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [backbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [backbtn addTarget:self action:@selector(backback) forControlEvents:UIControlEventTouchUpInside];
//    [navView addSubview:backbtn];
    
    //按钮 当前月
    UIButton *buttonCurrent = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCurrent.frame = CGRectMake(__kScreenWidth-50, 32, 40, 20);
    [buttonCurrent setTitle:@"今天" forState:UIControlStateNormal];
    buttonCurrent.titleLabel.font = [UIFont systemFontOfSize:15];
    [buttonCurrent setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonCurrent addTarget:self action:@selector(currentMonth:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:buttonCurrent];
    
    
    //按钮 上个月 下个月
    UIImage *imageLeft = [[UIImage imageNamed:@"iconfont-arrow-left-copy"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imageRight = [[UIImage imageNamed:@"iconfont-jiantou"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSArray *imageArray = @[imageLeft,imageRight];
    for (int i = 0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((self.view.center.x-70)+120*i, 32, 20, 20);
        button.tag = i+1;
        [button setImage:imageArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeMonth:) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:button];
    }
}

//点击button 上个月 下个月
- (void)changeMonth:(UIButton *)sender
{
    if (sender.tag == 1) {
        //上个月
        --self.calender.month;
    }else{
        //下个月
        ++self.calender.month;
    }
}

////返回
//- (void)backback
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)createWeek
{
    UIView *dateView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth, 20)];
    dateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dateView];
    NSArray *dateArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (int i = 0; i<7; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(__kScreenWidth/7.0*i, 0, __kScreenWidth/7.0, 20)];
        label.text = dateArray[i];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.font = [UIFont systemFontOfSize:14];
        if (i == 0||i==6) {
            label.textColor = RedColor;
        }else{
            label.textColor = [UIColor grayColor];
        }
        [dateView addSubview:label];
    }
}

//颜色说明
- (void)declareColorMeaning
{
    //头部视图
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth, 80)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    //颜色说明的View
    UIView *declareView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth, 30)];
    declareView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:declareView];
    
    //大姨妈来了？
    UIView *monthView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, __kScreenWidth, 50)];
    headerView.backgroundColor = [UIColor colorWithRed:242/255.0 green:240/255.0 blue:236/255.0 alpha:1.0];
    [headerView addSubview:monthView];
    //图标
    UIImageView *monthImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 7.5, 35, 35)];
    monthImageView.image = [[UIImage imageNamed:@"iconfont-kaishi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [monthView addSubview:monthImageView];
    //说明
    UILabel *monthLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 90, 30)];
    monthLabel.text = @"大姨妈来了";
    [monthView addSubview:monthLabel];
    //开关
    UISwitch *myswitch = [[UISwitch alloc]init];
    myswitch.frame = CGRectMake(__kScreenWidth-60, 10, 50, 20);
    myswitch.onTintColor = [UIColor colorWithRed:252/255.0 green:94/255.0 blue:118/255.0 alpha:1];
    if (_monthComing == YES) {
        [myswitch setOn:YES animated:YES];
    }else{
        [myswitch setOn:NO animated:YES];
    }
    myswitch.tintColor = NormalColor;
    [myswitch addTarget:self action:@selector(mySwitchChange:) forControlEvents:UIControlEventValueChanged];
    [monthView addSubview:myswitch];
    //分割线
    UILabel *linelabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 79, __kScreenWidth-70, 0.7)];
    linelabel.backgroundColor = [UIColor colorWithRed:232/255.0 green:226/255.0 blue:222/255.0 alpha:1.0];
    [headerView addSubview:linelabel];
    
    //向下箭头
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(__kScreenWidth/2.0-17.5, 25, 35, 20);
    UIImage *jiantou = [[UIImage imageNamed:@"iconfont-xiangxia"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn addTarget:self action:@selector(btnClickTochangeTableHeight:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:jiantou forState:UIControlStateNormal];
    [headerView addSubview:btn];
    
    
    //tableView
    CGFloat tableViewY = 85+(__kScreenWidth-22)/7.0*6.0+14;
    CGFloat tableViewH = self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - tableViewY;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 85+(__kScreenWidth-22)/7.0*6.0+14, __kScreenWidth, 640) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.backgroundColor = BackgroundColor;
    _tableView.separatorColor = SeparateColor;
    _tableView.tableHeaderView = headerView;
    [self.view addSubview:_tableView];
    
    //添加上划手势
    UISwipeGestureRecognizer *upGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(changeTableHeight:)];
    [upGesture setDirection:UISwipeGestureRecognizerDirectionUp];
    [_tableView addGestureRecognizer:upGesture];
    //添加下划手势
    UISwipeGestureRecognizer *downGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(changeTableHeight:)];
    [downGesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [_tableView addGestureRecognizer:downGesture];
    
    NSArray *colorArray = @[RedColor,NormalColor,safeColor,yiyunColor,pailuanColor];
    NSArray *declareArray = @[@"月经期",@"预测期",@"安全期",@"易孕期",@"排卵日"];
    
    for (int i = 0; i<5; i++) {
        UIImageView *colorImageView = [[UIImageView alloc]initWithFrame:CGRectMake((__kScreenWidth-285)/6.0+(57+(__kScreenWidth-285)/6.0)*i, 10, 10, 10)];
        colorImageView.layer.masksToBounds = YES;
        colorImageView.layer.cornerRadius = 2.0;
        if (i == 4) {
            colorImageView.frame = CGRectMake((__kScreenWidth-285)/6.0+(57+(__kScreenWidth-285)/6.0)*i, 8, 14, 14);
            colorImageView.image = [[UIImage imageNamed:@"shixing"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            colorImageView.backgroundColor = [UIColor clearColor];
        }else{
            colorImageView.backgroundColor = colorArray[i];
        }
        [declareView addSubview:colorImageView];
        
        UILabel *declareLabel = [[UILabel alloc]initWithFrame:CGRectMake(colorImageView.frame.origin.x+12, 0, 45, 30)];
        declareLabel.font = [UIFont systemFontOfSize:14];
        declareLabel.text = declareArray[i];
        declareLabel.textColor = colorArray[i];
        declareLabel.textAlignment = 1;
        [declareView addSubview:declareLabel];
    }
}

#pragma mark ====================== 创建UIPickerView
- (void)createPickerView
{
    //弹出选择器时的背景按钮
    _backgroundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backgroundBtn.frame = CGRectMake(0, 0, __kScreenWidth, __kScreenHeight);
    [_backgroundBtn setBackgroundColor:[UIColor blackColor]];
    [_backgroundBtn addTarget:self action:@selector(backGroundBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _backgroundBtn.alpha = 0.5;
    _backgroundBtn.hidden = YES;
    [self.view addSubview:_backgroundBtn];
    
    //选择器的View
    _selectView = [[UIView alloc]initWithFrame:CGRectMake(0, __kScreenHeight, __kScreenWidth, (__kScreenHeight-64)/2.0)];
    _selectView.backgroundColor = [UIColor whiteColor];
    
    NSArray *title = @[@"清除",@"确定"];
    for (int i = 0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((__kScreenWidth-50)*i, 0, 50, 40);
        button.backgroundColor = LightPinkColor;
        [button setTitleColor:NormalColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        [button setTitle:title[i] forState:UIControlStateNormal];
        [_selectView addSubview:button];
    }
    //标题
    _titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, __kScreenWidth-100, 40)];
    _titlelabel.font = [UIFont systemFontOfSize:18];
    _titlelabel.textAlignment = 1;
    _titlelabel.backgroundColor = LightPinkColor;
    [_selectView addSubview:_titlelabel];
    //说明
    _declarelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, __kScreenWidth, 20)];
    _declarelabel.textAlignment = 1;
    _declarelabel.font = [UIFont systemFontOfSize:13];
    _declarelabel.textColor = [UIColor lightGrayColor];
    _declarelabel.backgroundColor = LightPinkColor;
    [_selectView addSubview:_declarelabel];
    
    //pickerView
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 60, __kScreenWidth, (__kScreenHeight-64)/2.0-60)];
    _pickerView.backgroundColor = [UIColor whiteColor];
    [_selectView addSubview:_pickerView];
    
    [self.view addSubview:_selectView];
}

#pragma mark ====================== 点击背景按钮，回收选择器
- (void)backGroundBtnClick
{
    _backgroundBtn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _selectView.frame = CGRectMake(0, __kScreenHeight, __kScreenWidth, (__kScreenHeight-64)/2.0);
    }];
}

#pragma mark ====================== 清除、确定
- (void)selectViewBtnClick:(UIButton *)sender
{
    _backgroundBtn.hidden = YES;
    if (sender.tag == 100) {
        NSLog(@"清除");
    }else{
        //确定
        if ([_selectStr isEqualToString:@"请选择"]) {
            [self changeButtonToMore];
        }else{
            [self changeButtonToEdit];
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        _selectView.frame = CGRectMake(0, __kScreenHeight, __kScreenWidth, (__kScreenHeight-64)/2.0);
    }];
}

#pragma mark ====================== 改变tableView的高度
//手势改变
- (void)changeTableHeight:(UISwipeGestureRecognizer *)gesture
{
    if (gesture.direction == UISwipeGestureRecognizerDirectionUp) {
        _isUp = YES;
        [UIView animateWithDuration:0.5 animations:^{
            _tableView.frame = CGRectMake(0, 85+(__kScreenWidth-22)/7.0+4, __kScreenWidth, __kScreenHeight-88-(__kScreenWidth-22)/7.0);
        }];
        _isHigh = YES;
    }else{
        _isUp = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _tableView.frame = CGRectMake(0, 85+(__kScreenWidth-22)/7.0*6.0+14, __kScreenWidth, __kScreenHeight-88-(__kScreenWidth-22)/7.0);
        }];
        _isHigh = NO;
    }
}
//点击按钮改变
- (void)btnClickTochangeTableHeight:(UIButton *)sender
{
    if (_isHigh == YES) {
        [UIView animateWithDuration:0.5 animations:^{
            _tableView.frame = CGRectMake(0, 85+(__kScreenWidth-22)/7.0*6.0+14, __kScreenWidth, __kScreenHeight-88-(__kScreenWidth-22)/7.0);
        }];
        _isHigh = NO;
        _isUp = NO;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _tableView.frame = CGRectMake(0, 85+(__kScreenWidth-22)/7.0+4, __kScreenWidth, __kScreenHeight-88-(__kScreenWidth-22)/7.0);
        }];
        _isHigh = YES;
        _isUp = YES;
    }
}

#pragma mark - Delegate 视图委托
- (void)calendarResultWithBeginDate:(NSString *)beginDate endDate:(NSString *)endDate
{
    self.labelResult.text = [beginDate stringByAppendingString:endDate];
}

- (void)currentMonth:(UIButton *)button
{
    self.calender.year = [NSCalendar currentYear];
    self.calender.month = [NSCalendar currentMonth];
}

#pragma mark ====================== button的改变
//改变button为未选择状态
- (void)changeButtonToMore
{
    UIButton *btn = (UIButton *)[self.view viewWithTag:_selectTag];
    UIImage *image = [[UIImage imageNamed:@"iconfont-riligengduo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    btn.frame = CGRectMake(__kScreenWidth-50, 10, 30, 30);
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:nil forState:UIControlStateNormal];
}

//改变button为已编辑状态
- (void)changeButtonToEdit
{
    UIButton *btn = (UIButton *)[self.view viewWithTag:_selectTag];
    btn.frame = CGRectMake(__kScreenWidth-160, 10, 140, 30);
    [btn setImage:nil forState:UIControlStateNormal];
    [btn setTitle:_selectStr forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn setTitleColor:RedColor forState:UIControlStateNormal];
}
#pragma mark ====================== LeukorrheaVC的代理方法
- (void)getLeukorrheaValue:(NSString *)string
{
    NSLog(@"===%@",string);
    if ([string isEqualToString:@"未选择"]) {
        [self changeButtonToMore];
    }else{
        _selectStr = string;
        [self changeButtonToEdit];
    }
}

#pragma mark ====================== SymptomVC的代理方法
- (void)getSymptomsValue:(NSString *)symptomStr
{
    if ([symptomStr isEqualToString:@""]){
        [self changeButtonToMore];
    }else{
        _selectStr = symptomStr;
        [self changeButtonToEdit];
    }
}

#pragma mark ===================== 日记，已编辑/未编辑

- (void)diaryEdit
{
    NSNotificationCenter *notifyCenter = [NSNotificationCenter defaultCenter];
    [notifyCenter addObserver:self selector:@selector(edit:) name:@"edit" object:nil];
}

- (void)edit:(NSNotification *)sender
{
    NSDictionary *userInfo = [sender userInfo];
    NSString *editStr = [userInfo objectForKey:@"edit"];

    _selectStr = editStr;
    [self changeButtonToEdit];
}

#pragma mark ====================== UIPickerView的代理方法
//列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _listNum;
}
//行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([_identifier isEqualToString:@"tiwen"]) {
        NSArray *arr = _dataArray1[component];
        return arr.count;
    }else{
        return _dataArray1.count;
    }
}
//返回view，设置每行每列显示的view
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIView *lineView1 = ((UIView *)[pickerView.subviews objectAtIndex:1]);
    UIView *lineView2 = ((UIView *)[pickerView.subviews objectAtIndex:2]);
    lineView1.backgroundColor = NormalColor;
    lineView2.backgroundColor = NormalColor;
    lineView1.frame = CGRectMake(50, ((__kScreenHeight-64)/2.0-60)/2.0-20, __kScreenWidth-100, 2.0);
    lineView2.frame = CGRectMake(50, ((__kScreenHeight-64)/2.0-60)/2.0+20, __kScreenWidth-100, 2.0);
    
    if ([_identifier isEqualToString:@"tiwen"]) {
        NSArray *arr = _dataArray1[component];
        UILabel * label = [[UILabel alloc]init];
        label.textAlignment = 1;
        label.text = arr[row];
        return label;
    }else{
        UILabel * label = [[UILabel alloc]init];
        label.textAlignment = 1;
        label.text = _dataArray1[row];
        return label;
    }
}
//设置每项的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}
//设置每列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 100;
}
//当用户选择某行内容时执行，row是用户选择的行，component是用户选择的列
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:0];
    label.textColor = NormalColor;
    label.font = [UIFont boldSystemFontOfSize:19];
    
    if ([_identifier isEqualToString:@"tiwen"]) {
        
        UILabel *label2 = (UILabel *)[pickerView viewForRow:row forComponent:1];
        label2.textColor = NormalColor;
        label2.font = [UIFont boldSystemFontOfSize:19];
        
        NSArray *array = _dataArray1[component];
        if (component == 0) {
            _zeroStr = array[row];
        }else{
            _oneStr = array[row];
        }
        _selectStr = [NSString stringWithFormat:@"%@%@",_zeroStr,_oneStr];
    }else{
        _zeroStr = _dataArray1[row];
        _selectStr = _zeroStr;
    }
     NSLog(@"++++%@",_selectStr);
}

#pragma mark *********************************** tableView的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_monthComing == YES) {
        return 11;
    }else{
        return 7;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *imageArray;
    NSArray *titleArray;
    if (_monthComing == YES) {
        imageArray = @[@"iconfont-tongfang",@"iconfont-tiwen",@"iconfont-baidai",@"iconfont-zhengzhuang",@"iconfont-pailuan",@"iconfont-zaozaoyun",@"iconfont-haoyunjilu",@"iconfont-tongfang",@"iconfont-tiwen",@"iconfont-baidai",@"iconfont-zhengzhuang"];
        titleArray = @[@"颜色",@"流量",@"痛经",@"血块",@"同房",@"基础体温",@"白带",@"症状",@"排卵试纸",@"早早孕试纸",@"好孕日记"];
    }else{
        imageArray = @[@"iconfont-tongfang",@"iconfont-tiwen",@"iconfont-baidai",@"iconfont-zhengzhuang",@"iconfont-pailuan",@"iconfont-zaozaoyun",@"iconfont-haoyunjilu"];
        titleArray = @[@"同房",@"基础体温",@"白带",@"症状",@"排卵试纸",@"早早孕试纸",@"好孕日记"];
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    //图标
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(15, 7.5, 35, 35)];
    icon.image = [[UIImage imageNamed:imageArray[indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [cell addSubview:icon];
    //标题
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(60, 7.5, 90, 35)];
    title.text = titleArray[indexPath.row];
    [cell addSubview:title];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.userInteractionEnabled = YES;
    
    //大姨妈来了 流量
    if (_monthComing == YES&&indexPath.row == 1) {
        for (int i = 0; i<5; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((__kScreenWidth-140)+25*i, 12.5, 25, 25);
            UIImage *shuidi = [[UIImage imageNamed:@"iconfont-shuidi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UIImage *shuidiSel = [[UIImage imageNamed:@"iconfont-shuidihover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            button.tag = 100+i;
            button.selected = NO;
            [button addTarget:self action:@selector(waterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setImage:shuidi forState:UIControlStateNormal];
            [button setImage:shuidiSel forState:UIControlStateSelected];
            [cell addSubview:button];
        }
    }else if (_monthComing == YES&&indexPath.row == 2){
        //大姨妈来了 痛经
        for (int i = 0; i<5; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((__kScreenWidth-140)+25*i, 12.5, 25, 25);
            UIImage *shandian = [[UIImage imageNamed:@"iconfont-shandian"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UIImage *shandianSel = [[UIImage imageNamed:@"iconfont-shandianSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            button.tag = 200+i;
            button.selected = NO;
            [button addTarget:self action:@selector(lightningBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setImage:shandian forState:UIControlStateNormal];
            [button setImage:shandianSel forState:UIControlStateSelected];
            [cell addSubview:button];
        }
    }else{
        //其他都是选择按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(__kScreenWidth-50, 10, 30, 30);
        UIImage *image = [[UIImage imageNamed:@"iconfont-riligengduo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        button.hidden = NO;
        button.tag = 400+indexPath.row;
        [button addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:image forState:UIControlStateNormal];
        [cell addSubview:button];
    }
    return cell;
}

#pragma mark ================= 开关调用的方法
- (void)mySwitchChange:(UISwitch *)sender
{
    if ([sender isOn]) {
        //大姨妈来了
        _monthComing = YES;
        if (_isUp) {
            _tableView.frame = CGRectMake(0, 85+(__kScreenWidth-22)/7.0*6.0+14, __kScreenWidth, 700);
        }else{
            _tableView.frame = CGRectMake(0, 85+(__kScreenWidth-22)/7.0+4, __kScreenWidth, 700);
        }
    }else{
        //大姨妈走了
        _monthComing = NO;
        if (_isUp) {
            _tableView.frame = CGRectMake(0, 85+(__kScreenWidth-22)/7.0+4, __kScreenWidth, 430);
        }else{
            _tableView.frame = CGRectMake(0, 85+(__kScreenWidth-22)/7.0*6.0+14, __kScreenWidth, 430);
        }
    }
    [_tableView reloadData];
}

#pragma mark ================= 流量按钮点击
- (void)waterBtnClick:(UIButton *)sender
{
    NSMutableArray *waterBtnArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<5; i++) {
        UIButton *waterBtn = (UIButton *)[self.view viewWithTag:100+i];
        [waterBtnArray addObject:waterBtn];
    }
    
    NSInteger waterTag = sender.tag-100;
    
    UIButton *nextBtn = (UIButton *)[self.view viewWithTag:sender.tag+1];
    
    //如果点击的水滴已经被选择
    if (sender.selected == YES) {
        //如果点击的水滴后面的水滴已经被选择，把后面的状态改为未选择
        if (nextBtn.selected == YES) {
            for (NSInteger i = sender.tag+1-100; i<5; i++) {
                UIButton *button = waterBtnArray[i];
                button.selected = NO;
            }
        }else{
            //如果点击的水滴后面的水滴没有被选择，把点击的水滴改为未选择
            sender.selected = NO;
        }
    }else{
        //如果点击的水滴没有被选择，把前面所有的水滴状态改为已选择
        for (int i = 0; i<=waterTag; i++) {
            UIButton *button = waterBtnArray[i];
            button.selected = YES;
        }
    }
}

#pragma mark ================= 痛经按钮点击
- (void)lightningBtnClick:(UIButton *)sender
{
    NSMutableArray *lightningBtnArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<5; i++) {
        UIButton *lightningBtn = (UIButton *)[self.view viewWithTag:200+i];
        [lightningBtnArray addObject:lightningBtn];
    }
    
    NSInteger lightningTag = sender.tag-200;
    
    UIButton *nextBtn = (UIButton *)[self.view viewWithTag:sender.tag+1];
    
    //如果点击的水滴已经被选择
    if (sender.selected == YES) {
        //如果点击的水滴后面的水滴已经被选择，把后面的状态改为未选择
        if (nextBtn.selected == YES) {
            for (NSInteger i = sender.tag+1-200; i<5; i++) {
                UIButton *button = lightningBtnArray[i];
                button.selected = NO;
            }
        }else{
            //如果点击的水滴后面的水滴没有被选择，把点击的水滴改为未选择
            sender.selected = NO;
        }
    }else{
        //如果点击的水滴没有被选择，把前面所有的水滴状态改为已选择
        for (int i = 0; i<=lightningTag; i++) {
            UIButton *button = lightningBtnArray[i];
            button.selected = YES;
        }
    }
}

#pragma mark ================= pickerView选项
- (void)moreBtnClick:(UIButton *)sender
{
    //默认 请选择
    _selectStr = @"请选择";
    
    NSUserDefaults *paperStyle = [NSUserDefaults standardUserDefaults];
    
    _selectTag = sender.tag;
    //大姨妈没来
    if (_monthComing == NO) {
        if (sender.tag == 400) {
            //同房
            _identifier = @"tongfang";
            _listNum = 1;
            _titlelabel.text = @"同房";
            _declarelabel.text = @"";
            _dataArray1 = @[@"请选择",@"无措施",@"避孕套",@"避孕药",@"体外排精"];
            [self showSelectPicker];
        }else if (sender.tag == 401){
            //基础体温
            _identifier = @"tiwen";
            _titlelabel.text = @"基础体温";
            _declarelabel.text = @"晨醒后将体温计放在舌头下5分钟，读数并记录";
            _listNum = 2;
            _dataArray1 = @[@[@"请选择",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42"],@[@"请选择",@".0°C",@".1°C",@".2°C",@".3°C",@".4°C",@".5°C",@".6°C",@".7°C",@".8°C",@".9°C"]];
            [self showSelectPicker];
        }else if (sender.tag == 402){
            //白带
            LeukorrheaVC *leukorrhea = [[LeukorrheaVC alloc]init];
            leukorrhea.delegate = self;
            printf("白带");
            [self.navigationController pushViewController:leukorrhea animated:YES];
            printf("白带2");
        }else if (sender.tag == 403){
            //症状
            SymptomVC *symptom = [[SymptomVC alloc]init];
            symptom.delegate = self;
            [self.navigationController pushViewController:symptom animated:YES];
        }else if (sender.tag == 404){
            //排卵试纸
            [paperStyle setValue:@"textpaper" forKey:@"paperStyle"];
            TextPaperVC *textpaper = [[TextPaperVC alloc]init];
            [self.navigationController pushViewController:textpaper animated:YES];
        }else if (sender.tag == 405){
            //早早孕试纸
            [paperStyle setValue:@"HCGpaper" forKey:@"paperStyle"];
            HCGPaperVC *hcg = [[HCGPaperVC alloc]init];
            [self.navigationController pushViewController:hcg animated:YES];
        }else if (sender.tag == 406){
            //好孕日记
            DiaryVC *diary = [[DiaryVC alloc]init];
            [self.navigationController pushViewController:diary animated:YES];
        }
    }else{
        //大姨妈来了
        if (sender.tag == 400) {
            //颜色
            _identifier = @"yanse";
            _listNum = 1;
            _titlelabel.text = @"颜色";
            _declarelabel.text = @"";
            _dataArray1 = @[@"请选择",@"鲜红",@"暗红",@"淡红"];
            [self showSelectPicker];
        }else if (sender.tag == 403){
            //血块
            _identifier = @"xuekuai";
            _listNum = 1;
            _titlelabel.text = @"血块";
            _declarelabel.text = @"";
            _dataArray1 = @[@"请选择",@"不凝血",@"少量血块",@"较多血块"];
            [self showSelectPicker];
        }else if (sender.tag == 404){
            //同房
            _identifier = @"tongfang";
            _listNum = 1;
            _titlelabel.text = @"同房";
            _declarelabel.text = @"";
            _dataArray1 = @[@"请选择",@"无措施",@"避孕套",@"避孕药",@"体外排精"];
            [self showSelectPicker];
        }else if (sender.tag == 405){
            //基础体温
            _identifier = @"tiwen";
            _titlelabel.text = @"基础体温";
            _declarelabel.text = @"晨醒后将体温计放在舌头下5分钟，读数并记录";
            _listNum = 2;
            _dataArray1 = @[@[@"请选择",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42"],@[@"请选择",@".0°C",@".1°C",@".2°C",@".3°C",@".4°C",@".5°C",@".6°C",@".7°C",@".8°C",@".9°C"]];
            [self showSelectPicker];
        }else if (sender.tag == 406){
            //白带
            LeukorrheaVC *leukorrhea = [[LeukorrheaVC alloc]init];
            leukorrhea.delegate = self;
            [self.navigationController pushViewController:leukorrhea animated:YES];
        }else if (sender.tag == 407){
            //症状
            SymptomVC *symptom = [[SymptomVC alloc]init];
            symptom.delegate = self;
            [self.navigationController pushViewController:symptom animated:YES];
        }else if (sender.tag == 408){
            //排卵试纸
            [paperStyle setValue:@"textpaper" forKey:@"paperStyle"];
            TextPaperVC *textpaper = [[TextPaperVC alloc]init];
            [self.navigationController pushViewController:textpaper animated:YES];
        }else if (sender.tag == 409){
            //早早孕试纸
            [paperStyle setValue:@"HCGpaper" forKey:@"paperStyle"];
            HCGPaperVC *hcg = [[HCGPaperVC alloc]init];
            [self.navigationController pushViewController:hcg animated:YES];
        }else if (sender.tag == 410){
            //好孕日记
            DiaryVC *diary = [[DiaryVC alloc]init];
            [self.navigationController pushViewController:diary animated:YES];
        }
    }
}

#pragma mark ========================= 显示选择器
- (void)showSelectPicker
{
    _backgroundBtn.hidden = NO;
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [_pickerView selectRow:0 inComponent:0 animated:NO];
    if ([_identifier isEqualToString:@"tiwen"]) {
        [_pickerView selectRow:0 inComponent:1 animated:NO];
    }
    [UIView animateWithDuration:0.3 animations:^{
        _selectView.frame = CGRectMake(0, 64+(__kScreenHeight-64)/2.0, __kScreenWidth, (__kScreenHeight-64)/2.0);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
@end
