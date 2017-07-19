//
//  NewsCenterModel.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsCenterModel : NSObject

@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *descr;

-(instancetype)initWithImageName:(NSString *)imageName sign:(NSString *)sign title:(NSString *)title descr:(NSString *)descr;

@end
