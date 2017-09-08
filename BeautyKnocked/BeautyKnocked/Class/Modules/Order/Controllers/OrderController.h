//
//  OrderController.h
//  BeautyKnocked
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserHeader.h"
#import "PackageInfoModel.h"

@interface OrderController : UIViewController
@property (nonatomic,assign) MLOrderStyle orderStyle;
@property (nonatomic,strong) PackageInfoModel * packageInfoModel;
@end
