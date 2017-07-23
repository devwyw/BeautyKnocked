//
//  MLDateModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MLDateModel.h"

@implementation MLDateModel

-(instancetype)initWithComponents:(NSDateComponents *)components {
    self = [super init];
    if (self) {
        self.year = components.year;
        self.month = components.month;
        self.day = components.day;
        self.week =components.weekday;
        self.date = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)self.year,(long)self.month,self.day];
    }
    return self;
}

@end
