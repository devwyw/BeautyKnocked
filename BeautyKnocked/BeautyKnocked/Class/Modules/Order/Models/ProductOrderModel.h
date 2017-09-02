//
//  ProductOrderModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/9/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductOrderModel : NSObject
/** 产品订单 */
@property (nonatomic,copy) NSString * clientId;
@property (nonatomic,copy) NSString * beauticianId;
@property (nonatomic,copy) NSString * addressId;
@property (nonatomic,copy) NSString * productIds;
@property (nonatomic,copy) NSString * payType;
@property (nonatomic,copy) NSString * clientCouponId;
@property (nonatomic,copy) NSString * expressMode;
@property (nonatomic,copy) NSString * remark;
@property (nonatomic,copy) NSString * ip;
@end
