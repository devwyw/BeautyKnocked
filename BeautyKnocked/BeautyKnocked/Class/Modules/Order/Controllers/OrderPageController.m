//
//  OrderPageController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "OrderPageController.h"
#import "OrderBaseTableViewController.h"

@interface OrderPageController ()

@property (nonatomic, strong) NSArray *orderStatus;

@end

@implementation OrderPageController

- (NSArray *)orderStatus {
    if (!_orderStatus) {
        _orderStatus = @[@"全部订单", @"待服务", @"进行中",@"待评价"];
    }
    return _orderStatus;
}

- (instancetype)init {
    if (self = [super init]) {
        self.titleSizeNormal = 14;
        self.titleSizeSelected = 15;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = Width / self.orderStatus.count;
        self.menuBGColor=[UIColor whiteColor];
        self.menuHeight = 35;
        self.titleColorSelected = [UIColor colorWithHexString:@"#E1BF6E"];
        self.titleColorNormal = [UIColor blackColor];
        self.menuViewBottomSpace=0.6;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.StatusDefaultBar=@"0";
    self.BarColor = [ThemeColor toColorString];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    self.navigationItem.title=@"我的订单";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.orderStatus.count;
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    OrderBaseTableViewController *vc = [[OrderBaseTableViewController alloc]init];
    if (index==0) {
        vc.index=9;
    }else{
        vc.index=index;
    }
    return vc;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.orderStatus[index];
}
@end
