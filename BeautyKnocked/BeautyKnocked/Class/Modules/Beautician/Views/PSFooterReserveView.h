//
//  PSFooterReserveView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/22.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSignal;

@interface PSFooterReserveView : UIView
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * btnName;
@property (nonatomic,strong) RACSignal * subPush;
@end
