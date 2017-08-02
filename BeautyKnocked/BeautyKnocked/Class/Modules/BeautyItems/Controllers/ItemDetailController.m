//
//  ItemDetailController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ItemDetailController.h"
#import "AddAndReserveView.h"
#import "ItemDetailViewModel.h"
#import "ConfirmOrderController.h"
#import "AddCarView.h"

@interface ItemDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AddAndReserveView *addReserveView;
@property (nonatomic, strong) ItemDetailViewModel *itemDetailViewModel;
@property (nonatomic, strong) UIImageView *tableheaderView;

@property (nonatomic,strong) UILabel * carCount;
@end

@implementation ItemDetailController

-(ItemDetailViewModel *)itemDetailViewModel {
    if (!_itemDetailViewModel) {
        _itemDetailViewModel = [[ItemDetailViewModel alloc] init];
    }
    return _itemDetailViewModel;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"0";
    [_carCount setText:@"99+"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];//关闭自动布局
    [self initializeViews];
    [self addConstraints];
    /** 购物车 */
    {
        UIButton *Car=[[UIButton alloc]initWithFrame:CGRectMake(5, Height-111, 60, 60)];
        [Car setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10.5, 10.5)];
        [Car setImage:[UIImage imageNamed:@"gouwuche_03"] forState:UIControlStateNormal];
        [Car addTarget:self action:@selector(Car:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:Car];
        
        _carCount=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
        [_carCount setFont:[UIFont systemFontOfSize:10]];
        [_carCount setTextAlignment:NSTextAlignmentCenter];
        [_carCount setTextColor:[UIColor whiteColor]];
        [_carCount setBackgroundColor:[UIColor blackColor]];
        [_carCount.layer setCornerRadius:11];
        [_carCount.layer setMasksToBounds:YES];
        [Car addSubview:_carCount];
    }
}
-(void)Car:(UIButton*)button{
    NSLog(@"1");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initializeViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 100;
    _tableView.tableHeaderView = self.tableheaderView;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.itemDetailViewModel configRegisterTableView:_tableView];
    
    /** 立即预约  购物车 */
    _addReserveView = [[AddAndReserveView alloc] init];
    [_addReserveView.reserveNowSignal subscribeNext:^(id  _Nullable x) {
        ConfirmOrderController *confirmController = [[ConfirmOrderController alloc] init];
        confirmController.orderStyle = MLItem;
        [self.navigationController pushViewController:confirmController animated:YES];
    }];

    [_addReserveView.addCar subscribeNext:^(id  _Nullable x) {
        AddCarView *view=[[AddCarView alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(790))];
        [LEEAlert actionsheet].config
        .LeeHeaderColor([UIColor clearColor])
        .LeeCustomView(view)
        .LeeActionSheetBottomMargin(-5)
        .LeeCornerRadius(0.0f)
        .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type) {
            return Width;
        })
        .LeeShow();
    }];
    
    self.itemDetailViewModel.navigationController = self.navigationController;
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
    return [self.itemDetailViewModel numberOfSectionInForTableView:tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.itemDetailViewModel numberOfRowsAtSection:section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.itemDetailViewModel configureTableView:tableView cellForRowAtIndexPath:indexPath];
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
        _tableheaderView.clipsToBounds = YES;
        _tableheaderView.contentMode = UIViewContentModeScaleAspectFill;
        _tableheaderView.frame = CGRectMake(0, 0, Width, Height_Pt(675));
        _tableheaderView.image = [UIImage imageNamed:@"chanppic"];
    }
    return _tableheaderView;
}

@end
