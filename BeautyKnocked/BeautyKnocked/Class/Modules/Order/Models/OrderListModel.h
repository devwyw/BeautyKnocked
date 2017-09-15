//
//  OrderListModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/9/12.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderListModel : NSObject
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * commType;
@property (nonatomic,copy) NSString * createDate;
@property (nonatomic,copy) NSString * pactServiceTime;
@property (nonatomic,copy) NSString * serviceAddress;
@property (nonatomic,copy) NSString * beauticianId;
@property (nonatomic,copy) NSString * beauticianName;
@property (nonatomic,copy) NSString * money;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,strong) NSArray * list;
@end
