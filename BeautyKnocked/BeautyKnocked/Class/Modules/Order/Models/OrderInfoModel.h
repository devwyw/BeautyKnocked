//
//  OrderInfoModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderInfoModel : NSObject
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * orderStr;
@property (nonatomic,copy) NSString * money;
@property (nonatomic,strong) NSArray * listArray;
@end
