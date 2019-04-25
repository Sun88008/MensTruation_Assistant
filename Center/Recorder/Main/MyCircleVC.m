//
//  MyCircleVC.m
//  CHLCalendar
//
//  Created by luomin on 16/3/4.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import "MyCircleVC.h"
#import "Public.h"
#import "AlertLabel.h"

@interface MyCircleVC ()
{
    NSString *_dayStr;
    NSString *_monthStr;
}
@end

@implementation MyCircleVC

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [self beginAnimation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNavView];
    [self createUI];
    [self createTextfield];
}

#pragma mark ============== 创建导航栏项
- (void)createNavView
{
    //背景
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth, __kScreenHeight)];
    backImg.image = [UIImage imageNamed:@"mycircleback"];
    [self.view addSubview:backImg];
    
    //导航栏
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth, 64)];
    navView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:navView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x-50, 20, 100, 44)];
    titleLabel.text = @"记经期";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [navView addSubview:titleLabel];
    
    //返回按钮
    UIImage *imageback = [[UIImage imageNamed:@"back111"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(5, 20, 44, 44);
    [button setImage:imageback forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backToSuper) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:button];
    
    //保存按钮
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(__kScreenWidth-55, 32, 40, 20);
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:saveBtn];
}

//返回
- (void)backToSuper
{
    [self.navigationController popViewControllerAnimated:YES];
}

//保存
- (void)save
{
    if (_dayStr.length == 0||_monthStr.length == 0) {
        [AlertLabel hudShowText:@"天数不能为空"];
        return;
    }else{
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:_dayStr forKey:@"day"];
        [userDefault setObject:_monthStr forKey:@"month"];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)createUI
{
    UIImageView *qianbiImageView = [[UIImageView alloc]initWithFrame:CGRectMake(__kScreenWidth/7.0*3, 100, __kScreenWidth/7.0, __kScreenWidth/7.0)];
    qianbiImageView.image = [UIImage imageNamed:@"iconfontqianbi"];
    [self.view addSubview:qianbiImageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, __kScreenWidth/7.0+140, __kScreenWidth/3.0*2.0, 30)];
    label.text = @"已开启记经期状态";
    label.textAlignment = 2;
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    UIImageView *duihao = [[UIImageView alloc]initWithFrame:CGRectMake(__kScreenWidth/3.0*2.0+5, __kScreenWidth/7.0+145, 20, 20)];
    duihao.image = [UIImage imageNamed:@"iconfontduihaoxi"];
    [self.view addSubview:duihao];
    
    NSArray *array = @[@"设置经期(天)",@"设置周期(天)"];
    for (int i = 0; i<2; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, __kScreenWidth/7.0+180+60*i, __kScreenWidth-20, 50)];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 5.0;
        view.tag = 222+i;
        view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.4];
        [self.view addSubview:view];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 50)];
        label1.text = array[i];
        label1.textColor = WhiteColor;
        [view addSubview:label1];
    }
    
    //说明
    UILabel *declareLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, __kScreenWidth/7.0+290, __kScreenWidth, 40)];
    declareLabel.text = @"进入记经期状态，下次月经来之前我们提前通知你哦~";
    declareLabel.backgroundColor = [UIColor clearColor];
    declareLabel.alpha = 0.5;
    declareLabel.textColor = WhiteColor;
    declareLabel.textAlignment = 1;
    declareLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:declareLabel];
}

#pragma mark =================== 文本框
- (void)createTextfield
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    _dayStr = [userDefault objectForKey:@"day"];
    _monthStr = [userDefault objectForKey:@"month"];
    
    NSArray *array = @[_dayStr,_monthStr];
    for (int i = 0; i<2; i++) {
        UIView *view = (UIView *)[self.view viewWithTag:222+i];
        //文本框 填写月经天数 周期
        UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, __kScreenWidth-140, 50)];
        textfield.keyboardType = UIKeyboardTypeNumberPad;
        textfield.tintColor = [UIColor yellowColor];
        textfield.textAlignment = 2;
        textfield.tag = 100+i;
        textfield.text = array[i];
        textfield.textColor = [UIColor yellowColor];
        [textfield addTarget:self action:@selector(getFieldContent:) forControlEvents:UIControlEventEditingChanged];
        [view addSubview:textfield];
    }
}

- (void)getFieldContent:(UITextField *)sender
{
    if (sender.tag == 100) {
        _dayStr = sender.text;
    }else{
        _monthStr = sender.text;
    }
}

#pragma mark ============= 动画
- (void)beginAnimation
{
    CALayer *sublayer1 =[CALayer layer];
    sublayer1.shadowOffset = CGSizeMake(0, 8);
    sublayer1.shadowRadius =5.0;
    sublayer1.shadowColor =[UIColor yellowColor].CGColor;
    sublayer1.shadowOpacity =0.8;
    sublayer1.frame = CGRectMake(__kScreenWidth/7.0*3-15, 100-15, __kScreenWidth/7.0+30, __kScreenWidth/7.0+30);
    sublayer1.borderColor =[UIColor yellowColor].CGColor;
    sublayer1.borderWidth =2;
    sublayer1.cornerRadius =__kScreenWidth/14.0+15;
    [self.view.layer addSublayer:sublayer1];
    
    CABasicAnimation *basic1=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basic1.toValue=@(1.5);
    basic1.duration=2.0;
    basic1.fillMode=kCAFillModeForwards;
    basic1.removedOnCompletion=NO;
    basic1.repeatCount=CGFLOAT_MAX;
    [sublayer1 addAnimation:basic1 forKey:@"basic1"];
    
    CABasicAnimation *basic2=[CABasicAnimation animationWithKeyPath:@"opacity"];
    basic2.toValue=@(0.f);
    basic2.duration=2.0;
    basic2.fillMode=kCAFillModeForwards;
    basic2.removedOnCompletion=NO;
    basic2.repeatCount=CGFLOAT_MAX;
    [sublayer1 addAnimation:basic2 forKey:@"basic2"];
}
@end
