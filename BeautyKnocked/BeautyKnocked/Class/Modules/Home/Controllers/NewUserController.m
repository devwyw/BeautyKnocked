//
//  NewUserController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/19.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "NewUserController.h"
#import "CouponController.h"

@interface NewUserController ()
@property (nonatomic,strong) UIButton * item;
@property (nonatomic,strong) UIButton * preson;
@property (nonatomic,assign) BOOL isType;
@end

@implementation NewUserController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _item = [[UIButton alloc]initWithFrame:CGRectMake(Width-Width_Pt(80)-15, 22-Height_Pt(80)/2, Width_Pt(80), Height_Pt(80))];
    [_item setImage:[UIImage imageNamed:@"fenxiang-bai"] forState:UIControlStateNormal];
    [_item setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateHighlighted];
    [_item addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_item];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_item removeFromSuperview];
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
    NSString *userID=[Acount shareManager].id;
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, Width, Height-64)];
    [image setImage:[UIImage imageNamed:@"xinrenlingquan"]];
    [image setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:image];
    
    _preson=[[UIButton alloc]init];
    _preson.hidden=YES;
    Weakify(self);
    [[_preson rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (!_isType) {
            [Master HttpPostRequestByParams:@{@"clientId":userID} url:mlqqm serviceCode:lxrq Success:^(id json) {
                _isType=YES;
                [_preson setImage:[UIImage imageNamed:@"lingquchneggong"] forState:UIControlStateNormal];
            } Failure:nil andNavigation:Wself.navigationController];
        }else{
            CouponController *controler=[[CouponController alloc]init];
            [Wself.navigationController pushViewController:controler animated:YES];
        }
    }];
    [self.view addSubview:_preson];
    [_preson mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-Height_Pt(140));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(920),Height_Pt(200)));
    }];
    
    [Master HttpPostRequestByParams:@{@"clientId":userID} url:mlqqm serviceCode:pdxrq Success:^(id json) {
        _preson.hidden=NO;
        if (![json[@"info"] boolValue]) {
            _isType=YES;
            [_preson setImage:[UIImage imageNamed:@"lingquchneggong"] forState:UIControlStateNormal];
        }else{
            _isType=NO;
            [_preson setImage:[UIImage imageNamed:@"lijilingqu"] forState:UIControlStateNormal];
        }
    } Failure:nil andNavigation:self.navigationController];
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
