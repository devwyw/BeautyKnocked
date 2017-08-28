//
//  BeauticianController.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/10.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSubject;

@interface BeauticianController : UIViewController
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,strong) RACSubject * beauticianId;
@property (nonatomic,copy) NSString * code1;
@property (nonatomic,copy) NSString * code2;
@end
