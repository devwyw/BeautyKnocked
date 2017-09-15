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
@property (nonatomic,strong) RACSubject * beauticianId;
@property (nonatomic,copy) NSString * serviceTime;
@property (nonatomic,copy) NSString * pactServiceTime;
@property (nonatomic,assign) BOOL isType;
@end
