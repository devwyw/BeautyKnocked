//
//  BeauticianCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/11.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSignal;
@class BeauticianModel;

@interface BeauticianCell : UITableViewCell

@property (nonatomic,strong) RACSignal * collect;
@property (nonatomic,strong) RACSignal * reserve;
@property (nonatomic,strong) RACSignal * beaSelect;
@property (nonatomic,strong) BeauticianModel * model;
@property (nonatomic,assign) BOOL isBeauticianSelect;
@end
