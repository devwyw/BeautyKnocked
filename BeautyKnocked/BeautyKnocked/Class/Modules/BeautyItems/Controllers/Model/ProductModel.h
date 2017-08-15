//
//  ProductModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject
/** 产品详情 */
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * vipPrice;
@property (nonatomic,copy) NSString * imagePath;
@property (nonatomic,copy) NSString * capacity;
@property (nonatomic,copy) NSString * address;
@property (nonatomic,copy) NSString * dateLength;
@property (nonatomic,copy) NSString * effect;
@property (nonatomic,copy) NSString * forPeople;
@property (nonatomic,copy) NSString * useMethod;
@end
