//
//  AddAndReserveView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSignal;

@interface AddAndReserveView : UIView

@property (nonatomic,strong) RACSignal *reserveNowSignal;
@property (nonatomic,strong) RACSignal *addCar;
@property (nonatomic,copy) NSString * type;
@end
