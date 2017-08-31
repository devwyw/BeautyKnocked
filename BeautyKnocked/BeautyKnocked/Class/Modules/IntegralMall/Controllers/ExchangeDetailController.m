//
//  ExchangeDetailController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/7.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ExchangeDetailController.h"
#import "ExchangeDetailViewModel.h"
#import "UIView+CornerRadius.h"

@interface ExchangeDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *exchangeButton;
@property (nonatomic, strong) ExchangeDetailViewModel *viewModel;
@property (nonatomic, strong) UIView *exchangeBackView;
@end

@implementation ExchangeDetailController

-(ExchangeDetailViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ExchangeDetailViewModel alloc] init];
    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"兑换详情";
    
    [self initializeViews];
    [self addConstraints];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel ddcs_numnumberOfSectionsInTableView:tableView];
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
-(void)initializeViews {
    
    self.viewModel.navigationController = self.navigationController;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 100;
    [self.viewModel ddcs_registerClassForTableView:_tableView];
    
    _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_exchangeButton setTitle:@"立即兑换" forState:UIControlStateNormal];
    _exchangeButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    [_exchangeButton setBackgroundColor:[UIColor greenColor]];
    [_exchangeButton makeCornerRadius:6];
    [_exchangeButton addTarget:self action:@selector(exchangeNowClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _exchangeBackView = [[UIView alloc] init];
    _exchangeBackView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_tableView];
    [self.view addSubview:_exchangeBackView];
    
    [_exchangeBackView addSubview:_exchangeButton];
}

-(void)addConstraints {
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, Height_Pt(214), 0));
    }];
    
    [_exchangeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom);
        make.left.and.right.and.bottom.equalTo(self.view);
    }];
    
    [_exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_exchangeBackView).with.insets(UIEdgeInsetsMake(Height_Pt(35), Width_Pt(35), Height_Pt(35), Height_Pt(35)));
    }];
}

-(void)exchangeNowClicked:(UIButton *)button {
    [self.viewModel exchangeClicked:button];
}

@end
