//
//  NewUserController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/19.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "NewUserController.h"

@interface NewUserController ()

@end

@implementation NewUserController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    {
        UIButton *item = [[UIButton alloc]initWithFrame:CGRectMake(Width-Width_Pt(80)-15, 22-Height_Pt(80)/2, Width_Pt(80), Height_Pt(80))];
        [item setTag:105];
        [item setImage:[UIImage imageNamed:@"fenxiang-bai"] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateHighlighted];
        [item addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.navigationBar addSubview:item];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    {
        UIButton *item=(UIButton*)[self.navigationController.navigationBar viewWithTag:105];
        [item removeFromSuperview];
    }
}
-(void)share:(UIButton*)button{
    NSLog(@"分享");
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"新人领券"];
    [self loadBackView];
    // Do any additional setup after loading the view.
}
-(void)loadBackView{
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, Width, Height-64)];
    [image setImage:[UIImage imageNamed:@"xinrenlingquan"]];
    [image setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:image];
    
    UIButton *button=[[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"lijilingqu"] forState:UIControlStateNormal];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [button setImage:[UIImage imageNamed:@"lingquchneggong"] forState:UIControlStateNormal];
    }];
    
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-Height_Pt(140));
        make.width.height.mas_equalTo(CGSizeMake(Width_Pt(920),Height_Pt(200)));
    }];
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
