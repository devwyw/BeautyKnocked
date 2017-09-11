//
//  IntegraHeaderCell.h
//  BeautyKnocked
//
//  Created by Mac on 2017/9/11.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntegraListModel.h"

@interface IntegraHeaderCell : UITableViewCell
@property (nonatomic,strong) IntegraListModel * model;
@property (nonatomic,assign) BOOL isType;
@end
