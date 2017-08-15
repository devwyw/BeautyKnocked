//
//  ItemClassModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/9.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemClassModel : NSObject
/** 项目列表 */
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * vipPrice;
@property (nonatomic,copy) NSString * imagePath;
@property (nonatomic,copy) NSString * buySecond;
@end
