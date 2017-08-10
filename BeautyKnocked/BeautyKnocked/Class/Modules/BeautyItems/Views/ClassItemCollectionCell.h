//
//  ClassItemCollectionCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/18.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemClassModel;

@interface ClassItemCollectionCell : UICollectionViewCell

+(instancetype)itemWithCollectionView:(UICollectionView*)collection WithIndexPath:(NSIndexPath*)indexPath WithModel:(ItemClassModel*)model;

@end
