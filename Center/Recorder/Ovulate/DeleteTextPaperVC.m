//
//  DeleteTextPaperVC.m
//  CHLCalendar
//
//  Created by luomin on 16/3/18.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import "DeleteTextPaperVC.h"
#import "Public.h"
#import "AlertLabel.h"

@interface DeleteTextPaperVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIView *_selectDateView;
    NSString *_nowStr;
    
    //测试结果
    NSString *_textValueStr;
    NSInteger _valueTag;
}
@end

@implementation DeleteTextPaperVC

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackgroundColor;
    
    [self createNavView];
    [self createImageResultUI];
    [self styleDelare];
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
    titleLabel.text = @"选择结果";
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
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(__kScreenWidth-55, 32, 40, 20);
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(changeTextPaper) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:saveBtn];
    
    //删除按钮
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(0, __kScreenHeight-49, __kScreenWidth, 49);
    deleteBtn.backgroundColor = RedColor;
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteTextPaper) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
}

#pragma mark ======================== 返回
- (void)backToSuper
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ======================== 保存修改
- (void)changeTextPaper
{
    //_nowStr _textValueStr
    
    NSString *textid = [NSString stringWithFormat:@"%ld",self.textId];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeTextPaper" object:self userInfo:@{@"time":_nowStr,@"value":_textValueStr,@"textId":textid}];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ======================== 删除
- (void)deleteTextPaper
{
    NSString *textid = [NSString stringWithFormat:@"%ld",self.textId];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"deleteTextPaper" object:self userInfo:@{@"textId":textid}];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark ======================== 选择结果界面
- (void)createImageResultUI
{
    //图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 74, __kScreenWidth, 80)];
    imageView.image = self.textImage;
    imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView];
    
    //时间
    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 164, __kScreenWidth, 40)];
    timeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:timeView];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 55, 40)];
    timeLabel.text = @"日期";
    timeLabel.textColor = [UIColor blackColor];
    [timeView addSubview:timeLabel];
    
    //默认显示当前时间
    _nowStr = self.textTime;
    UILabel *nowTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, __kScreenWidth-110, 40)];
    nowTimeLabel.text = self.textTime;
    nowTimeLabel.textAlignment = 2;
    nowTimeLabel.font = [UIFont systemFontOfSize:15];
    nowTimeLabel.textColor = RedColor;
    nowTimeLabel.tag = 111;
    [timeView addSubview:nowTimeLabel];
    
    //箭头
    UIImageView *goimageView = [[UIImageView alloc]initWithFrame:CGRectMake(__kScreenWidth-20, 12.5, 10, 15)];
    goimageView.image = [UIImage imageNamed:@"icon_go"];
    [timeView addSubview:goimageView];
    
    //点击按钮选择时间
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, __kScreenWidth, 40);
    [btn addTarget:self action:@selector(selectTime) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    [timeView addSubview:btn];
    
    _textValueStr = self.textResult;
}

//选择时间
- (void)selectTime
{
    [self selectTakePhotoTime];
}

#pragma mark ======================== 说明
- (void)styleDelare
{
    UILabel *declare = [[UILabel alloc]initWithFrame:CGRectMake(15, 204, __kScreenWidth-15, 40)];
    declare.text = @"C代表对照线，T代表检测线";
    declare.backgroundColor = [UIColor clearColor];
    declare.font = [UIFont systemFontOfSize:15];
    declare.textColor = [UIColor grayColor];
    [self.view addSubview:declare];
    
    //强阳，阳性，阴性，无效
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 244, __kScreenWidth, 240)];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = SeparateColor;
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


