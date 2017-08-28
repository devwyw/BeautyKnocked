//
//  PaySheetView.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LEEAlert.h>
@class RACSubject;

@interface PaySheetView : UIView
@property (nonatomic,strong) RACSubject * subType;
@end
