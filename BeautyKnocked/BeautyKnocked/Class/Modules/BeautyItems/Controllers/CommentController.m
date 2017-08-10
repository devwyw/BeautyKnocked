//
//  CommentController.m
//  BeautyKnocked
//
//  Created by 王毅安 on 17/7/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "CommentController.h"

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
- (instancetype)initWithViewControllerClasses:(NSArray<Class> *)classes andTheirTitles:(NSArray<NSString *> *)titles
{
    self = [super initWithViewControllerClasses:classes andTheirTitles:titles];
    if (self) {
        self.title = @"用户评论";
        self.menuViewStyle = WMMenuViewStyleLine;
        self.titleSizeSelected = 14;
        self.titleSizeNormal = 14;
        self.values = @[@22, @"Mark"].mutableCopy;
        self.keys = @[@"age",@"name"].mutableCopy;
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
