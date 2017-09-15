//
//  OrderTableViewCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/19.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"
@class RACSubject;
@class RACSignal;

@interface OrderTableViewCell : UITableViewCell
@property (nonatomic,strong) OrderListModel * model;
@property (nonatomic,strong) RACSubject * subPush;
@property (nonatomic,strong) RACSignal * subLeft;
@property (nonatomic,strong) RACSignal * subRight;
@end
