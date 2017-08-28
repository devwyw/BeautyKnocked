//
//  OrderSubDay.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebTimeModel.h"
#import "DayModel.h"
#import <LEEAlert.h>
@class RACSubject;

@interface OrderSubDay : UIView
+(instancetype)shareManager;
@property (nonatomic,strong) WebTimeModel * model;
@property (nonatomic,strong) DayModel * startDay;
@property (nonatomic,strong) RACSubject * subData;
@end
