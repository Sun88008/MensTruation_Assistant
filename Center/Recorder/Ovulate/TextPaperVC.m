//
//  TextPaperVC.m
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import "TextPaperVC.h"
#import "PhotoTweaksViewController.h"
#import "TextResultVC.h"
#import "TextPaperCell.h"
#import "GPUImage.h"
#import "GPUImageColorInvertFilter.h"
#import "GPUImagePicture.h"
#import "TakePhotoVC.h"
#import "DeleteTextPaperVC.h"
#import "Public.h"
#import "AlertLabel.h"

@interface TextPaperVC ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,PhotoTweaksViewControllerDelegate,GetTextResultDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIImagePickerController *_imagePicker;
    UITableView *_tableView;
    NSMutableArray *_dataImgArray;
    NSMutableArray *_dataTimeArray;
    NSMutableArray *_dataValueArray;
    
    NSMutableArray *_invertImgArray;
    
    //是否有数据
    BOOL _tableStyle;
    //是否反色
    BOOL _isInvert;
}
@end

@implementation TextPaperVC

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackgroundColor;
    
    _isInvert = NO;
    
    [self createTableView];
    [self createNavView];
    [self createBottomCamera];
    [self cameraEdit];
    [self changeTextValue];
    [self deleteTextValue];
}

