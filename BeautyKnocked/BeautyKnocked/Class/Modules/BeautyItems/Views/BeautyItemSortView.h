//
//  BeautyItemSortView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/18.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ItemsSortViewDelegate <NSObject>
-(void)didSelectedButton:(UIButton *)button;
-(void)didSelectWithRow:(NSUInteger)row;
@end

@interface BeautyItemSortView : UIView

@property (nonatomic, assign) BOOL entiryExpand;
@property (nonatomic, weak) id<ItemsSortViewDelegate> delegate;

@end
