//
//  BeauticianModel.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/22.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeauticianModel : NSObject
/** 美容师列表 */
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * headPath;
@property (nonatomic,copy) NSString * introduce;
@property (nonatomic,copy) NSString * score;
@property (nonatomic,copy) NSString * collects;
@property (nonatomic,copy) NSString * isCollect;
@end
