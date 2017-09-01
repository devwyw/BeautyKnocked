//
//  BeauticianSortMenuView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/10.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSubject;

@interface BeauticianSortMenuView : UIView
@property (nonatomic,strong) RACSubject * subRow;
@property (nonatomic,strong) RACSubject * subDay;
@end
