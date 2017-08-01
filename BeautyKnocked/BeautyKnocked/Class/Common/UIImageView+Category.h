//
//  UIImageView+Category.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/10.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Category)

+(UIImageView *)leftUsernameImgViewW;

+(UIImageView *)leftPasswordImgViewW;

+(UIImageView *)createLeftImgViewWithImageName:(NSString *)imageName;
/** 虚线 */
-(UIImage *)drawLineImage:(NSInteger)length withLineHeight:(NSInteger)height withColor:(UIColor*)color;
@end
