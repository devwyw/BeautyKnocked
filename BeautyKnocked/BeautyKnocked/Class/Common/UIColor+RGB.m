//
//  UIColor+RGB.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/19.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "UIColor+RGB.h"

@implementation UIColor (RGB)

+(UIColor *)ddcs_colorWithRed:(CGFloat )red green:(CGFloat )green blue:(CGFloat )blue alpha:(CGFloat )alpha {
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha / 1.0];
}

@end
