//
//  DetailModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/14.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject
/** 项目详情 */
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * vipPrice;
@property (nonatomic,copy) NSString * serviceTime;
@property (nonatomic,copy) NSString * imagePath;
@property (nonatomic,copy) NSString * equippedProject;
@property (nonatomic,copy) NSString * effect;
@property (nonatomic,copy) NSString * forPeople;
@property (nonatomic,copy) NSString * payMatter;
@property (nonatomic,strong) NSArray * images;
@end
