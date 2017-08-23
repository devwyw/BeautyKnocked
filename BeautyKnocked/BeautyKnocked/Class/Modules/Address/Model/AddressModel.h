//
//  AddressModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/21.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
/** 服务地址 */
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * phone;
@property (nonatomic,copy) NSString * address;
@property (nonatomic,copy) NSString * isDefault;
@end
