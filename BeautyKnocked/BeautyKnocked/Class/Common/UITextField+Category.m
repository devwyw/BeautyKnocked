//
//  UITextField+Category.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "UITextField+Category.h"

@implementation UITextField (Category)

+(UITextField *)TextFieldWithBorderStyle:(UITextBorderStyle)borderStyle placeholder:(NSString *)placeholder {
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = borderStyle;
    textField.placeholder = placeholder;
    
    return textField;
}

+(UITextField *)textFieldWithPlaceholder:(NSString *)placeholder textSize:(CGFloat)textSize borderColor:(UIColor *)borderColor {
    
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleNone;
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:textSize];
    textField.layer.cornerRadius = 6.0f;
    textField.layer.borderWidth = 1.0f;
    textField.layer.borderColor = borderColor.CGColor;
    
    return textField;
    
}

@end