#pragma mark ======================== 日期选择器
- (void)selectTakePhotoTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    UILabel *selectTimeLabel = (UILabel *)[self.view viewWithTag:111];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth, 216)];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    NSDate *maxDate = [NSDate date];
    datePicker.maximumDate = maxDate;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert.view addSubview:datePicker];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *dateStr = [dateFormatter stringFromDate:datePicker.date];
        _nowStr = dateStr;
        selectTimeLabel.text = _nowStr;
        NSLog(@"+++++%@",_nowStr);
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark ======================== tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    UIImage *image1 = [UIImage imageNamed:@"one"];
    UIImage *image2 = [UIImage imageNamed:@"two"];
    UIImage *image3 = [UIImage imageNamed:@"three"];
    UIImage *image4 = [UIImage imageNamed:@"four"];
    UIImage *image5 = [UIImage imageNamed:@"five"];
    UIImage *image6 = [UIImage imageNamed:@"six"];
    
    NSArray *array1 = @[@"强阳",@"阳性",@"阴性",@"无效"];
    NSArray *array2 = @[@"将在24-48小时内排卵",@"处于排卵期，马上就是排卵日喽",@"持续测试，不要错过强阳哦",@"有点小问题，再试试"];
    NSArray *array3 = @[image1,image2,image3,image5];
    NSArray *array4 = @[image4,image6];
    cell.textLabel.text = array1[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:19];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 10, 20, 40)];
    imageView.image = array3[indexPath.row];
    [cell addSubview:imageView];
    if (indexPath.row == 2||indexPath.row == 3) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(85, 10, 20, 40)];
        imageView.image = array4[indexPath.row-2];
        [cell addSubview:imageView];
    }
    
    UILabel *declareLabel = [[UILabel alloc]init];
    if (indexPath.row == 0||indexPath.row == 1) {
        declareLabel.frame = CGRectMake(90, 0, __kScreenWidth-35-90, 60);
    }else{
        declareLabel.frame = CGRectMake(115, 0, __kScreenWidth-35-115, 60);
    }
    declareLabel.text = array2[indexPath.row];
    declareLabel.font = [UIFont systemFontOfSize:15];
    declareLabel.textColor = [UIColor grayColor];
    [cell addSubview:declareLabel];
    
    //选择按钮
    
    NSInteger m = 0;
    for (int i = 0; i<4; i++) {
        NSString *str = array1[i];
        if ([str isEqualToString:self.textResult]) {
            m = i;
        }
    }
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(__kScreenWidth-30, 15, 20, 20);
    
    selectBtn.tag = indexPath.row+1000;
    if (indexPath.row == m) {
        selectBtn.selected = YES;
    }else{
        selectBtn.selected = NO;
    }
    [selectBtn setImage:[[UIImage imageNamed:@"duihao_icon_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [selectBtn setImage:[[UIImage imageNamed:@"duihao_icon_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:selectBtn];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
//选择按钮
- (void)selectBtnClick:(UIButton *)sender
{
    //按钮的tag 值 0~4
    NSInteger tag = sender.tag;
    _valueTag = tag;
    NSLog(@"^^^^^^^^^%ld",_valueTag);
    
    for (NSInteger i = 1000; i<1004; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i];
        //如果是刚才点击的按钮
        if (i == tag) {
            if (btn.selected == YES) {
                btn.selected = NO;
            }else{
                btn.selected = YES;
            }
        }else{//如果不是
            btn.selected = NO;
        }
    }
    
    UITableViewCell *cell = (UITableViewCell *)[sender superview];
    _textValueStr = cell.textLabel.text;
    NSLog(@"检测结果：%@",_textValueStr);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

//#pragma mark ========================= 选择cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger tag = indexPath.row+1000;
    
    _valueTag = tag;
    NSLog(@"^^^^^^^^^%ld",_valueTag);
    
    for (NSInteger i = 1000; i<1004; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i];
        //如果是刚才点击的按钮
        if (i == tag) {
            if (btn.selected == YES) {
                btn.selected = NO;
            }else{
                btn.selected = YES;
            }
        }else{//如果不是
            btn.selected = NO;
        }
    }
    
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    _textValueStr = cell.textLabel.text;
    NSLog(@"检测结果：%@",_textValueStr);
}

@end
