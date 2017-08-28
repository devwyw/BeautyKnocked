//
//  BeauticianItemController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/22.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeauticianItemController.h"
#import "BeauticianItemViewModel.h"
#import "PSFooterReserveView.h"

@interface BeauticianItemController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BeauticianItemViewModel *beauticianItemViewModel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) PSFooterReserveView *reserveView;

@end

@implementation BeauticianItemController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
-(instancetype)init {
    self = [super init];
    if (self) {
        self.beauticianItemViewModel = [[BeauticianItemViewModel alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addViews];
    [self addConstraints];
    
    
}

-(void)addViews {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.reserveView];
}

-(void)addConstraints {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(self.view);
        make.bottom.equalTo(_reserveView.mas_top);
    }];
    
    [_reserveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.height.mas_equalTo(Height_Pt(146));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.beauticianItemViewModel numberOfSectionsInBeauticianItemTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.beauticianItemViewModel numberOfRowsInBeauticianItemTableViewAtSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.beauticianItemViewModel configureBeauticianItemTableView:tableView AtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.beauticianItemViewModel congigureCellHeightAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.beauticianItemViewModel configureFooterHeightAtSection:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.beauticianItemViewModel configureHeaderHeightAtSection:section];
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.beauticianItemViewModel registerCellOfBeauticianItemTableView:_tableView];
    }
    return _tableView;
}

-(PSFooterReserveView *)reserveView {
    if (!_reserveView) {
        _reserveView = [[PSFooterReserveView alloc] init];
    }
    return _reserveView;
}

@end
