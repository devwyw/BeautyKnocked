//
//  PackageOrderModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/9/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PackageOrderModel : NSObject
/** 套餐订单 */
@property (nonatomic,copy) NSString * clientId;
@property (nonatomic,copy) NSString * beauticianId;
@property (nonatomic,copy) NSString * packageIds;
@property (nonatomic,copy) NSString * payType;
@property (nonatomic,copy) NSString * ip;
@end
