//
//  UINavigationController+Cloudox.h
//  SmoothNavDemo
//
//  Created by Cloudox on 2017/3/19.
//  Copyright © 2017年 Cloudox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Cloudox) <UINavigationBarDelegate, UINavigationControllerDelegate>
-(void)setNeedsNavigationBackground:(CGFloat)alpha;
@property (nonatomic,copy) NSString * cloudox;
@property (nonatomic,copy) NSString * barHiden;
@property (nonatomic,copy) NSString * defaultBar;
@end
