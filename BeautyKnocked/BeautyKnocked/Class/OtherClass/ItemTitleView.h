//
//  ItemTitleView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/13.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemTitleView : UIView

@property (nonatomic, copy) NSString *leftImageName;

@property (nonatomic, copy) NSString *titleName;

@property (nonatomic, copy) NSString *rightImageName;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIFont *titleFont;

@end
