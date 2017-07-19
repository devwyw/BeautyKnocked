//
//  NewPersonView.h
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPersonView : UIControl

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *descr;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIFont *descrFont;

@property (nonatomic, assign) CGSize imageSize;

@property (nonatomic,strong) UIButton * button;

@end
