//
//  EditAddressController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/6.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "EditAddressController.h"
#import "AddressEditView.h"
#import "AddressToDefaultView.h"

@interface EditAddressController ()

@property (nonatomic, strong) AddressEditView *customerNameView;
@property (nonatomic, strong) AddressEditView *telePhoneView;
@property (nonatomic, strong) AddressEditView *serviceCityView;
@property (nonatomic, strong) AddressEditView *serviceAddressView;
@property (nonatomic, strong) AddressEditView *houseNumberView;
@property (nonatomic, strong) AddressToDefaultView *defaultSelectView;
@end

@implementation EditAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBarButtonClicked)];
    
    [self initializeViews];
    [self addConstraints];
    
}

-(void)initializeViews {
    _customerNameView = [self createAddressViewWithTitle:@"顾客姓名" placeholder:@"请输入姓名"];
    _telePhoneView = [self createAddressViewWithTitle:@"手机号码" placeholder:@"请输入手机号码"];
    _serviceCityView = [self createAddressViewWithTitle:@"服务城市" placeholder:@""];
    _serviceCityView.content = @"南昌";
    _serviceAddressView = [self createAddressViewWithTitle:@"服务地址" placeholder:@"精确到区名-路名-小区名"];
    _houseNumberView = [self createAddressViewWithTitle:@"门牌号码" placeholder:@"如A栋一单元202"];
    _defaultSelectView = [[AddressToDefaultView alloc] init];
    
    NSArray *titles = @[@"新增地址",@"修改地址",@"选择地址"];
    self.title = [titles objectAtIndex:_editStyle];
    
    if (_editStyle == AddressEditStyleUpdate) {
        _customerNameView.content = @"刘亦菲";
        _telePhoneView.content = @"180****8989";
        _serviceCityView.content = @"古怪市";
        _serviceAddressView.content = @"阳光滩新区沙迦路金久国际大厦";
        _houseNumberView.content = @"888号";
        _defaultSelectView.isDefaultAddress = YES;
    }

    
    [self.view addSubview:_customerNameView];
    [self.view addSubview:_telePhoneView];
    [self.view addSubview:_serviceCityView];
    [self.view addSubview:_serviceAddressView];
    [self.view addSubview:_houseNumberView];
    [self.view addSubview:_defaultSelectView];
}
-(void)addConstraints {
    NSArray *views = @[_customerNameView,_telePhoneView,_serviceCityView,_serviceAddressView,_houseNumberView,_defaultSelectView];
    
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(Height_Pt(135));
    }];
    
    [_customerNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
    }];
    
    [_telePhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_customerNameView.mas_bottom);
    }];
    
    [_serviceCityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_telePhoneView.mas_bottom);
    }];
    
    [_serviceAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_serviceCityView.mas_bottom);
    }];
    
    [_houseNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_serviceAddressView.mas_bottom);
    }];
    
    [_defaultSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_houseNumberView.mas_bottom);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(AddressEditView *)createAddressViewWithTitle:(NSString *)title placeholder:(NSString *)placeholder {
    AddressEditView *addressView = [[AddressEditView alloc] init];
    addressView.placeholder =  placeholder;
    addressView.title = title;
    return addressView;
}

-(void)saveBarButtonClicked {
    
}


@end
