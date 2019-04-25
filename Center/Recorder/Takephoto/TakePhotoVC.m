//
//  TakePhotoVC.m
//  CHLCalendar
//
//  Created by luomin on 16/2/29.
//  Copyright © 2016年 CHL. All rights reserved.
//

#import "TakePhotoVC.h"
#import "TextResultVC.h"
#import "HCGResultVC.h"
#import "Public.h"
#import "AlertLabel.h"

@interface TakePhotoVC ()
{
    UIView *_topView;
    UIView *_middleView;
    UIView *_bottomView;
    
    UIImage *_takePhotoImg;
}

//AVFoundation
//AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
@property (nonatomic, strong) AVCaptureSession* session;
//输入设备
@property (nonatomic, strong) AVCaptureDeviceInput* videoInput;
//照片输出流
@property (nonatomic, strong) AVCaptureStillImageOutput* stillImageOutput;
//预览图层
@property (nonatomic, strong) AVCaptureVideoPreviewLayer* previewLayer;
//背景View
@property(nonatomic,strong)UIView *backView;

@end

@implementation TakePhotoVC


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = YES;
    
    if (self.session) {
        
        [self.session startRunning];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
    
    if (self.session) {
        
        [self.session stopRunning];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = GrayColor;
    
    [self initAVCaptureSession];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark private method
- (void)initAVCaptureSession{
    
    self.session = [[AVCaptureSession alloc] init];
    
    NSError *error;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //更改这个设置的时候必须先锁定设备，修改完后再解锁，否则崩溃
    [device lockForConfiguration:nil];
    //设置闪光灯为自动
    [device setFlashMode:AVCaptureFlashModeAuto];
    [device unlockForConfiguration];
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    //输出设置。AVVideoCodecJPEG   输出jpeg格式图片
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    
    //初始化预览图层
    
    self.backView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.backView];
    
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    self.previewLayer.frame = CGRectMake(0, 0,__kScreenWidth, __kScreenHeight);
    self.backView.layer.masksToBounds = YES;
    [self.backView.layer addSublayer:self.previewLayer];
    
    [self createCoverView];
    
}

- (void)createCoverView
{
    //遮盖层
    //CGRectMake(0, __kScreenHeight/2.0-40, __kScreenWidth, 80)
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __kScreenWidth, 200)];
    _topView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
    [self.view addSubview:_topView];
    
    _middleView = [[UIView alloc]initWithFrame:CGRectMake(0, 200, __kScreenWidth, 80)];
    _middleView.backgroundColor = [UIColor clearColor];
    _middleView.layer.borderColor = NormalColor.CGColor;
    _middleView.layer.borderWidth = 2.0;
    [self.view addSubview:_middleView];
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 280, __kScreenWidth, __kScreenHeight-220)];
    _bottomView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
    [self.view addSubview:_bottomView];
    
    [self createCameraBtn];
}

- (void)createCameraBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelCamera) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:NormalColor forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 30, 40, 30);
    btn.backgroundColor = [UIColor clearColor];
    [_topView addSubview:btn];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, __kScreenWidth, 50)];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"请对齐拍摄框";
    label1.textAlignment = 1;
    label1.alpha = 0.8;
    label1.font = [UIFont boldSystemFontOfSize:24];
    label1.textColor = [UIColor whiteColor];
    [_topView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 110, __kScreenWidth-60, 60)];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"各品牌试纸测试结果有效时间略有不同，请认真查看试纸说明";
    label2.numberOfLines = 0;
    label2.textAlignment = 1;
    label2.alpha = 0.8;
    label2.textColor = [UIColor whiteColor];
    [_topView addSubview:label2];
    
    
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraBtn setImage:[UIImage imageNamed:@"cameranormal"] forState:UIControlStateNormal];
    [cameraBtn setImage:[UIImage imageNamed:@"camerawhite"] forState:UIControlStateHighlighted];
    [cameraBtn addTarget:self action:@selector(takePhotoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cameraBtn.frame = CGRectMake(__kScreenWidth/2.0-35, __kScreenHeight-370, 70, 70);
    cameraBtn.tag = 101;
    [_bottomView addSubview:cameraBtn];
}

- (void)cancelCamera
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (AVCaptureVideoOrientation)avOrientationForDeviceOrientation:(UIDeviceOrientation)deviceOrientation
{
    AVCaptureVideoOrientation result = (AVCaptureVideoOrientation)deviceOrientation;
    if ( deviceOrientation == UIDeviceOrientationLandscapeLeft )
        result = AVCaptureVideoOrientationLandscapeRight;
    else if ( deviceOrientation == UIDeviceOrientationLandscapeRight )
        result = AVCaptureVideoOrientationLandscapeLeft;
    return result;
}

#pragma mark ================= 拍照 ========================
- (void)takePhotoButtonClick:(UIButton *)sender {
    
    NSUserDefaults *paperStyle = [NSUserDefaults standardUserDefaults];
    NSString *paperStyleStr = [paperStyle valueForKey:@"paperStyle"];
    
    AVCaptureConnection *stillImageConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    UIDeviceOrientation curDeviceOrientation = [[UIDevice currentDevice] orientation];
    AVCaptureVideoOrientation avcaptureOrientation = [self avOrientationForDeviceOrientation:curDeviceOrientation];
    [stillImageConnection setVideoOrientation:avcaptureOrientation];
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:stillImageConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        
        NSData *jpegData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        CFDictionaryRef attachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault,
                                                                    imageDataSampleBuffer,
                                                                    kCMAttachmentMode_ShouldPropagate);
        
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied){
            //无权限
            return ;
        }
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeImageDataToSavedPhotosAlbum:jpegData metadata:(__bridge id)attachments completionBlock:^(NSURL *assetURL, NSError *error) {
            
            _takePhotoImg = [UIImage imageWithData:jpegData];
            
//            NSLog(@"=====%@",_takePhotoImg);
            float imageWidth = _takePhotoImg.size.width;
            float imageHeight = _takePhotoImg.size.height;
            
            CGImageRef imageRef = CGImageCreateWithImageInRect(_takePhotoImg.CGImage, CGRectMake(200/__kScreenHeight*imageHeight, 0, (80/__kScreenHeight)*imageHeight, imageWidth));
            UIImage *apartImage = [UIImage imageWithCGImage:imageRef scale:1 orientation:UIImageOrientationRight];
            CGImageRelease(imageRef);
            
            //选择结果
            if ([paperStyleStr isEqualToString:@"HCGpaper"]) {
                HCGResultVC *hcgResult = [[HCGResultVC alloc]init];
                hcgResult.resultImage = apartImage;
                [self.navigationController pushViewController:hcgResult animated:YES];
            }else{
                TextResultVC *textResult = [[TextResultVC alloc]init];
                textResult.resultImage = apartImage;
                [self.navigationController pushViewController:textResult animated:YES];
            }
        }];
    }];
}


#pragma mark ================= 旋转照片方向
- (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;

    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }

    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);

    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);

    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();

    return newPic;
}

@end
