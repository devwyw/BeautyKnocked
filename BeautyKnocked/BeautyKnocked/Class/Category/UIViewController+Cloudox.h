//
//  UIViewController+Cloudox.h
//  SmoothNavDemo
//
//  Created by Cloudox on 2017/3/20.
//  Copyright © 2017年 Cloudox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Cloudox)
/** 导航栏透明度->1:显示(默认) 0:透明 */
@property (nonatomic,copy) NSString * BarAlpha;
/** 状态栏隐藏->0:显示(默认) 1:隐藏 */
@property (nonatomic,copy) NSString * isBarHidden;
/** 状态栏风格->0:白色(默认) 1:黑色 */
@property (nonatomic,copy) NSString * isDefaultBar;
@end
