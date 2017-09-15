//
//  OrderInfoListModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/9/12.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderInfoListModel : NSObject
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * imagePath;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * num;
@property (nonatomic,copy) NSString * money;
@property (nonatomic,copy) NSString * isUse;
@end
