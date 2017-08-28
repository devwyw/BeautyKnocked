//
//  SonItemController.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/12.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@protocol SonItemControllerDelegat <NSObject>
-(void)selectModel:(DetailModel*)model;
@end

@interface SonItemController : UIViewController
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * sort;
@property (nonatomic,strong) id<SonItemControllerDelegat> delegate;
@end
