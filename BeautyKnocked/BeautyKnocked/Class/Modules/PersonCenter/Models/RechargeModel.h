//
//  RechargeModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RechargeModel : NSObject
/** 充值列表 */
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * rank;
@property (nonatomic,copy) NSString * money;
@property (nonatomic,copy) NSString * discount;
@property (nonatomic,copy) NSString * give;
@property (nonatomic,copy) NSString * num;
@property (nonatomic,copy) NSString * choose;
@property (nonatomic,strong) NSMutableArray * list;
@property (nonatomic,assign) BOOL isSelected;
@end
