//
//  UIImage+Original.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "UIImage+Original.h"

@implementation UIImage (Original)

+(UIImage *)imageOriginalImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
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
