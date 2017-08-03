//
//  UINavigationController+StatusBarStyle.m
//  BeautyKnocked
//
//  Created by 王毅安 on 17/7/29.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "UINavigationController+StatusBarStyle.h"

@implementation UINavigationController (StatusBarStyle)
-(UIViewController*)childViewControllerForStatusBarStyle{
    return self.visibleViewController;
}
-(UIViewController*)childViewControllerForStatusBarHidden{
    return self.visibleViewController;
}
@end
