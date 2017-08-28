//
//  OrderSubTime.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayModel.h"
@class RACSubject;

@interface OrderSubTime : UIView
@property (nonatomic,strong) DayModel * startModel;
@property (nonatomic,strong) RACSubject * subData;

@property (nonatomic,copy) NSString *selectedDate;
@property (nonatomic,copy) NSString * selectTime;
@property (nonatomic,strong) NSArray * listArray;
@end
