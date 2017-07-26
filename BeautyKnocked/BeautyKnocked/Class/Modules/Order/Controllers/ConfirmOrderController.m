//
//  ConfirmOrderController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ConfirmOrderController.h"
#import "ConfirmOrderViewModel.h"
#import "ConfirmOrderSubmitView.h"
#include "UIViewController+Cloudox.h"

@interface ConfirmOrderController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) ConfirmOrderViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ConfirmOrderSubmitView *submitOrderView;

@end

@implementation ConfirmOrderController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"1";
}
-(ConfirmOrderViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ConfirmOrderViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"确认订单";
    [self initializeInterface];
    [self blinds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel ddcs_numberOfSectionsInTableView:tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel ddcs_tableView:tableView numberOfRowsInSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel ddcs_tableView:tableView cellForRowAtIndexPath:indexPath];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.viewModel ddcs_tableView:tableView heightForHeaderInSection:section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.viewModel ddcs_tableView:tableView heightForFooterInSection:section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel ddcs_tableView:tableView didSelectRowAtIndexPath:indexPath];
}

-(void)initializeInterface {
    
    self.tableView = ({
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 120;
        [self.viewModel ddcs_register:_tableView];
        
        //code
        
        self.tableView;
    });
    
    _submitOrderView = [[ConfirmOrderSubmitView alloc] init];
    _submitOrderView.backgroundColor = [UIColor whiteColor];
    _submitOrderView.totalPrice = @"80";
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:_submitOrderView];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, Height_Pt(147), 0));
    }];
    
    [self.submitOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.top.equalTo(self.tableView.mas_bottom);
    }];
    
}

-(void)blinds {
    RAC(self.viewModel,navigationController) = RACObserve(self, navigationController);
    
    RAC(self.viewModel,orderStyle) = RACObserve(self, orderStyle);

}

@end
