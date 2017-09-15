//
//  FootPriceView.h
//  Technician
//
//  Created by Mac on 2017/8/5.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSignal;

@interface FootPriceView : UIView
@property (nonatomic,strong) RACSignal * allAction;
@property (nonatomic,strong) RACSignal * allBuy;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * btnName;
@end
