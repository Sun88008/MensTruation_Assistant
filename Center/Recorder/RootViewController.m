//
//  RootViewController.m
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import "RootViewController.h"
#import "RecorderVC.h"
#import "SelectView.h"
#import "MyCircleVC.h"
#import "Public.h"
#import "AlertLabel.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    SelectView *_selectView;
    
    //pickerView数组
    NSArray *_dataArray1;
    
    UITableView *_tableView;
    
    NSString *_dayStr;
    NSString *_monthStr;
    NSString *_dateStr;
    
    NSString *_newDayStr;
    NSString *_newMonthStr;
    NSString *_newDateStr;
}
@end

@implementation RootViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray1 = [[NSMutableArray alloc]init];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(__kScreenWidth/2-50, __kScreenHeight/2.0-100, 100, 50);
    btn.backgroundColor = NormalColor;
    [btn setTitle:@"每日记录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(joinDiaryRecord) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(__kScreenWidth/2-50, __kScreenHeight/2.0-25, 100, 50);
    btn2.backgroundColor = NormalColor;
    [btn2 setTitle:@"我的周期" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(joinMyCircle) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
}

#pragma mark ================ 进入我的记录
- (void)joinDiaryRecord
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    _newDayStr = [userDefault objectForKey:@"day"];
    _newMonthStr = [userDefault objectForKey:@"month"];
    _newDateStr = [userDefault objectForKey:@"date"];
    
    //如果没有设置 完善信息
    if (_newDayStr.length == 0 && _newMonthStr.length == 0 && _newDateStr.length == 0){
        [self completeMonthDetail];
    }else{
        //完善过信息，进入日历
        RecorderVC *record = [[ RecorderVC alloc]init];
        [self.navigationController pushViewController:record animated:YES];
    }
}

#pragma mark ================ 进入我的周期
- (void)joinMyCircle
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    _newDayStr = [userDefault objectForKey:@"day"];
    _newMonthStr = [userDefault objectForKey:@"month"];
    _newDateStr = [userDefault objectForKey:@"date"];
    
    //如果没有设置 完善信息
    if (_newDayStr.length == 0 && _newMonthStr.length == 0 && _newDateStr.length == 0){
        [AlertLabel hudShowText:@"您还没有设置过周期"];
        return;
    }else{
        //完善过信息，进入日历
        MyCircleVC *circle = [[ MyCircleVC alloc]init];
        [self.navigationController pushViewController:circle animated:YES];
    }
}

#pragma mark ================ 弹出框
- (void)completeMonthDetail
{
    _selectView = [[SelectView alloc]initWithTitle:@"完善月经信息" message:@"先选择一下目前的状态吧"];
    
    [self createCustomView];
    
    [_selectView addSubview:_tableView];
    //完成
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.frame = CGRectMake(30, 260, __kScreenWidth-100, 40);
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(finishBtnClick) forControlEvents:UIControlEventTouchUpInside];
    finishButton.backgroundColor = RedColor;
    finishButton.layer.masksToBounds = YES;
    finishButton.layer.cornerRadius = 10.0;
    [_selectView addSubview:finishButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [_selectView.coverView addGestureRecognizer:tap];
    
    [_selectView show];
}

- (void)createCustomView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, __kScreenWidth-40, 150) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = SeparateColor;
    _tableView.tableFooterView = [UIView new];
}

- (void)tap:(UIGestureRecognizer *)tap
{
    UITextField *textfield1 = (UITextField *)[_selectView viewWithTag:100];
    UITextField *textfield2 = (UITextField *)[_selectView viewWithTag:101];
    [textfield1 resignFirstResponder];
    [textfield2 resignFirstResponder];
}

#pragma mark ====================== 完成按钮
- (void)finishBtnClick
{
    if (_dayStr.length == 0||_monthStr.length == 0||_dateStr.length == 0) {
        [AlertLabel hudShowText:@"请完善您的信息"];
        return;
    }else{
        [_selectView dismiss];
        RecorderVC *record = [[ RecorderVC alloc]init];
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:_dayStr forKey:@"day"];
        [userDefault setObject:_monthStr forKey:@"month"];
        [userDefault setObject:_dateStr forKey:@"date"];
        [userDefault synchronize];
        
        [self.navigationController pushViewController:record animated:YES];
    }
}

#pragma mark ========== tableView的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *title = @[@"月经天数(天)",@"月经周期(天)",@"上次月经时间"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = title[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.row == 2) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(__kScreenWidth-150, 0, 100, 50);
        [button setTitle:@"选择" forState:UIControlStateNormal];
        button.hidden = NO;
        [button setTitleColor:RedColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = 100+indexPath.row;
//        button.backgroundColor = [UIColor yellowColor];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [button addTarget:self action:@selector(selectMonthTime) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
    }else{
        //文本框 填写月经天数 周期
        UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(__kScreenWidth-150, 0, 100, 50)];
//        textfield.backgroundColor = [UIColor yellowColor];
        textfield.keyboardType = UIKeyboardTypeNumberPad;
        textfield.placeholder = @"填写";
        [textfield setValue:RedColor forKeyPath:@"_placeholderLabel.textColor"];
        [textfield setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        textfield.tintColor = RedColor;
        textfield.textAlignment = 2;
        textfield.tag = 100+indexPath.row;
        textfield.font = [UIFont systemFontOfSize:15];
        textfield.textColor = RedColor;
        [textfield addTarget:self action:@selector(getFieldContent:) forControlEvents:UIControlEventEditingChanged];
        [cell addSubview:textfield];
    }
    return cell;
}

- (void)getFieldContent:(UITextField *)sender
{
    if (sender.tag == 100) {
        //月经天数
        _dayStr = sender.text;
    }else{
        //月经周期
        _monthStr = sender.text;
    }
    NSLog(@"%@",sender.text);
}

#pragma mark ======================== 日期选择器
- (void)selectMonthTime
{
    UITextField *textfield1 = (UITextField *)[_selectView viewWithTag:100];
    UITextField *textfield2 = (UITextField *)[_selectView viewWithTag:101];
    [textfield1 resignFirstResponder];
    [textfield2 resignFirstResponder];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    UIButton *selectTimeButton = (UIButton *)[_selectView viewWithTag:102];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth, 216)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate *maxDate = [NSDate date];
    datePicker.maximumDate = maxDate;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert.view addSubview:datePicker];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *dateStr = [dateFormatter stringFromDate:datePicker.date];
        _dateStr = dateStr;
        [selectTimeButton setTitle:dateStr forState:UIControlStateNormal];
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
@end
