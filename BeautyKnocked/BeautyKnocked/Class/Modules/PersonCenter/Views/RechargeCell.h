//
//  RechargeCell.h
//  BeautyKnocked
//
//  Created by 王毅安 on 17/8/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RechargeModel.h"
@class RACSignal;

@interface RechargeCell : UITableViewCell
@property (nonatomic,strong) RechargeModel * model;
@property (nonatomic,strong) RACSignal * push;
@end
