//
//  MenuItemView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/12.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuItemViewDelegate <NSObject>

-(void)menuItemViewTitleSelect:(NSUInteger)index andMtag:(NSInteger)tag;

@end

@interface MenuItemView : UIView

@property (nonatomic, weak) id<MenuItemViewDelegate> delegate;

/**
 collectionView configure
 */
@property (nonatomic, assign) NSUInteger count;

@property (nonatomic, assign) CGFloat menuHeight;

@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, assign) UIEdgeInsets cellEdgeInsets;

@property (nonatomic, assign) CGFloat interitemSpacing;

@property (nonatomic, assign) CGFloat lineSpacing;

/**
 mennuItem configure
 */
@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, assign) CGSize imgeViewSize;

@property (nonatomic, assign) CGFloat topDistance;

@property (nonatomic, assign) CGFloat middleDistance;

@property (nonatomic, assign) CGFloat bottomDistance;

@property (nonatomic, strong) NSArray *dataArray;

/** 标识符 */
@property (nonatomic,assign) NSInteger Mtag;

@end
