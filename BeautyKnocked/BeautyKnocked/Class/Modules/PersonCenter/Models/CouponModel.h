//
//  CouponModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/18.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponModel : NSObject
/** 优惠券列表 */
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * money;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * commName;
@property (nonatomic,copy) NSString * startTime;
@property (nonatomic,copy) NSString * endTime;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,assign) BOOL isStatus;
@end
