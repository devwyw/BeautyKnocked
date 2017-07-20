//
//  DocumentsManager.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "DocumentsManager.h"

static DocumentsManager *instance=nil;

@implementation DocumentsManager


/** 重写allocWithZone */
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [super allocWithZone:zone];
        }
    });
    return instance;
}
/** 重写copyWithZone */
-(id)copyWithZone:(NSZone *)zone
{
    return instance;
}
/** 重写mutableCopyWithZone */
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return instance;
}
/** 单例方法 */
+(instancetype)shareManager{
    return [DocumentsManager new];
}
+(UIButton*)getCarViewWithOrigin:(CGPoint)point{
    UIButton *Car=[[UIButton alloc]initWithFrame:CGRectMake(point.x, point.y, 60, 60)];
    [Car setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [Car setImage:[UIImage imageNamed:@"gouwuche_03"] forState:UIControlStateNormal];

    UILabel *carCount=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [carCount setText:@"99+"];
    [carCount setFont:[UIFont systemFontOfSize:10]];
    [carCount setTextAlignment:NSTextAlignmentCenter];
    [carCount setTextColor:[UIColor whiteColor]];
    [carCount setBackgroundColor:[UIColor blackColor]];
    [carCount.layer setCornerRadius:11];
    [carCount.layer setMasksToBounds:YES];
    [Car addSubview:carCount];
    return Car;
}

@end
