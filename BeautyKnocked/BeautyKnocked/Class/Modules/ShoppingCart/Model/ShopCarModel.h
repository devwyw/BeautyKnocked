//
//  ShopCarModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/9/14.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarInfoModel.h"

@interface ShopCarModel : NSObject

@property (nonatomic,copy) NSString * id;
@property (nonatomic,strong) CarInfoModel * pv;
@property (nonatomic,copy) NSString * num;
@property (nonatomic,assign) BOOL isSelect;
@property (nonatomic,assign) BOOL isEdit;
@property (nonatomic,copy) NSString * count;
@end
