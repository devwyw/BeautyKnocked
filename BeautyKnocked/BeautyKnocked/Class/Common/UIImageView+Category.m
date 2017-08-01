//
//  UIImageView+Category.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/10.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "UIImageView+Category.h"

@implementation UIImageView (Category)

+(UIImageView *)leftUsernameImgViewW {
    UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [leftImgView setImage:[UIImage imageNamed:@"yonghu_03"]];
    leftImgView.contentMode = UIViewContentModeRight;
    return leftImgView;
}

+(UIImageView *)leftPasswordImgViewW {
    UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [leftImgView setImage:[UIImage imageNamed:@"yanzhengma_03"]];
    leftImgView.contentMode = UIViewContentModeRight;
    return leftImgView;
}

+(UIImageView *)createLeftImgViewWithImageName:(NSString *)imageName {
    UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [leftImgView setImage:[UIImage imageNamed:imageName]];
    leftImgView.contentMode = UIViewContentModeRight;
    return leftImgView;
}
-(UIImage *)drawLineImage:(NSInteger)length withLineHeight:(NSInteger)height withColor:(UIColor*)color{
    UIGraphicsBeginImageContext(self.frame.size); //开始画线
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // length是每个虚线的长度 height是高度
    CGFloat lengths[] = {length,height};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, color.CGColor);
    CGContextSetLineDash(line, 0, lengths, 2); //画虚线
    CGContextMoveToPoint(line, 0.0, 2.0); //开始画线
    CGContextAddLineToPoint(line, Width - 10, 2.0);
    CGContextStrokePath(line);

    return UIGraphicsGetImageFromCurrentImageContext();
}
@end
