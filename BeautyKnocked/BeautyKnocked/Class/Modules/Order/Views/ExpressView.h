//
//  ExpressView.h
//  BeautyKnocked
//
//  Created by Mac on 2017/9/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSubject;

@interface ExpressView : UIView
@property (nonatomic,strong) RACSubject * subType;
@property (nonatomic,copy) NSString * index;
@end
