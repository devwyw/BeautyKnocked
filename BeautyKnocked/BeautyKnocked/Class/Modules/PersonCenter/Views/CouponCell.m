//
//  CouponCell.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "CouponCell.h"

@interface CouponCell ()

@end
//youhuiquan-keyong@2x
@implementation CouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
/*
 以下三点结论基于未旋转的情况：
 1.当参数x>0 && x<=M_PI时,为顺时针
 2.当参数x>-M_PI && x<0时,为逆时针
 总结：旋转方向就是向最短路径方向旋转
 */
//but.transform = CGAffineTransformMakeRotation(-M_PI_4);
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
