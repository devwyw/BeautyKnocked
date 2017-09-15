//
//  ConfirmOrderController.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserHeader.h"
#import "ProductModel.h"
#import "DetailModel.h"

@interface ConfirmOrderController : UIViewController

@property (nonatomic,assign) MLOrderStyle orderStyle;

@property (nonatomic,strong) DetailModel * detailModel;
@property (nonatomic,strong) ProductModel * productModel;

@property (nonatomic,strong) NSArray * carArray;

@property (nonatomic,copy) NSString * cartIds;
@end
