//
//  ConfirmOrderItemCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfoListModel.h"
@class DetailModel;
@class PackageInfoModel;

@interface ConfirmOrderItemCell : UITableViewCell

@property (nonatomic,strong) DetailModel * model;
@property (nonatomic,strong) PackageInfoModel * Pmodel;
@property (nonatomic,strong) OrderInfoListModel * infoModel;
@end
