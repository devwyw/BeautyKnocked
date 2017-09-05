//
//  ItemDetailController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ItemDetailController.h"
#import "AddAndReserveView.h"
#import "ConfirmOrderController.h"
#import "CarItem.h"
#import "ItemDetailViewModel.h"


@interface ItemDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AddAndReserveView *addReserveView;
@property (nonatomic, strong) UIImageView *tableheaderView;
@property (nonatomic, strong) CarItem * carItem;
@property (nonatomic, strong) ItemDetailViewModel *itemDetailViewModel;

@end

@implementation ItemDetailController
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat OffsetY=scrollView.contentOffset.y;
    CGFloat MaxY=Height/2.5;
    if (OffsetY >= 0 && OffsetY <= MaxY) {
        _alpha = [NSString stringWithFormat:@"%f",OffsetY/MaxY];
    }else if(OffsetY > MaxY){
        _alpha = @"1";
    }else{
        _alpha=@"0";
    }
    self.BarAlpha = _alpha;
}

-(ItemDetailViewModel *)itemDetailViewModel {
    if (!_itemDetailViewModel) {
        _itemDetailViewModel = [[ItemDetailViewModel alloc] init];
    }
    return _itemDetailViewModel;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.BarAlpha = _alpha;
    _carItem.count=100;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (isStringEmpty(self.projectId)) {
        self.title=@"项目详情";
    }else{
        self.title=@"套餐详情";
    }
    
    [self initializeViews];
    [self addConstraints];
    
    /** 购物车Item */
    {
        _carItem=[[CarItem alloc]initWithOriginY:Height-111];
        [_carItem.pushCar subscribeNext:^(id  _Nullable x) {
            NSLog(@"购物车");
        }];
        [self.view addSubview:_carItem];
    }
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
    [self.view addSubview:_tableView];

    _addReserveView = [[AddAndReserveView alloc] init];
    if (isStringEmpty(self.projectId)) {
        _addReserveView.type=@"0";
    }else{
        _addReserveView.type=@"1";
    }
    Weakify(self);
    [_addReserveView.reserveNowSignal subscribeNext:^(id  _Nullable x) {
        //立即预约
        if ([[Acount shareManager] isSignInWithNavigationController:Wself.navigationController]) {
            ConfirmOrderController *confirmController = [[ConfirmOrderController alloc] init];
            if (isStringEmpty(self.projectId)) {
                confirmController.orderStyle = MLItem;
                confirmController.detailModel=self.itemDetailViewModel.model;
            }else{
                confirmController.orderStyle = MLPackage;
                confirmController.packageInfoModel=self.itemDetailViewModel.Pmodel;
            }
            [Wself.navigationController pushViewController:confirmController animated:YES];
        }
    }];
    [self.view addSubview:_addReserveView];
    
    self.itemDetailViewModel.navigationController = self.navigationController;
    if (isStringEmpty(self.projectId)) {
        [self loadHttpData:self.detailID withProjectId:@""];
    }else{
        [self loadHttpData:self.detailID withProjectId:self.projectId];
    }
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
    }
    return _tableheaderView;
}
#pragma mark ===== 详情 =====
-(void)loadHttpData:(NSString*)detailID withProjectId:(NSString*)projectId{
    NSString *code=nil;
    if (isStringEmpty(projectId)) {
        code=xmxq;
    }else{
        code=tcxq;
    }
    Weakify(self);
    [Master HttpPostRequestByParams:@{@"id":detailID,@"projectId":projectId} url:mlqqm serviceCode:code Success:^(id json) {
        if (isStringEmpty(projectId)) {
            Wself.itemDetailViewModel.model=[DetailModel mj_objectWithKeyValues:json[@"info"]];
            [Master GetWebImage:Wself.tableheaderView withUrl:Wself.itemDetailViewModel.model.imagePath];
        }else{
            Wself.itemDetailViewModel.Pmodel=[PackageInfoModel mj_objectWithKeyValues:json[@"info"]];
            [Master GetWebImage:Wself.tableheaderView withUrl:Wself.itemDetailViewModel.Pmodel.imagePath];
        }
        /** 评论列表 */
        [Master HttpPostRequestByParams:@{@"id":detailID,@"type":@"1"} url:mlqqm serviceCode:pllb Success:^(id json) {
            Wself.itemDetailViewModel.listArray=[[NSArray alloc]initWithArray:json[@"info"]];
            [_tableView reloadData];
        } Failure:nil andNavigation:Wself.navigationController];
    } Failure:nil andNavigation:Wself.navigationController];
}
@end
