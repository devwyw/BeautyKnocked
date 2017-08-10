//
//  PersonCenterHeadView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSignal;

@protocol PSheaderViewDelegate <NSObject>

-(void)headIconDidClicked;
-(void)didGroupClicked:(NSUInteger)index;
-(void)didSelectedItemAtIndex:(NSUInteger)index;

@end

@interface PersonCenterHeadView : UIView

@property (nonatomic, weak) id<PSheaderViewDelegate> delegate;

@property (nonatomic, strong) RACSignal *setClickedSignal;

@property (nonatomic, strong) RACSignal *messageClickedSignal;

@property (nonatomic,copy) NSString * nickName;
@property (nonatomic,copy) NSString * imageUrl;

@end
