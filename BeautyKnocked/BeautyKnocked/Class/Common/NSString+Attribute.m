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

@end
