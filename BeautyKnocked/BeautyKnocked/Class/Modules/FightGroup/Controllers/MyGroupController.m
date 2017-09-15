//
//  MyGroupController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/29.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MyGroupController.h"

@interface MyGroupController ()

@end

@implementation MyGroupController

- (instancetype)initWithViewControllerClasses:(NSArray<Class> *)classes andTheirTitles:(NSArray<NSString *> *)titles
{
    self = [super initWithViewControllerClasses:classes andTheirTitles:titles];
    if (self) {
        self.title = @"我的拼团";
        self.menuViewStyle = WMMenuViewStyleLine;
        self.titleSizeSelected = 14;
        self.titleSizeNormal = 14;
        self.menuHeight = 35;
        self.titleColorSelected=[UIColor colorWithHexString:@"#D9AB39"];
        self.menuBGColor=[UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
