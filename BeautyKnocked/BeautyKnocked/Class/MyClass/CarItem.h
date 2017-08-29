//
//  CarItem.h
//  BeautyKnocked
//
//  Created by 王毅安 on 17/8/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSignal;

@interface CarItem : UIView
-(instancetype)initWithOriginY:(CGFloat)y;
@property (nonatomic,strong) RACSignal * pushCar;
@property (nonatomic,assign) NSInteger count;
@end
