//
//  LeukorrheaVC.m
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import "LeukorrheaVC.h"
#import "Public.h"
#import "AlertLabel.h"

@interface LeukorrheaVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSInteger _styleTag;
    //预测类型
    NSString *_leukorrheaStyle;
}
@end

@implementation LeukorrheaVC

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNavView];
    [self createTableView];
}

- (void)createNavView
{
    //导航栏
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth, 64)];
    navView.backgroundColor = RedColor;
    [self.view addSubview:navView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x-50, 20, 100, 44)];
    titleLabel.text = @"白带";
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
    UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
    save.frame = CGRectMake(__kScreenWidth-55, 32, 40, 20);
    save.titleLabel.font = [UIFont systemFontOfSize:15];
    [save setTitle:@"保存" forState:UIControlStateNormal];
    [save setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [save addTarget:self action:@selector(saveMySelectItem) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:save];
}
//返回
- (void)backToSuper
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark =============== 保存选择
- (void)saveMySelectItem
{
    if (_styleTag == 0) {
        //未选择
        _leukorrheaStyle = @"未选择";
    }
    if (_styleTag == 1000) {
        //预测为月经期
        _leukorrheaStyle = @"预测为月经期";
    }else if (_styleTag == 1005){
        //预测为排卵日
        _leukorrheaStyle = @"预测为排卵日";
    }else if (_styleTag == 1006){
        //预测为黄体期
        _leukorrheaStyle = @"预测为黄体期";
    }else{
        //预测为卵泡期
        _leukorrheaStyle = @"预测为卵泡期";
    }
    if ([_delegate respondsToSelector:@selector(getLeukorrheaValue:)]) {
        [_delegate getLeukorrheaValue:_leukorrheaStyle];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//创建tableView
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth, __kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = SeparateColor;
    [self.view addSubview:_tableView];
}

#pragma mark =================== tableView的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"请用试纸蘸取阴道口粘液观察状态";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array1 = @[@"只有经血，无拉丝",@"无经血，无拉丝",@"拉丝<2.5cm",@"拉丝2.5cm~4cm",@"拉丝4cm~10cm",@"拉丝≥10cm",@"无拉丝，有粘液"];
    NSArray *array2 = @[@"月经期，坐等排卵",@"无粘液，安全期，悄然降临",@"少量浑浊粘稠粘液，哇，排卵期在向我招手呦",@"少量浑浊粘稠粘液，已经感觉到它的呼吸了",@"较多量，较透明，较稀薄粘液，可能就在这两天哦",@"多量，透明，很稀薄粘液，24小时内可能会排卵",@"浑浊，粘稠粘液，已经排完卵了"];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = array1[indexPath.row];
    cell.detailTextLabel.text = array2[indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //button
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(__kScreenWidth-35, 15, 20, 20);
    selectBtn.selected = NO;
    selectBtn.tag = indexPath.row+1000;
    [selectBtn setImage:[[UIImage imageNamed:@"duihao_icon_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [selectBtn setImage:[[UIImage imageNamed:@"duihao_icon_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:selectBtn];
    
    return cell;
}

//选择按钮
- (void)selectBtnClick:(UIButton *)sender
{
    //按钮的tag 值 0~6
    NSInteger tag = sender.tag;
    _styleTag = tag;
    for (NSInteger i = 1000; i<1007; i++) {
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

//#pragma mark ========================= 选择cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger tag = indexPath.row+1000;
    _styleTag = tag;
    for (NSInteger i = 1000; i<1007; i++) {
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
}

@end
