//
//  ConfirmOrderSubmitView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/19.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSignal;

@interface ConfirmOrderSubmitView : UIView

@property (nonatomic, copy) NSString *totalPrice;
@property (nonatomic,strong) RACSignal * payInfo;
@end
