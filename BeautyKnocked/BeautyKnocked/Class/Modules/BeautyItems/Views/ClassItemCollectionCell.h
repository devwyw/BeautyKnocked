//
//  ClassItemCollectionCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/18.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemClassModel.h"
#import "PackageModel.h"

@interface ClassItemCollectionCell : UICollectionViewCell

@property (nonatomic,strong) ItemClassModel * model;
@property (nonatomic,strong) PackageModel * Pmodel;
@end
