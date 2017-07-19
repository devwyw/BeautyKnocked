//
//  PSSortDropMenu.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/24.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PSSortDropMenuDelegate <NSObject>

-(void)didSelectAtRow:(NSUInteger)row;

-(void)haveDismiss;

@end

@interface PSSortDropMenu : UIView

@property (nonatomic, weak) id<PSSortDropMenuDelegate> delegate;

@property (nonatomic, assign) BOOL dropDown;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, assign) CGFloat top_heeight;

-(void)showInView:(UIView *)view;

-(void)hideView;

@end
