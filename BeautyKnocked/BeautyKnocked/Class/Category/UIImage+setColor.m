//
//  UIImage+setColor.m
//  BeautyKnocked
//
//  Created by 王毅安 on 17/7/30.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "UIImage+setColor.h"

@implementation UIImage (setColor)

+(UIImage*)GetImageWithColor:(UIColor*)color andAlpha:(CGFloat)alpha andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color colorWithAlphaComponent:alpha].CGColor);
    CGContextFillRect(context, r);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
