//
//  MenuItemCollectionCell.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/12.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemCollectionCell : UICollectionViewCell

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, strong) NSString *imageUrl;

@property (nonatomic, strong) NSString *menuItemName;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, assign) CGSize imgeViewSize;

@property (nonatomic, assign) CGFloat topDistance;

@property (nonatomic, assign) CGFloat middleDistance;

@property (nonatomic, assign) CGFloat bottomDistance;

@end
