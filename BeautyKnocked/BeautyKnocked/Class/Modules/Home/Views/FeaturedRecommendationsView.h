//
//  FeaturedRecommendationsView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeaturedRecommenDelegate <NSObject>

-(void)buttonMore:(UIButton *)button;

@end

@interface FeaturedRecommendationsView : UIView
@property (nonatomic,strong) id<FeaturedRecommenDelegate> viewDelegate;
@end
