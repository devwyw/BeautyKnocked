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
    [super viewWillAppear:YES];
    {
        UIButton *item = [[UIButton alloc]initWithFrame:CGRectMake(Width-50, 2, 40, 40)];
        [item setTag:105];
        [item setImage:[UIImage imageNamed:@"fenxiang-bai"] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateHighlighted];
        [item addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.navigationBar addSubview:item];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    {
        UIButton *item=(UIButton*)[self.navigationController.navigationBar viewWithTag:105];
        [item removeFromSuperview];
    }
}
-(void)share:(UIButton*)button{
    NSLog(@"分享");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"新人领券"];
    [self loadBackView];
    // Do any additional setup after loading the view.
}
-(void)loadBackView{
    UIImageView *image=[[UIImageView alloc]initWithFrame:ViewMake];
    [image setImage:[UIImage imageNamed:@"xinrenlingquan"]];
    [image setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:image];
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(50, Height-90, Width-100, 60)];
    [button setImage:[UIImage imageNamed:@"lijilingqu"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(lingqu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)lingqu:(UIButton*)button{
    [button setImage:[UIImage imageNamed:@"lingquchneggong"] forState:UIControlStateNormal];
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
