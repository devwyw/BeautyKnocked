//
//  CommentController.m
//  BeautyKnocked
//
//  Created by 王毅安 on 17/7/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "CommentController.h"
#import "EvaluationTableViewController.h"

@interface CommentController ()

@end

@implementation CommentController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha=@"1.0";
}
-(NSArray*)listArray{
    if (!_listArray) {
        _listArray=[[NSArray alloc]init];
    }
    return _listArray;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleSizeSelected = 14;
        self.titleSizeNormal = 14;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuBGColor=[UIColor whiteColor];
        self.menuViewBottomSpace=0.6;
        self.progressColor=[UIColor colorWithHexString:@"#E1BF6E"];
        self.titleColorNormal=[UIColor blackColor];
        self.titleColorSelected=self.titleColorNormal;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户评论";
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F2F2F2"];
    // Do any additional setup after loading the view.
}
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 2;
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    EvaluationTableViewController *controller = [[EvaluationTableViewController alloc] init];
    if (index==0) {
        controller.listArray=[[NSArray alloc]initWithArray:self.listArray];
    }else{
        NSMutableArray *array=[[NSMutableArray alloc]init];
        for (NSDictionary *model in self.listArray) {
            if (!isStringEmpty(model[@"imagesPaht"])) {
                NSArray *imageArray = [model[@"imagesPaht"] componentsSeparatedByString:@","];
                if (!isArrayEmpty(imageArray)) {
                    [array addObject:model];
                }
            }
        }
        controller.listArray=[[NSArray alloc]initWithArray:array];
    }
    return controller;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return @[@"全部评论",@"有图"][index];
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
