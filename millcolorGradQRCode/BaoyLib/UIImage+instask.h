//
//  UIImage+instask.h
//  Instask_objC
//
//  Created by Baoyu on 16/7/25.
//  Copyright © 2016年 Instask.Me. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到小
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};

@interface UIImage (instask)


-(UIImage*)rt_tintedImageWithColor:(UIColor*)color;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color level:(CGFloat)level;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect level:(CGFloat)level;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets level:(CGFloat)level;

-(UIImage*)rt_lightenWithLevel:(CGFloat)level;
-(UIImage*)rt_lightenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
-(UIImage*)rt_lightenRect:(CGRect)rect withLevel:(CGFloat)level;

-(UIImage*)rt_darkenWithLevel:(CGFloat)level;
-(UIImage*)rt_darkenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
-(UIImage*)rt_darkenRect:(CGRect)rect withLevel:(CGFloat)level;

- (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;


@end
