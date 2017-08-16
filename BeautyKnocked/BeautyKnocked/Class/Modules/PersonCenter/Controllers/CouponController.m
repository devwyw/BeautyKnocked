//
//  CouponController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "CouponController.h"
#import "SonCouponController.h"

@interface CouponController ()

@end

@implementation CouponController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的优惠券";
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F2F2F2"];
    // Do any additional setup after loading the view.
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleSizeSelected = Font_Size(40);
        self.titleSizeNormal = Font_Size(40);
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuHeight=Height_Pt(120);
        self.menuBGColor=[UIColor whiteColor];
        self.menuViewBottomSpace=0.6;
        self.progressColor=[UIColor colorWithHexString:@"#E1BF6E"];
        self.titleColorNormal=[UIColor blackColor];
        self.titleColorSelected=self.titleColorNormal;
    }
    return self;
}
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 3;
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    SonCouponController *controller=[[SonCouponController alloc]init];
    return controller;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return @[@"已使用",@"未使用",@"已过期"][index];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
