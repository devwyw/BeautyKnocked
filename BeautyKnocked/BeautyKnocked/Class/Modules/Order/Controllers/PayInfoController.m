//
//  PayInfoController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PayInfoController.h"

@interface PayInfoController ()
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic,strong) UILabel * label1;
@property (nonatomic,strong) UIView * line;
@property (nonatomic,strong) UILabel * label2;
@property (nonatomic,strong) UILabel * label3;
@property (nonatomic,strong) UIButton * btn1;
@property (nonatomic,strong) UIButton * btn2;


@end

@implementation PayInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton=YES;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title=@"支付页面";
    [self initializeViews];
    [self addConstraints];
    // Do any additional setup after loading the view.
}
-(void)initializeViews {
    _image=[[UIImageView alloc]init];
    [self.view addSubview:_image];
    
    _label1=[[UILabel alloc]init];
    _label1.font=[UIFont systemFontOfSize:Font_Size(42)];
    [self.view addSubview:_label1];
    
    _line=[[UIView alloc]init];
    _line.backgroundColor=[UIColor colorWithHexString:@"#E0E0E0"];
    [self.view addSubview:_line];
    
    
    _label2=[[UILabel alloc]init];
    _label2.font=[UIFont systemFontOfSize:Font_Size(38)];
    _label2.text=@"订单信息";
    [self.view addSubview:_label2];
    
    _label3=[[UILabel alloc]init];
    _label3.font=[UIFont systemFontOfSize:Font_Size(34)];
    
    _label3.textColor=[UIColor grayColor];
    [self.view addSubview:_label3];
    
    _btn1=[[UIButton alloc]init];
    [_btn1 setTitleColor:[UIColor colorWithHexString:@"#D7AE4D"] forState:UIControlStateNormal];
    _btn1.titleLabel.font=[UIFont systemFontOfSize:Font_Size(38)];
    [_btn1 makeBorderWidth:0.5 withColor:[UIColor colorWithHexString:@"#D7AE4D"]];
    [_btn1 makeCornerRadius:8];
    [_btn1 addTarget:self action:@selector(payinfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn1];
    
    _btn2=[[UIButton alloc]init];
    [_btn2 setTitle:@"查看订单" forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    _btn2.titleLabel.font=[UIFont systemFontOfSize:Font_Size(38)];
    [_btn2 makeBorderWidth:0.5 withColor:[UIColor colorWithHexString:@"#999999"]];
    [_btn2 makeCornerRadius:8];
    [_btn2 addTarget:self action:@selector(backinfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn2];
    
    if (_isStatus) {
        _image.image=[UIImage imageNamed:@"zhifuchenggong"];
        _label1.text=@"支付成功";
        _label3.text=@"您的订单已经成功受理，感谢您的购买~";
        [_btn1 setTitle:@"返回首页" forState:UIControlStateNormal];
    }else{
        _image.image=[UIImage imageNamed:@"zhifushibai"];
        _label1.text=@"支付失败，请重新支付";
        _label3.text=@"您的订单必须在服务时间内完成付款，否则会被取消哦~";
        [_btn1 setTitle:@"重新支付" forState:UIControlStateNormal];
    }
}
-(void)addConstraints {
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(Height_Pt(110));
    }];
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_image.mas_bottom).offset(Height_Pt(35));
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label1.mas_bottom).offset(Height_Pt(90));
        make.left.right.equalTo(self.view).offset(Width_Pt(80));
        make.right.equalTo(self.view).offset(-Width_Pt(80));
        make.height.mas_equalTo(0.5);
    }];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(Height_Pt(35));
        make.left.equalTo(_line);
    }];
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label2.mas_bottom).offset(Height_Pt(35));
        make.left.equalTo(_line);
    }];
    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label3.mas_bottom).offset(Height_Pt(195));
        make.left.equalTo(_line);
        make.right.equalTo(self.view.mas_centerX).offset(-Width_Pt(60));
        make.height.mas_equalTo(Height_Pt(100));
    }];
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btn1);
        make.left.equalTo(self.view.mas_centerX).offset(Width_Pt(60));
        make.right.equalTo(_line.mas_right);
        make.height.mas_equalTo(Height_Pt(100));
    }];
}

-(void)payinfo:(UIButton*)btn{
    if (_isStatus) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)backinfo:(UIButton*)btn{
    [Master setTabBarItem:3 withNavigationController:self.navigationController];
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
