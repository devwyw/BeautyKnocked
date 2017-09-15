//
//  SystemMessageModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/9/13.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemMessageModel : NSObject
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * createDate;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * status;
@end
