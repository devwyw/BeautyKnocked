//
//  ConfirmOrderProductCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductModel;
@class RACSubject;

@interface ConfirmOrderProductCell : UITableViewCell
@property (nonatomic,strong) ProductModel * model;
@property (nonatomic,strong) RACSubject * subCount;
@end
