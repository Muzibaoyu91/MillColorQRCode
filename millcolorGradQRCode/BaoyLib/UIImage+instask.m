//
//  UIImage+instask.m
//  Instask_objC
//
//  Created by Baoyu on 16/7/25.
//  Copyright © 2016年 Instask.Me. All rights reserved.
//

#import "UIImage+instask.h"
#import <UIKit/UIKit.h>

@implementation UIImage (instask)

// Tint: Color
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color {
    return [self rt_tintedImageWithColor:color level:1.0f];
}

// Tint: Color + level
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color level:(CGFloat)level {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    return [self rt_tintedImageWithColor:color rect:rect level:level];
}

// Tint: Color + Rect
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect {
    return [self rt_tintedImageWithColor:color rect:rect level:1.0f];
}

// Tint: Color + Rect + level
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect level:(CGFloat)level {
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self drawInRect:imageRect];
    
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextSetAlpha(ctx, level);
    CGContextSetBlendMode(ctx, kCGBlendModeSourceAtop);
    CGContextFillRect(ctx, rect);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *darkImage = [UIImage imageWithCGImage:imageRef
                                             scale:self.scale
                                       orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    UIGraphicsEndImageContext();
    
    return darkImage;
}

// Tint: Color + Insets
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets {
    return [self rt_tintedImageWithColor:color insets:insets level:1.0f];
}

// Tint: Color + Insets + level
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets level:(CGFloat)level {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    return [self rt_tintedImageWithColor:color rect:UIEdgeInsetsInsetRect(rect, insets) level:level];
}

// Light: Level
-(UIImage*)rt_lightenWithLevel:(CGFloat)level {
    return [self rt_tintedImageWithColor:[UIColor whiteColor] level:level];
}

// Light: Level + Insets
-(UIImage*)rt_lightenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets {
    return [self rt_tintedImageWithColor:[UIColor whiteColor] insets:insets level:level];
}

// Light: Level + Rect
-(UIImage*)rt_lightenRect:(CGRect)rect withLevel:(CGFloat)level {
    return [self rt_tintedImageWithColor:[UIColor whiteColor] rect:rect level:level];
}

// Dark: Level
-(UIImage*)rt_darkenWithLevel:(CGFloat)level {
    return [self rt_tintedImageWithColor:[UIColor blackColor] level:level];
}

// Dark: Level + Insets
-(UIImage*)rt_darkenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets {
    return [self rt_tintedImageWithColor:[UIColor blackColor] insets:insets level:level];
}

// Dark: Level + Rect
-(UIImage*)rt_darkenRect:(CGRect)rect withLevel:(CGFloat)level {
    return [self rt_tintedImageWithColor:[UIColor blackColor] rect:rect level:level];
}


- (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case GradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case GradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        case GradientTypeUpleftToLowright:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, imgSize.height);
            break;
        case GradientTypeUprightToLowleft:
            start = CGPointMake(imgSize.width, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

@end
