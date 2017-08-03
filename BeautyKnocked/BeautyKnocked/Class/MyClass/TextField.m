//
//  TextField.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/31.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "TextField.h"

@implementation TextField

+(TextField *)textFieldWithPlaceholder:(NSString *)placeholder textSize:(CGFloat)textSize borderColor:(UIColor *)borderColor{
    TextField *textField = [[TextField alloc] init];
    textField.borderStyle = UITextBorderStyleNone;
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:textSize];
    [textField makeCornerRadius:5];
    [textField makeBorderWidth:0.5 withColor:borderColor];
    return textField;
}

+(TextField *)TextFieldWithBorderStyle:(UITextBorderStyle)borderStyle placeholder:(NSString *)placeholder {
    TextField *textField = [[TextField alloc]init];
    textField.borderStyle = borderStyle;
    textField.placeholder = placeholder;
    return textField;
}

-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    return CGRectMake(10, 0 , bounds.size.width, bounds.size.height);
}
-(CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(10, 0 , bounds.size.width, bounds.size.height);;
}
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectMake(10, 0 , bounds.size.width, bounds.size.height);;
}
@end
