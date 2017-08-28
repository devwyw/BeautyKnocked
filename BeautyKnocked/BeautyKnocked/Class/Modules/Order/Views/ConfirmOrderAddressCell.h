//
//  ConfirmOrderAddressCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@interface ConfirmOrderAddressCell : UITableViewCell
@property (nonatomic,strong) AddressModel * model;
@property (nonatomic,assign) BOOL isNull;
@end
