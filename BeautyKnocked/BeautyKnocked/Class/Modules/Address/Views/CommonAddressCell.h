//
//  CommonAddressCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/5.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonAddressCell : UITableViewCell

@property (nonatomic, copy) NSString *address;

@property (nonatomic, strong) RACSignal *addressEditSignal;
@property (nonatomic, strong) RACSignal *addressDeleteSignal;

@end
