//
//  LightController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/19.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "LightViewController.h"
#import "LightSonViewController.h"

@interface LightViewController ()

@property (nonatomic,strong) UIScrollView *Sview;

@end

@implementation LightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"光电中心"];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];//关闭自动布局
    [self loadScrollVeiw];
    [self addButton];
    // Do any additional setup after loading the view.
}
-(void)loadScrollVeiw{
    _Sview=[[UIScrollView alloc]initWithFrame:ViewMake];
    [_Sview setContentSize:CGSizeMake(Width, Height_Pt(4939))];
    _Sview.delaysContentTouches = NO;
    [self.view addSubview:_Sview];
    
    UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(4939))];
    [image setImage:[UIImage imageNamed:[NSString stringWithFormat:@"lightimage.jpg"]]];
    [image setContentMode:UIViewContentModeScaleAspectFill];
    [_Sview addSubview:image];
}
-(void)addButton{
    {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(Width/4, Height_Pt(1421), 80, Height_Pt(65))];
        [button setTag:1];
        [button addTarget:self action:@selector(pushSon:) forControlEvents:UIControlEventTouchUpInside];
        [_Sview addSubview:button];
    }
    {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(Width/2+10, Height_Pt(1980), 80, Height_Pt(65))];
        [button setTag:2];
        [button addTarget:self action:@selector(pushSon:) forControlEvents:UIControlEventTouchUpInside];
        [_Sview addSubview:button];
    }
    {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(Width/4, Height_Pt(2550), 80, Height_Pt(65))];
        [button setTag:3];
        [button addTarget:self action:@selector(pushSon:) forControlEvents:UIControlEventTouchUpInside];
        [_Sview addSubview:button];
    }
    {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(Width/2+10, Height_Pt(3030), 80, Height_Pt(65))];
        [button setTag:4];
        [button addTarget:self action:@selector(pushSon:) forControlEvents:UIControlEventTouchUpInside];
        [_Sview addSubview:button];
    }
    {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(Width/4, Height_Pt(3690), 80, Height_Pt(65))];
        [button setTag:5];
        [button addTarget:self action:@selector(pushSon:) forControlEvents:UIControlEventTouchUpInside];
        [_Sview addSubview:button];
    }
    {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(Width/2+10, Height_Pt(4205), 80, Height_Pt(65))];
        [button setTag:6];
        [button addTarget:self action:@selector(pushSon:) forControlEvents:UIControlEventTouchUpInside];
        [_Sview addSubview:button];
    }
}
-(void)pushSon:(UIButton*)button{
    LightSonViewController *controller=[[LightSonViewController alloc]init];
    [controller setMtag:button.tag];
    [self.navigationController pushViewController:controller animated:YES];
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
