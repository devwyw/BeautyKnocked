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
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, 64)];
        image.image=[UINavigationController GetImageWithColor:ThemeColor andAlpha:1 andHeight:64];
        [backgroundEffectView addSubview:image];
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
static char *BarAlphas = "BarAlphas";
-(void)setCloudox:(NSString *)cloudox{
    objc_setAssociatedObject(self, BarAlphas, cloudox, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)cloudox{
    return objc_getAssociatedObject(self, BarAlphas);
}
static char *BarHidden = "BarHidden";
-(void)setBarHiden:(NSString *)barHiden{
    objc_setAssociatedObject(self, BarHidden, barHiden, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString*)barHiden{
    return objc_getAssociatedObject(self, BarHidden);
}
- (BOOL)prefersStatusBarHidden{
    return [self.barHiden isEqualToString:@"1"] ? YES:NO;
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}
static char *DefaultBar = "DefaultBar";
-(void)setDefaultBar:(NSString *)defaultBar{
    objc_setAssociatedObject(self, DefaultBar, defaultBar, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString*)defaultBar{
    return objc_getAssociatedObject(self, DefaultBar);
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.defaultBar isEqualToString:@"1"] ? UIStatusBarStyleDefault:UIStatusBarStyleLightContent;
}

@end
