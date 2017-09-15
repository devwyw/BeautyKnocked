//
//  BeauticianCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/11.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeauticianModel.h"
@class RACSignal;

@interface BeauticianCell : UITableViewCell

@property (nonatomic,strong) RACSignal * collect;
@property (nonatomic,strong) RACSignal * reserve;
@property (nonatomic,strong) RACSignal * beaSelect;
@property (nonatomic,assign) BOOL isCancel;
@property (nonatomic,strong) BeauticianModel * model;
@property (nonatomic,assign) BOOL isBeauticianSelect;
@end
