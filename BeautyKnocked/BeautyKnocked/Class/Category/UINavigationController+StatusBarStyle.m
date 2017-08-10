//
//  UINavigationController+StatusBarStyle.m
//  BeautyKnocked
//
//  Created by 王毅安 on 17/7/29.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "UINavigationController+StatusBarStyle.h"

@implementation UINavigationController (StatusBarStyle)
- (BOOL)prefersStatusBarHidden {
    return NO;
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}
@end
