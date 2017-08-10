//
//  TabBarController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/6.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "TabBarController.h"
#import "LoginController.h"
#import "UIImage+Original.h"

@interface TabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) NSMutableArray<UITabBarItem *> *tabBarItems;

@end

@implementation TabBarController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTabBarItem];
}
-(void)setupTabBarItem {
    NSArray *controllerClasses = @[@"HomeController",
                                   @"ItemClassificationController",
                                   @"BeauticianController",
                                   @"OrderPageController",
                                   @"MineController"];
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:5];
    for (NSInteger i = 0; i < 5; i += 1) {
        Class controllerClass = NSClassFromString([controllerClasses objectAtIndex:i]);
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[controllerClass alloc] init]];
        navigationController.tabBarItem = [self.tabBarItems objectAtIndex:i];
        [viewControllers addObject:navigationController];
    }
    self.delegate = self;
    self.viewControllers = viewControllers;
}

-(NSMutableArray<UITabBarItem *> *)tabBarItems {
    if (!_tabBarItems) {
        // selected 1_03 unSelected 0_03
        _tabBarItems = [NSMutableArray arrayWithCapacity:5];
        NSArray *tabBarItemImages = @[@"shou",@"fen",@"yuyue_03",@"ding",@"wo"];
        NSArray *tabBarItemTitles = @[@"首页",@"分类",@"预约",@"订单",@"我的"];
        
        // create 5 tabBarItems
        for (NSInteger i = 0; i < 5; i += 1) {
            UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
            tabBarItem.title = [tabBarItemTitles objectAtIndex:i];
            [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor brownColor]} forState:UIControlStateSelected];
            tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -5);

            if (i == 2) {
                tabBarItem.image = [UIImage imageOriginalImageName:tabBarItemImages[i]];
                tabBarItem.imageInsets = UIEdgeInsetsMake(-10, 0, 10, 0);
            }else {
                tabBarItem.image = [UIImage imageOriginalImageName:[NSString stringWithFormat:@"%@0_03",tabBarItemImages[i]]];
                tabBarItem.selectedImage = [UIImage imageOriginalImageName:[NSString stringWithFormat:@"%@1_03",tabBarItemImages[i]]];
            }
            [_tabBarItems addObject:tabBarItem];
        }
        
    }
    return _tabBarItems;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//        if (self.viewControllers[3] ==viewController) {
//            if (![[Acount shareManager] isSignIn]) {
//                LoginController *loginController = [[LoginController alloc] init];
//                UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginController];
//                [self presentViewController:loginNav animated:YES completion:nil];
//            }
//        }
}
@end
