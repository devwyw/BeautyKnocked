//
//  PackageInfoModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PackageInfoModel : NSObject
/** 套餐详情 */
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * projectId;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * imagePath;
@property (nonatomic,copy) NSString * equippedProject;
@property (nonatomic,copy) NSString * effect;
@property (nonatomic,copy) NSString * forPeople;
@property (nonatomic,copy) NSString * payMatter;
@property (nonatomic,strong) NSArray * images;
@end
