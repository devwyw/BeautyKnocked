//
//  FeaturedRecommendationsView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BeauticianModel;
@class RACSubject;

@interface FeaturedRecommendationsView : UIView
@property (nonatomic,strong) RACSubject * subTag;
@property (nonatomic,strong) BeauticianModel * model;
@end
