//
//  ExchangeRecordingCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntegraListModel.h"

@interface ExchangeRecordingCell : UITableViewCell
@property (nonatomic,strong) IntegraListModel * model;
@property (nonatomic,assign) BOOL isType;
@end
