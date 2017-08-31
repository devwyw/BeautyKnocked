//
//  OrderModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/22.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject
/** 项目订单 */
@property (nonatomic,copy) NSString * clientId;
@property (nonatomic,copy) NSString * beauticianId;
@property (nonatomic,copy) NSString * addressId;
@property (nonatomic,copy) NSString * projectIds;
@property (nonatomic,copy) NSString * payType;
@property (nonatomic,copy) NSString * clientCouponId;
@property (nonatomic,copy) NSString * pactServiceTime;
@property (nonatomic,copy) NSString * serviceTime;
@property (nonatomic,copy) NSString * remark;
@property (nonatomic,copy) NSString * ip;
@end
