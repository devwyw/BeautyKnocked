//
//  ProductDetailController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ProductDetailController.h"
#import "AddAndReserveView.h"
#import "ProductDetailViewModel.h"
#import "ConfirmOrderController.h"

@interface ProductDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AddAndReserveView *addReserveView;
@property (nonatomic, strong) ProductDetailViewModel *productDetailViewModel;
@property (nonatomic, strong) UIImageView *tableheaderView;
@end

@implementation ProductDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"产品详情";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initializeViews];
    [self addConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializeViews {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = self.tableheaderView;
    _tableView.estimatedRowHeight = 200;
    [self.productDetailViewModel configRegisterTableView:_tableView];
    
    self.productDetailViewModel.navigationController = self.navigationController;
    
    _addReserveView = [[AddAndReserveView alloc] init];
    [_addReserveView.reserveNowSignal subscribeNext:^(id  _Nullable x) {
        ConfirmOrderController *confirmController = [[ConfirmOrderController alloc] init];
        confirmController.orderStyle = MLProduct;
        [self.navigationController pushViewController:confirmController animated:YES];
    }];
    
    [self.view addSubview:_tableView];
    [self.view addSubview:_addReserveView];
    
}
-(void)addConstraints {
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, Height_Pt(147), 0));
    }];
    
    [_addReserveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom);
        make.left.and.right.and.bottom.equalTo(self.view);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.productDetailViewModel numberOfSectionInForTableView:tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.productDetailViewModel numberOfRowsAtSection:section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.productDetailViewModel configureTableView:tableView cellForRowAtIndexPath:indexPath];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return Height_Pt(20);
}

-(UIImageView *)tableheaderView {
    if (!_tableheaderView) {
        _tableheaderView = [[UIImageView alloc] init];
        _tableheaderView.frame = CGRectMake(0, 0, Width, Height_Pt(675));
        _tableheaderView.image = [UIImage imageNamed:@"mote"];
    }
    return _tableheaderView;
}
-(ProductDetailViewModel *)productDetailViewModel {
    if (!_productDetailViewModel) {
        _productDetailViewModel = [[ProductDetailViewModel alloc] init];
    }
    return _productDetailViewModel;
}

@end
