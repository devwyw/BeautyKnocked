//
//  FilterCollectionViewCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/24.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *itemName;

@property (nonatomic, assign) BOOL highLight;

@property (nonatomic, strong) UIColor *itemTextColor;

@end
