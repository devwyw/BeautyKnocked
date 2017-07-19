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

@end
