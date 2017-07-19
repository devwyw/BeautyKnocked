//
//  NewsCenterModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "NewsCenterModel.h"

@implementation NewsCenterModel

-(instancetype)initWithImageName:(NSString *)imageName sign:(NSString *)sign title:(NSString *)title descr:(NSString *)descr {
    self =[super init];
    if (self) {
        self.imgName = imageName;
        self.sign = sign;
        self.title = title;
        self.descr = descr;
    }
    return self;
    
}

@end
