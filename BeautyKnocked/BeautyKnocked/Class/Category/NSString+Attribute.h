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
/** 手机号判断 */
-(BOOL)isMobileNumber;
/** Min&Max字体 */
-(NSMutableAttributedString *)setMinString:(NSString*)minStr withMinFont:(CGFloat)min andMaxString:(NSString*)maxStr withMaxFont:(CGFloat)max;
@end
