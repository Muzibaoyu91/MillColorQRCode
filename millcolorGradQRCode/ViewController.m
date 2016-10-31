//
//  ViewController.m
//  millcolorGradQRCode
//
//  Created by Baoyu on 2016/10/31.
//  Copyright © 2016年 Baoy. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeGenerator.h"
#import "UIImage+instask.h"


@interface ViewController ()

@property (nonatomic, strong) UIImageView *QRImgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.QRImgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:_QRImgView];
    self.QRImgView.userInteractionEnabled = YES;
    [self.QRImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveImg)]];

    //  0.      生成二维码
    NSString *QRString = @"http://www.baidu.com";
    //  topimg 指的是二维码中间的小图片
    UIImage *img = [QRCodeGenerator qrImageForString:QRString imageSize:1000 Topimg:nil withColor:[UIColor blackColor]];
    
    //  1.      生成渐变色color
    //  左上角红色到右下角灰色的渐变色
    UIColor *topleftColor = [UIColor redColor];
    UIColor *bottomrightColor = [UIColor yellowColor];
    //  生成这样一个渐变色的图片
    UIImage *bgImg = [img gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeUpleftToLowright imgSize:img.size];
    //  通过这个图片得到一个color
    UIColor *color = [UIColor colorWithPatternImage:bgImg];

    //  2.      将图片渲染上渐变色color
    self.QRImgView.image = [img rt_tintedImageWithColor:color];
    
    
}

//  保存图片
- (void)saveImg{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存二维码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //  保存图片
        UIImageWriteToSavedPhotosAlbum(self.QRImgView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //  取消
    }];
    [alertC addAction:saveAction];
    [alertC addAction:cancelAction];
    [self presentViewController:alertC animated:YES completion:^{
        
    }];
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (!error) {
        NSLog(@"保存成功");
    }else{
        NSLog(@"保存失败");
    }
}

@end
