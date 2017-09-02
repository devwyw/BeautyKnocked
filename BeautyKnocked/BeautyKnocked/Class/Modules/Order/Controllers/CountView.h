//
//  CountView.h
//  Technician
//
//  Created by Mac on 2017/8/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSubject;

@interface CountView : UIView
@property (nonatomic,strong) RACSubject * subCounts;
@property (nonatomic,copy) NSString * counts;
@end
