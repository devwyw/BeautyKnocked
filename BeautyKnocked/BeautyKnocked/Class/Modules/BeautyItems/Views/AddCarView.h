//
//  AddCarView.h
//  BeautyKnocked
//
//  Created by 王毅安 on 17/8/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSignal;

@interface AddCarView : UIView

@property (nonatomic,strong) RACSignal * doneAction;
@property (nonatomic,copy) NSString * count;

@end
