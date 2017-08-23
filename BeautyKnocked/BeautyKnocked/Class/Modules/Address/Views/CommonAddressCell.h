//
//  CommonAddressCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/5.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;

@interface CommonAddressCell : UITableViewCell

@property (nonatomic,strong) AddressModel * model;
@property (nonatomic,strong) RACSignal *addressEditSignal;
@property (nonatomic,strong) RACSignal *addressDeleteSignal;

@end
