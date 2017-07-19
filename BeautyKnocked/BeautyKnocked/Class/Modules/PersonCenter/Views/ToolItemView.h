//
//  ToolItemView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToolItemViewDelegate <NSObject>

-(void)didChooseToolAtIndex:(NSUInteger)index;

@end

@interface ToolItemView : UIView

@property (nonatomic, weak) id<ToolItemViewDelegate> delegate;

@end
