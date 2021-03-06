//
//  UIView+CornerRadius.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "UIView+CornerRadius.h"

@implementation UIView (CornerRadius)
-(void)makeCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}
-(void)makeBorderWidth:(CGFloat)width withColor:(UIColor*)color{
    self.layer.borderWidth=width;
    self.layer.borderColor=color.CGColor;
}
-(void)makeShadowOffset:(CGSize)make;{
    self.layer.shadowColor=[UIColor blackColor].CGColor;
    self.layer.shadowOffset=make;
    self.layer.shadowOpacity = 0.35f;
    self.layer.shadowRadius = 2;
}
@end
