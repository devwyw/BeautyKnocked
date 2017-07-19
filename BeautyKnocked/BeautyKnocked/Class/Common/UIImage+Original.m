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

@end
