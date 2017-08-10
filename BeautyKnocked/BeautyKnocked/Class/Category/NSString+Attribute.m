//
//  NSString+Attribute.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "NSString+Attribute.h"

@implementation NSString (Attribute)

-(NSMutableAttributedString *)setRedPrice:(NSString *)redPrice linePrice:(NSString *)linePrice {
    NSRange redRange = [self rangeOfString:redPrice];
    NSRange lineRange = [self rangeOfString:linePrice];
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:self];
    // red text
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    // delete line
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSBaselineOffsetAttributeName:@(0),NSStrikethroughColorAttributeName:[UIColor lightGrayColor]} range:lineRange];
    
    return attributeStr;
}
-(BOOL)isMobileNumber{
    //正则表达式匹配11位手机号码
    NSString *regex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    if(isMatch) {
        return YES;
    }else{
        return NO;
    }
}
@end
