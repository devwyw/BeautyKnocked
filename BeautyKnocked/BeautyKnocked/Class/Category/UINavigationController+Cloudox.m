//
//  UINavigationController+Cloudox.m
//  SmoothNavDemo
//
//  Created by Cloudox on 2017/3/19.
//  Copyright © 2017年 Cloudox. All rights reserved.
//

#import "UINavigationController+Cloudox.h"
#import <objc/runtime.h>
#import "UIViewController+Cloudox.h"

@implementation UINavigationController (Cloudox)
// 设置导航栏背景透明度
- (void)setNeedsNavigationBackground:(CGFloat)alpha {
    UIView *barBackgroundView = [[self.navigationBar subviews] objectAtIndex:0];
    UIImageView *backgroundImageView = [[barBackgroundView subviews] objectAtIndex:0];
    UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];
    
    if (!backgroundImageView.isHidden) {
        backgroundImageView.hidden=YES;
        UIImageView * backgroundImageColor=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, 64)];
        [backgroundImageColor setTag:10001];
        [backgroundEffectView addSubview:backgroundImageColor];
    }
    
    if (self.navigationBar.isTranslucent) {
        if (backgroundImageView != nil && backgroundImageView.image != nil) {
            barBackgroundView.alpha = alpha;
        }else {
            backgroundEffectView.alpha = alpha;
        }
    }else{
        barBackgroundView.alpha = alpha;
    }
}
+(UIImage*)GetImageWithColor:(UIColor*)color andAlpha:(CGFloat)alpha andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color colorWithAlphaComponent:alpha].CGColor);
    CGContextFillRect(context, r);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
+ (void)initialize {
    if (self == [UINavigationController self]) {
        SEL originalSelector = NSSelectorFromString(@"_updateInteractiveTransition:");
        SEL swizzledSelector = NSSelectorFromString(@"et__updateInteractiveTransition:");
        Method originalMethod = class_getInstanceMethod([self class], originalSelector);
        Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
// 交换的方法，监控滑动手势
- (void)et__updateInteractiveTransition:(CGFloat)percentComplete {
    [self et__updateInteractiveTransition:(percentComplete)];
    UIViewController *topVC = self.topViewController;
    if (topVC != nil) {
        id<UIViewControllerTransitionCoordinator> coor = topVC.transitionCoordinator;
        if (coor != nil) {
            // 随着滑动的过程设置导航栏透明度渐变
            CGFloat fromAlpha = [[coor viewControllerForKey:UITransitionContextFromViewControllerKey].BarAlpha floatValue];
            CGFloat toAlpha = [[coor viewControllerForKey:UITransitionContextToViewControllerKey].BarAlpha floatValue];
            CGFloat nowAlpha = fromAlpha + (toAlpha - fromAlpha) * percentComplete;
            [self setNeedsNavigationBackground:nowAlpha];
        }
    }
}
#pragma mark - UINavigationController Delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *topVC = self.topViewController;
    if (topVC != nil) {
        id<UIViewControllerTransitionCoordinator> coor = topVC.transitionCoordinator;
        if (coor != nil) {
            if (SystemVersion>=10.0) {
                [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    [self dealInteractionChanges:context];
                }];
            }else{
                [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    [self dealInteractionChanges:context];
                }];
            }
        }
    }
}
- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context {
    if ([context isCancelled]) {
        NSTimeInterval cancelDuration = [context transitionDuration] * (double)[context percentComplete];
        [UIView animateWithDuration:cancelDuration animations:^{
            CGFloat nowAlpha = [[context viewControllerForKey:UITransitionContextFromViewControllerKey].BarAlpha floatValue];
            [self setNeedsNavigationBackground:nowAlpha];
        }];
    } else {
        NSTimeInterval finishDuration = [context transitionDuration] * (double)(1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            CGFloat nowAlpha = [[context viewControllerForKey:
                                 UITransitionContextToViewControllerKey].BarAlpha floatValue];
            [self setNeedsNavigationBackground:nowAlpha];
        }];
    }
}
#pragma mark - UINavigationBar Delegate
- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    if (self.viewControllers.count >= navigationBar.items.count) {// 点击返回按钮
        UIViewController *popToVC = self.viewControllers[self.viewControllers.count - 1];
        [self setNeedsNavigationBackground:[popToVC.BarAlpha floatValue]];
    }
}
- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item {
    [self setNeedsNavigationBackground:[self.topViewController.BarAlpha floatValue]];
}
#pragma mark ===== RunTime =====
/** 透明度 */
static char *BarAlphas = "BarAlphas";
-(void)setCloudox:(NSString *)cloudox{
    objc_setAssociatedObject(self, BarAlphas, cloudox, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)cloudox{
    return objc_getAssociatedObject(self, BarAlphas);
}
/** 背景颜色 */
static char *ImageColor = "ImageColor";
-(void)setImageColor:(NSString *)imageColor{
    objc_setAssociatedObject(self, ImageColor, imageColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)imageColor{
    return objc_getAssociatedObject(self, ImageColor);
}
-(void)setNeedsNavigationBackgroundColor:(NSString*)color{
    UIView *barBackgroundView = [[self.navigationBar subviews] objectAtIndex:0];
    UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];
    UIImageView *imageColor=[backgroundEffectView viewWithTag:10001];
    imageColor.image=[UINavigationController GetImageWithColor:[UIColor colorWithHexString:color] andAlpha:1 andHeight:64];
}
/** 状态栏风格 */
static char *DefaultBars = "DefaultBars";
-(void)setIsDefaultBar:(NSString *)isDefaultBar{
    objc_setAssociatedObject(self, DefaultBars, isDefaultBar, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString*)isDefaultBar{
    return objc_getAssociatedObject(self, DefaultBars);
}
-(void)setStatusDefaultBar:(NSString*)status{
    if ([status integerValue]==1) {
        self.navigationBar.barStyle = UIBarStyleDefault;
    }else{
        self.navigationBar.barStyle = UIBarStyleBlack;}
}
@end
