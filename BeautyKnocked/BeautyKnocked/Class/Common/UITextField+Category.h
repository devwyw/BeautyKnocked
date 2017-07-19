//
//  UITextField+Category.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Category)

+(UITextField *)TextFieldWithBorderStyle:(UITextBorderStyle)borderStyle placeholder:(NSString *)placeholder;

+(UITextField *)textFieldWithPlaceholder:(NSString *)placeholder textSize:(CGFloat)textSize borderColor:(UIColor *)borderColor;

@end
