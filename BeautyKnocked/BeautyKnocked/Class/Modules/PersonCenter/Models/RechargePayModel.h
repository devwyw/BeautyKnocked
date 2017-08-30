//
//  RechargePayModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/30.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RechargePayModel : NSObject
@property (nonatomic,copy) NSString * device;
@property (nonatomic,copy) NSString * clientId;
@property (nonatomic,copy) NSString * beauticianId;
@property (nonatomic,copy) NSString * payType;
@property (nonatomic,copy) NSString * rechargeId;
@end
