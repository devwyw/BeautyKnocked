//
//  PayInfoController.h
//  BeautyKnocked
//
//  Created by Mac on 2017/7/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderInfoModel;

@interface PayInfoController : UIViewController
@property (nonatomic,strong) OrderInfoModel * model;
@property (nonatomic,copy) NSString * isPayType;
@end
