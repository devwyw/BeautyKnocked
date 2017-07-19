//
//  PersonInfoViewModel.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInfoViewModel : NSObject

@property (nonatomic, strong) UINavigationController *navigationController;

@property (nonatomic, strong) UIViewController *viewController;

@property (nonatomic, strong) RACSignal *passwordModifySignal;

-(void)showPhotoSelectView;

@end
