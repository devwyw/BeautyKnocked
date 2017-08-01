//
//  UIView+CornerRadius.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CornerRadius)
/** 设置圆角 */
-(void)makeCornerRadius:(CGFloat)cornerRadius;
/** 设置边框 */
-(void)makeBorderWidth:(CGFloat)width withColor:(UIColor*)color;

@end
