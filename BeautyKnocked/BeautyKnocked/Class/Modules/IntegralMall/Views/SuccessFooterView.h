//
//  SuccessFooterView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SuccessFooterViewDelegate <NSObject>

-(void)successFooterViewClicked:(NSUInteger)index;

@end

@interface SuccessFooterView : UIView

@property (nonatomic, weak) id<SuccessFooterViewDelegate> delegate;

@end
