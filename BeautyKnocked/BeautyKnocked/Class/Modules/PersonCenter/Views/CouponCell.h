//
//  CouponCell.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponModel.h"
@class RACSignal;

@interface CouponCell : UITableViewCell
@property (nonatomic,strong) CouponModel * model;
@property (nonatomic,strong) RACSignal * useCoupon;
@end
