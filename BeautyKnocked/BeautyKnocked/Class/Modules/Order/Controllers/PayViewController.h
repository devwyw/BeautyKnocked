//
//  PayViewController.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/28.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfoModel.h"

@interface PayViewController : UIViewController
@property (nonatomic,strong) OrderInfoModel * model;
@property (nonatomic,copy) NSString * isPayType;
@end
