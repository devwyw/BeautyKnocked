//
//  MLDateCollectionViewCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLDateCollectionViewCell : UICollectionViewCell

/**
 first line text
 */
@property (nonatomic, copy) NSString *dateNumber;

/**
 second line text
 */
@property (nonatomic, copy) NSString *content;
/**
 first line color
 */
@property (nonatomic, strong) UIColor *numberColor;
/**
 second line color
 */
@property (nonatomic, strong) UIColor *contentColor;

@end
