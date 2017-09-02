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
static char *ImageColor = "ImageColor";
-(void)setBarColor:(NSString *)BarColor{
    objc_setAssociatedObject(self, ImageColor, BarColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.navigationController setNeedsNavigationBackgroundColor:BarColor];
}
-(NSString*)BarColor{
    return objc_getAssociatedObject(self, ImageColor) ? : @"#ffffff";
}
/** RunTime */
static char *BarHiddens = "BarHiddens";
-(void)setStatusBarHidden:(NSString *)StatusBarHidden{
    objc_setAssociatedObject(self, BarHiddens, StatusBarHidden, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString*)StatusBarHidden{
    return objc_getAssociatedObject(self, BarHiddens) ? : @"0";
}
/** RunTime */
static char *DefaultBars = "DefaultBars";
-(void)setStatusDefaultBar:(NSString *)StatusDefaultBar{
    objc_setAssociatedObject(self, DefaultBars, StatusDefaultBar, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.navigationController setStatusDefaultBar:StatusDefaultBar];
}
-(NSString*)StatusDefaultBar{
    return objc_getAssociatedObject(self, DefaultBars) ? : @"0";
}
@end
