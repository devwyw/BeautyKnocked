//
//  UIColor+help.h
//  DemoAntiAliasing
//
//  Created by 伍宏彬 on 15/11/9.
//  Copyright © 2015年 HB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (help)
/** 十六进制->Color */
+ (UIColor *)colorWithHexString:(NSString *)color;
/** 十六进制->Color-alpha */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
/** Color->十六进制 */
-(NSString *)toColorString;
@end

