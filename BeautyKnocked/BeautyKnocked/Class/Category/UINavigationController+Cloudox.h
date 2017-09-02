//
//  UINavigationController+Cloudox.h
//  SmoothNavDemo
//
//  Created by Cloudox on 2017/3/19.
//  Copyright © 2017年 Cloudox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Cloudox) <UINavigationBarDelegate, UINavigationControllerDelegate>
@property (nonatomic,copy) NSString * cloudox;
@property (nonatomic,copy) NSString * isDefaultBar;
@property (nonatomic,copy) NSString * imageColor;
-(void)setNeedsNavigationBackground:(CGFloat)alpha;
-(void)setNeedsNavigationBackgroundColor:(NSString*)color;
-(void)setStatusDefaultBar:(NSString*)status;
@end