#pragma mark ============== 创建tableView
- (void)createTableView
{
    _dataImgArray = [[NSMutableArray alloc]init];
    _dataTimeArray = [[NSMutableArray alloc]init];
    _dataValueArray = [[NSMutableArray alloc]init];
    _invertImgArray = [[NSMutableArray alloc]init];
    
    _tableStyle = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, __kScreenWidth, __kScreenHeight-64-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    //没有记录时显示图片
    if (_tableStyle == NO) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(__kScreenWidth/6.0, 200, __kScreenWidth/3.0*2, __kScreenWidth/21.0*10.0)];
        imageView.image = [UIImage imageNamed:@"tip"];
        imageView.tag = 999;
        [self.view addSubview:imageView];
    }
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
    titleLabel.text = @"排卵试纸";
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
    
    //反色按钮
    UIButton *inverseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    inverseBtn.frame = CGRectMake(__kScreenWidth-55, 32, 40, 20);
    inverseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [inverseBtn setTitle:@"反色" forState:UIControlStateNormal];
    inverseBtn.selected = NO;
    [inverseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [inverseBtn addTarget:self action:@selector(inverseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:inverseBtn];
}

//返回
- (void)backToSuper
{
    [self.navigationController popViewControllerAnimated:YES];
}

//反色按钮
- (void)inverseBtnClick:(UIButton *)sender
{
    if (sender.selected == YES) {
        sender.selected = NO;
        _isInvert = NO;
    }else{
        sender.selected = YES;
        _isInvert = YES;
    }
    
    [_tableView reloadData];
}

#pragma mark ================= 创建底部拍照
- (void)createBottomCamera
{
    //底部View
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, __kScreenHeight-49, __kScreenWidth, 49)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    //相机View
    UIView *cameraView = [[UIView alloc]initWithFrame:CGRectMake(__kScreenWidth/2.0-40, 4.5, 80, 40)];
    cameraView.backgroundColor = RedColor;
    cameraView.layer.masksToBounds = YES;
    cameraView.layer.cornerRadius = 5.0;
    [bottomView addSubview:cameraView];
    
    //相机按钮
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraBtn.frame = CGRectMake(25, 5, 30, 30);
    cameraBtn.backgroundColor = [UIColor clearColor];
    [cameraBtn setImage:[[UIImage imageNamed:@"iconfont-paizhao"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(selectPhotobtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cameraView addSubview:cameraBtn];
    
    NSArray *array = @[@"上个周期",@"下个周期"];
    for (int i = 0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+(__kScreenWidth-90)*i, 4.5, 70, 40);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = 100+i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        if (i == 0) {
            button.titleLabel.textAlignment = 0;
        }else{
            button.titleLabel.textAlignment = 2;
        }
        [button addTarget:self action:@selector(circleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [bottomView addSubview:button];
    }
}

#pragma mark =========上个周期、下个周期 点击
- (void)circleBtnClick:(UIButton *)sender
{
    if (sender.tag == 100) {
        NSLog(@"上个周期");
    }else{
        NSLog(@"下个周期");
    }
}

#pragma mark =========点击拍照
- (void)selectPhotobtnClick:(UIButton *)sender
{
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    [action showInView:self.view];
}

#pragma mark ========= UIActionSheet的代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUserDefaults *photoStyleDefaults = [NSUserDefaults standardUserDefaults];
    [photoStyleDefaults setValue:@"camera" forKey:@"photoStyleDefaults"];
    
    if (buttonIndex == 0) {
        //相机
        //判断是否可以打开相机，模拟器此功能无法使用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            TakePhotoVC *takephoto = [[TakePhotoVC alloc]init];
            [self.navigationController pushViewController:takephoto animated:YES];
        }else{
            //如果没有提示用户
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未检测到摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }else if(buttonIndex == 1){
        //相册
        
        [photoStyleDefaults setValue:@"photo" forKey:@"photoStyleDefaults"];
        
        _imagePicker = [[UIImagePickerController alloc]init];
        _imagePicker.delegate = self;
        _imagePicker.allowsEditing = NO;
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }
}

#pragma mark ========= UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    PhotoTweaksViewController *photoTweaksViewController = [[PhotoTweaksViewController alloc] initWithImage:image];
    photoTweaksViewController.delegate = self;
    photoTweaksViewController.autoSaveToLibray = YES;
    [picker pushViewController:photoTweaksViewController animated:YES];
}

//完成
- (void)photoTweaksController:(PhotoTweaksViewController *)controller didFinishWithCroppedImage:(UIImage *)croppedImage
{
    [controller.navigationController popToRootViewControllerAnimated:YES];
    [_imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    //选择结果
    TextResultVC *textResult = [[TextResultVC alloc]init];
    textResult.resultImage = croppedImage;
    textResult.delegate = self;
    [self.navigationController pushViewController:textResult animated:YES];
}

#pragma mark ========= TextResultVCDelegate
- (void)getTextResultWithImage:(UIImage *)image andTime:(NSString *)time andValue:(NSString *)value
{
    [_dataImgArray addObject:image];
    [_dataTimeArray addObject:time];
    [_dataValueArray addObject:value];
    
    //反色
//    UIImage *invertImg = [self invertFilter:image];
    [_invertImgArray addObject:image];
    
    _tableStyle = YES;
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:999];
    [imageView removeFromSuperview];
    
    [_tableView reloadData];
}

//取消
- (void)photoTweaksControllerDidCancel:(PhotoTweaksViewController *)controller
{
    [controller.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark ===================== 拍照结果

- (void)cameraEdit
{
    NSNotificationCenter *notifyCenter = [NSNotificationCenter defaultCenter];
    [notifyCenter addObserver:self selector:@selector(cameraResult:) name:@"camera" object:nil];
}

- (void)cameraResult:(NSNotification *)sender
{
    NSDictionary *userInfo = [sender userInfo];
    UIImage *image = [userInfo objectForKey:@"image"];
    NSString *time = [userInfo objectForKey:@"time"];
    NSString *value = [userInfo objectForKey:@"value"];
    
    [_dataImgArray addObject:image];
    [_dataTimeArray addObject:time];
    [_dataValueArray addObject:value];
    
    _tableStyle = YES;
    
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:999];
    [imageView removeFromSuperview];
    
    [_tableView reloadData];
}


#pragma mark ===================== 改变选择结果
- (void)changeTextValue
{
    NSNotificationCenter *notify = [NSNotificationCenter defaultCenter];
    [notify addObserver:self selector:@selector(changeResult:) name:@"changeTextPaper" object:nil];
}

- (void)changeResult:(NSNotification *)sender
{
    NSDictionary *userInfo = [sender userInfo];
    NSString *time = [userInfo objectForKey:@"time"];
    NSString *value = [userInfo objectForKey:@"value"];
    NSString *textId = [userInfo objectForKey:@"textId"];
    
    NSInteger idNum = [textId integerValue];
    [_dataValueArray replaceObjectAtIndex:idNum withObject:value];
    [_dataTimeArray replaceObjectAtIndex:idNum withObject:time];
    
    _tableStyle = YES;
    
    [_tableView reloadData];
}

#pragma mark ===================== 删除
- (void)deleteTextValue
{
    NSNotificationCenter *notify = [NSNotificationCenter defaultCenter];
    [notify addObserver:self selector:@selector(deleteResult:) name:@"deleteTextPaper" object:nil];
}

- (void)deleteResult:(NSNotification *)sender
{
    NSDictionary *userInfo = [sender userInfo];
    NSString *textId = [userInfo objectForKey:@"textId"];
    NSInteger idNum = [textId integerValue];
    
    [_dataTimeArray removeObjectAtIndex:idNum];
    [_dataValueArray removeObjectAtIndex:idNum];
    [_dataImgArray removeObjectAtIndex:idNum];
    
    if (_dataImgArray.count == 0) {
        _tableStyle = NO;
    }else{
        _tableStyle = YES;
    }
    
    [_tableView reloadData];
}

#pragma mark =========== tabelView的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tableStyle == NO) {
        return 4;
    }else{
        return _dataImgArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextPaperCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"TextPaperCell" owner:nil options:nil][0];
    }
    
    if (_tableStyle == YES) {
        cell.textView.backgroundColor = [UIColor whiteColor];
        
        if (_isInvert) {
            cell.textImgView.image = _invertImgArray[indexPath.row];
        }else{
            cell.textImgView.image = _dataImgArray[indexPath.row];
        }
        cell.textTimeLabel.text = _dataTimeArray[indexPath.row];
        cell.textValueLabel.text = _dataValueArray[indexPath.row];
    }else{
        cell.textView.backgroundColor = [UIColor clearColor];
    }
    
    cell.backgroundColor = BackgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //时间
    NSString *dateStr = _dataTimeArray[indexPath.row];
    //图片
    UIImage *image = _dataImgArray[indexPath.row];
    
    DeleteTextPaperVC *delete = [[DeleteTextPaperVC alloc]init];
    delete.textImage = image;
    delete.textResult = _dataValueArray[indexPath.row];
    delete.textTime = dateStr;
    delete.textId = indexPath.row;
    [self.navigationController pushViewController:delete animated:YES];
}

#pragma mark ======================== 反色
//- (UIImage *)invertFilter:(UIImage *)image
//{
//    GPUImageColorInvertFilter *filter = [[GPUImageColorInvertFilter alloc] init];
//    [filter forceProcessingAtSize:image.size];
//    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:image];
//    [pic addTarget:filter];
//    [pic processImage];
//    [filter useNextFrameForImageCapture];
//    
//    return [filter imageFromCurrentFramebuffer];
//}
@end
