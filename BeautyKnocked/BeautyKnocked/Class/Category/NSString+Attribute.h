//
//  NSString+Attribute.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Attribute)

/** 折扣价格-原价 */
-(NSMutableAttributedString *)setRedPrice:(NSString *)redPrice linePrice:(NSString *)linePrice;
-(BOOL)isMobileNumber;
@end
