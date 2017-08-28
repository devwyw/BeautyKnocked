//
//  ModifyPersonInfoView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyPersonInfoView : UIView
@property (nonatomic, strong) RACSignal *passwordPressSignal;
@property (nonatomic, strong) RACSignal *headIconPressSignal;
@property (nonatomic, strong) UIImage * headerimage;
@property (nonatomic, strong) UINavigationController * navigationController;
@end
