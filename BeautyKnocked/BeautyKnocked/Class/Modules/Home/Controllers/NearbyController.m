//
//  NearbyController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "NearbyController.h"

@interface NearbyController ()

@end

@implementation NearbyController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"附近美容师"];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F0F0F0"]];
    
    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jingqingqidai"]];
    [image setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(650), Height_Pt(350)));
    }];
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
