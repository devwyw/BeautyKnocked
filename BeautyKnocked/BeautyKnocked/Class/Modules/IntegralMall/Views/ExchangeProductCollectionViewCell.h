//
//  ExchangeProductCollectionViewCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/7.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IntegraListModel;

@interface ExchangeProductCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) IntegraListModel * model;
@property (nonatomic,assign) BOOL isType;
@end
