//
//  UIViewController+Cloudox.m
//  SmoothNavDemo
//
//  Created by Cloudox on 2017/3/20.
//  Copyright © 2017年 Cloudox. All rights reserved.
//

#import "UIViewController+Cloudox.h"
#import <objc/runtime.h>
#import "UINavigationController+Cloudox.h"

@implementation UIViewController (Cloudox)

/** RunTime */
static char *BarAlphas = "BarAlphas";
-(void)setBarAlpha:(NSString *)BarAlpha{
    objc_setAssociatedObject(self, BarAlphas, BarAlpha, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.navigationController setNeedsNavigationBackground:[BarAlpha floatValue]];
}
-(NSString*)BarAlpha{
    return objc_getAssociatedObject(self, BarAlphas) ? : @"1.0";
}
/** RunTime */
static char *BarHidden = "BarHidden";
-(void)setIsBarHidden:(NSString *)isBarHidden{
    objc_setAssociatedObject(self, BarHidden, isBarHidden, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString*)isBarHidden{
    return objc_getAssociatedObject(self, BarHidden) ? : @"0";
}
/** RunTime */
static char *DefaultBar = "DefaultBar";
-(void)setIsDefaultBar:(NSString *)isDefaultBar{
    objc_setAssociatedObject(self, DefaultBar, isDefaultBar, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString*)isDefaultBar{
    return objc_getAssociatedObject(self, DefaultBar) ? : @"0";
}
@end
