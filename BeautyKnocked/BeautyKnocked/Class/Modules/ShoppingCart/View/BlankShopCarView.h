//
//  BlankShopCarView.h
//  BeautyKnocked
//
//  Created by Mac on 2017/9/14.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSubject;

@interface BlankShopCarView : UIView
@property (nonatomic,strong) NSArray * data;
@property (nonatomic,strong) RACSubject * subModel;
@end
