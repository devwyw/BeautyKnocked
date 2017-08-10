//
//  BrandViewController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/18.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BrandViewController.h"

@interface BrandViewController ()

@end

@implementation BrandViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"品牌甄选"];
    [self setScrollView];
    // Do any additional setup after loading the view.
}
-(void)setScrollView{
    NSArray *imageArr=[[NSArray alloc]initWithObjects:@"pinpai1.jpg",@"pinpai2.jpg",@"pinpai3.jpg", nil];
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Width, Height-64)];
    [scrollView setContentSize:CGSizeMake(Width*3, Height_Pt(1424))];
    scrollView.pagingEnabled=YES;
    scrollView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:scrollView];
    
    for (int i=0; i<=2; i++) {
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(i*Width, 0, Width, Height_Pt(1424))];
        [image setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[i]]]];
        [image setContentMode:UIViewContentModeScaleAspectFill];
        [scrollView addSubview:image];
    }
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
