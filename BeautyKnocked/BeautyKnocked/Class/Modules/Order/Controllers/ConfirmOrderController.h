//
//  ConfirmOrderController.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserHeader.h"
@class DetailModel;
@class PackageInfoModel;
@class ProductModel;

@interface ConfirmOrderController : UIViewController

@property (nonatomic,assign) MLOrderStyle orderStyle;

@property (nonatomic,strong) DetailModel * detailModel;
@property (nonatomic,strong) PackageInfoModel * packageInfoModel;
@property (nonatomic,strong) ProductModel * productModel;
@end
