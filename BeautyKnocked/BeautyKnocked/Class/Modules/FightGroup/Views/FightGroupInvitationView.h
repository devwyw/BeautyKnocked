//
//  FightGroupInvitationView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FightGroupInvitationViewDelegate <NSObject>

-(void)didSelectShareStyle:(NSUInteger)style;

@end

@interface FightGroupInvitationView : UIView

@property (nonatomic, weak) id<FightGroupInvitationViewDelegate> delegate;
@property (nonatomic, strong) RACSignal *rulesSignal;

-(void)showInView:(UIView *)view;

@end
