//
//  WuLiuController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/25.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "WuLiuController.h"

@interface WuLiuController ()
@property (nonatomic,strong) UIImageView * imageCar;
@property (nonatomic,strong) UILabel * Gslabel;
@property (nonatomic,strong) UILabel * Dhlabel;
@property (nonatomic,strong) UILabel * Gslabel1;
@property (nonatomic,strong) UILabel * Dhlabel1;
@end

@implementation WuLiuController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"物流信息"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initializeViews];
    [self addConstraints];
    // Do any additional setup after loading the view.
}
-(void)initializeViews {
    _imageCar=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kuaidi"]];
    [self.view addSubview:_imageCar];
    
    _Gslabel=[[UILabel alloc]init];
    _Gslabel.text=@"物流公司：";
    [_Gslabel setFont:[UIFont systemFontOfSize:Font_Size(40)]];
    [self.view addSubview:_Gslabel];
    
    _Dhlabel=[[UILabel alloc]init];
    _Dhlabel.text=@"物流单号：";
    [_Dhlabel setFont:[UIFont systemFontOfSize:Font_Size(40)]];
    [self.view addSubview:_Dhlabel];
    
    _Gslabel1=[[UILabel alloc]init];
    _Gslabel1.text=@"物流公司";
    [_Gslabel1 setFont:[UIFont systemFontOfSize:Font_Size(40)]];
    [self.view addSubview:_Gslabel1];
    
    _Dhlabel1=[[UILabel alloc]init];
    _Dhlabel1.text=@"物流单号";
    [_Dhlabel1 setFont:[UIFont systemFontOfSize:Font_Size(40)]];
    [self.view addSubview:_Dhlabel1];
}
-(void)addConstraints {
    [_imageCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(Height_Pt(75));
        make.left.equalTo(self.view).offset(Width_Pt(75));
    }];
    [_Gslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageCar.mas_top);
        make.left.equalTo(_imageCar.mas_right).offset(Width_Pt(85));
    }];
    [_Dhlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_imageCar.mas_bottom);
        make.left.equalTo(_imageCar.mas_right).offset(Width_Pt(85));
    }];
    
    [_Gslabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_Gslabel.mas_top);
        make.left.equalTo(_Gslabel.mas_right);
    }];
    [_Dhlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_Dhlabel.mas_top);
        make.left.equalTo(_Dhlabel.mas_right);
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
