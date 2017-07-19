//
//  MLDateModel.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLDateModel : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger week;
@property (nonatomic, assign) BOOL isInThirtyDays;

-(instancetype)initWithComponents:(NSDateComponents *)components;

@end
