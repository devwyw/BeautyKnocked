//
//  MLDateManager.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLDateModel.h"
@interface MLDateManager : NSObject

+(NSArray *)fetchDate;

+(NSArray *)fetchOneDayTime;

@end
