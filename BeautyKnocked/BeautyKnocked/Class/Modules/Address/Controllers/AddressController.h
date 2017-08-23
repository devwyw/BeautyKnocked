//
//  AddressController.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/5.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;
@class RACSubject;

@interface AddressController : UIViewController
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,strong) RACSubject * addressId;
@end
