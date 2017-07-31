//
//  TextField.h
//  BeautyKnocked
//
//  Created by Mac on 2017/7/31.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextField : UITextField

+(TextField *)TextFieldWithBorderStyle:(UITextBorderStyle)borderStyle placeholder:(NSString *)placeholder;

+(TextField *)textFieldWithPlaceholder:(NSString *)placeholder textSize:(CGFloat)textSize borderColor:(UIColor *)borderColor;

@end
