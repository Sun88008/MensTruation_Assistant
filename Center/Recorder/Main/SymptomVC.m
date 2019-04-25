//
//  SymptomVC.m
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import "SymptomVC.h"
#import "Public.h"
#import "AlertLabel.h"
@interface SymptomVC ()
{
    NSString *_selectSymptomStr;
}
@end

@implementation SymptomVC

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundColor;
    
    _selectSymptomStr = @"";
    
    [self createNavView];
    [self createSymptomView];
}

- (void)createNavView
{
    //导航栏
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth, 64)];
    navView.backgroundColor = RedColor;
    [self.view addSubview:navView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x-50, 20, 100, 44)];
    titleLabel.text = @"症状";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [navView addSubview:titleLabel];
    
    //返回按钮
    UIImage *imageback = [[UIImage imageNamed:@"iconfont-arrow-left-copy"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 32, 20, 20);
    [button setImage:imageback forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backToSuperView) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:button];
    
    //保存按钮
    UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
    save.frame = CGRectMake(__kScreenWidth-55, 32, 40, 20);
    save.titleLabel.font = [UIFont systemFontOfSize:15];
    [save setTitle:@"确定" forState:UIControlStateNormal];
    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [save addTarget:self action:@selector(saveMyChooseItem) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:save];
}

//返回
- (void)backToSuperView
{
    [self.navigationController popViewControllerAnimated:YES];
}

//确定
- (void)saveMyChooseItem
{
    if ([_delegate respondsToSelector:@selector(getSymptomsValue:)]) {
        [_delegate getSymptomsValue:_selectSymptomStr];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createSymptomView
{
    UIView *symptomView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth, 203)];
    [self.view addSubview:symptomView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 40)];
    titleLabel.text = @"常见症状";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor grayColor];
    [symptomView addSubview:titleLabel];
    
    //创建按钮选项
    
    NSArray *array = @[@"腹痛",@"头痛",@"腹胀",@"痛经",@"胸痛",@"溢乳",@"盗汗",@"潮热",@"白带异常",@"乳房胀痛",@"恶心呕吐",@"阴道出血",@"腰酸",@"失眠",@"便秘",@"发热"];
    for (int i = 0; i<4; i++) {
        for (int j = 0; j<4; j++) {
            UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
            item.frame = CGRectMake(__kScreenWidth/4.0*j, 40+41*i, (__kScreenWidth-3)/4.0, 40);
            [item setTitle:array[i*4+j] forState:UIControlStateNormal];
            item.backgroundColor = [UIColor whiteColor];
            item.titleLabel.font = [UIFont systemFontOfSize:16];
            [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [item setTitleColor:RedColor forState:UIControlStateSelected];
            [item addTarget:self action:@selector(symptomItemClick:) forControlEvents:UIControlEventTouchUpInside];
            item.selected = NO;
            [symptomView addSubview:item];
        }
    }
}

//常见症状选择按钮
- (void)symptomItemClick:(UIButton *)sender
{
    NSLog(@"%@",sender.titleLabel.text);
    NSString *selectStr = sender.titleLabel.text;
    if (sender.selected == YES) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
        if ([_selectSymptomStr isEqualToString:@""]) {
            _selectSymptomStr = selectStr;
        }else{
            _selectSymptomStr = [NSString stringWithFormat:@"%@,%@",_selectSymptomStr,selectStr];
        }
    }
    NSLog(@"_selectSymptomStr:%@",_selectSymptomStr);
}

@end
