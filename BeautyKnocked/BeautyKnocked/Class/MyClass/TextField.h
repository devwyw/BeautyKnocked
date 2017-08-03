//
//  TextField.h
//  BeautyKnocked
//
//  Created by Mac on 2017/7/31.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextField : UITextField
/** 边框类型-占位符 */
+(TextField *)TextFieldWithBorderStyle:(UITextBorderStyle)borderStyle placeholder:(NSString *)placeholder;
/** 占位符-字体Size-边框颜色 */
+(TextField *)textFieldWithPlaceholder:(NSString *)placeholder textSize:(CGFloat)textSize borderColor:(UIColor *)borderColor;

@end
