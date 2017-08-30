//
//  SonCouponTableController.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/17.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSubject;

@interface SonCouponTableController : UITableViewController
@property (nonatomic,strong) NSMutableArray * listArray;
@property (nonatomic,assign) BOOL isOrder;
@property (nonatomic,strong) RACSubject * subCouponId;
@end
