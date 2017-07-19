//
//  EditAddressController.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/6.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AddressEditStyle) {
    AddressEditStyleAddNew, // add
    AddressEditStyleUpdate, // update change
    AddressEditStyleSelect, // select when  make an appointment
};

@interface EditAddressController : UIViewController

@property (nonatomic, assign) AddressEditStyle editStyle;

@end
