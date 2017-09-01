//
//  SonItemController.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/12.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSubject;

@interface SonItemController : UIViewController
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) RACSubject * subModel;
@property (nonatomic,assign) BOOL isSelected;
@end
