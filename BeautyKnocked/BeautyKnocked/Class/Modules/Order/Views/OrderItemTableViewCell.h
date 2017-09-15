//
//  OrderItemTableViewCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/19.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfoListModel.h"

@interface OrderItemTableViewCell : UITableViewCell
@property (nonatomic,assign) BOOL isProduct;
@property (nonatomic,strong) OrderInfoListModel * model;
@property (nonatomic,copy) NSString * time;
@property (nonatomic,copy) NSString * addRess;
@end
