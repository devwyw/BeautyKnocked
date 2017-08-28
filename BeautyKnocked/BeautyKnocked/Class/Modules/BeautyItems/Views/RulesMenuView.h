//
//  RulesMenuView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RulesMenuViewDlegate <NSObject>

-(void)PushServiceView;

@end

@interface RulesMenuView : UIView
@property (nonatomic,strong) id<RulesMenuViewDlegate> delegate;
@end
