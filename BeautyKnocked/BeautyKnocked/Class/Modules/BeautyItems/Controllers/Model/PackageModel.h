//
//  PackageModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PackageModel : NSObject
/** 套餐列表 */
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * imagePath;
@property (nonatomic,copy) NSString * buySecond;
@end
