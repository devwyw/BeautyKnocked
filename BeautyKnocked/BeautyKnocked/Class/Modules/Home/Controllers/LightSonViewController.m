//
//  LightSonViewController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/19.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "LightSonViewController.h"

@interface LightSonViewController ()

@end

@implementation LightSonViewController

- (void)viewDidLoad {
    [super viewDidLoad];[self setAutomaticallyAdjustsScrollViewInsets:NO];//关闭自动布局
    NSArray * titleArr=@[@"欧洲之星",@" ULTHERA超声刀",@"OPT冰点快速脱毛仪",@"水光针",@"热立塑LIPOSONIX",@"C6至尊祛斑王"];
    [self setTitle:titleArr[_Mtag-1]];
    NSArray * imageArr=@[@"smzt.jpg",@"csdqt.jpg",@"opttmqt.jpg",@"sgz.jpg",@"rls.jpg",@"cqbw.jpg"];
    NSArray * heightArr=@[@"11684",@"7169",@"8518",@"8021",@"11716",@"8956"];
    NSInteger height=[heightArr[_Mtag-1] integerValue];
    
    UIScrollView *Sview=[[UIScrollView alloc]initWithFrame:ViewMake];
    [Sview setContentSize:CGSizeMake(Width, Height_Pt(height))];
    [self.view addSubview:Sview];
    
    UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(height))];
    [image setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[_Mtag-1]]]];
    [image setContentMode:UIViewContentModeScaleAspectFill];
    [Sview addSubview:image];
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
