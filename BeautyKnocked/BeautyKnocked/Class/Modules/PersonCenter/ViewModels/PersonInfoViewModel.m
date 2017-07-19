//
//  PersonInfoViewModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PersonInfoViewModel.h"

@interface PersonInfoViewModel ()

@end

@implementation PersonInfoViewModel

-(void)showPhotoSelectView {
    
    UIAlertAction *alertAction0 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertAction0 setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    [alertController addAction:alertAction0];
    [alertController addAction:alertAction1];
    [alertController addAction:alertAction2];
    
    [self.viewController presentViewController:alertController animated:YES completion:nil];
}

@end
