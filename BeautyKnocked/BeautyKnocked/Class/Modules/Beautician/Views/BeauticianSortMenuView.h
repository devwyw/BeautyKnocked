//
//  BeauticianSortMenuView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/10.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BeauticianSortMenuViewDelegate <NSObject>

-(void)didSelectAtRow:(NSInteger)row;
-(void)selectedDay:(NSString*)day;
@end

@interface BeauticianSortMenuView : UIView

@property (nonatomic,strong) id<BeauticianSortMenuViewDelegate> delegate;

@end
