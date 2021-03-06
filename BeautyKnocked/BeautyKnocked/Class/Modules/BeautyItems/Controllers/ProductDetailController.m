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
#import "AddCarView.h"
#import "CarItem.h"
#import "ShopCarController.h"

@interface ProductDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AddAndReserveView *addReserveView;
@property (nonatomic, strong) ProductDetailViewModel *productDetailViewModel;
@property (nonatomic, strong) UIImageView *tableheaderView;
@property (nonatomic, strong) CarItem * carItem;
@end

@implementation ProductDetailController

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
    self.title=@"产品详情";
    [self initializeViews];
    [self addConstraints];
    [self loadHttpData];
    
    /** 购物车Item */
    {
        Weakify(self);
        _carItem=[[CarItem alloc]initWithOriginY:Height-111];
        [_carItem.pushCar subscribeNext:^(id  _Nullable x) {
            if ([[Acount shareManager] isSignInWithNavigationController:Wself.navigationController]) {
                ShopCarController *car=[[ShopCarController alloc]init];
                [Wself.navigationController pushViewController:car animated:YES];
            }
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
    _tableView.tableHeaderView = self.tableheaderView;
    _tableView.estimatedRowHeight = 100;
    _tableView.showsVerticalScrollIndicator = NO;
    
    self.productDetailViewModel.navigationController = self.navigationController;
    
    _addReserveView = [[AddAndReserveView alloc] init];
    _addReserveView.type=@"2";
    Weakify(self);
    [_addReserveView.reserveNowSignal subscribeNext:^(id  _Nullable x) {
        if ([[Acount shareManager] isSignInWithNavigationController:Wself.navigationController]) {
            ConfirmOrderController *confirmController = [[ConfirmOrderController alloc] init];
            confirmController.orderStyle = MLProduct;
            confirmController.productModel=_productDetailViewModel.model;
            [Wself.navigationController pushViewController:confirmController animated:YES];
        }
    }];
    
    [_addReserveView.addCar subscribeNext:^(id  _Nullable x) {
        [Master HttpPostRequestByParams:@{@"clientId":[Acount shareManager].id,@"productId":_id} url:mlqqm serviceCode:yjrgwc Success:^(id json) {
            if ([json[@"info"] boolValue]) {
                [Master showSVProgressHUD:@"此产品已加入购物车~" withType:ShowSVProgressTypeInfo withShowBlock:nil];
            }else{
                AddCarView *view=[[AddCarView alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(790))];
                [view.doneAction subscribeNext:^(id  _Nullable x) {
                    [Master HttpPostRequestByParams:@{@"clientId":[Acount shareManager].id,@"productId":_id,@"num":view.count} url:mlqqm serviceCode:jrgwc Success:^(id json) {
                        [Master RemovePopViewWithBlock:^{
                            [Master showSVProgressHUD:@"加入购物车成功~" withType:ShowSVProgressTypeSuccess withShowBlock:nil];
                        }];
                    } Failure:nil andNavigation:Wself.navigationController];
                }];
                [Master PopSheetView:view];
            }
        } Failure:nil andNavigation:Wself.navigationController];
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
        _tableheaderView.clipsToBounds = YES;
        _tableheaderView.contentMode = UIViewContentModeScaleAspectFill;
        _tableheaderView.frame = CGRectMake(0, 0, Width, Height_Pt(675));
    }
    return _tableheaderView;
}
-(ProductDetailViewModel *)productDetailViewModel {
    if (!_productDetailViewModel) {
        _productDetailViewModel = [[ProductDetailViewModel alloc] init];
    }
    return _productDetailViewModel;
}
#pragma mark ===== 产品详情 =====
-(void)loadHttpData{
    Weakify(self);
    [Master HttpPostRequestByParams:@{@"id":_id} url:mlqqm serviceCode:cpxq Success:^(id json) {
        Wself.productDetailViewModel.model=[ProductModel mj_objectWithKeyValues:json[@"info"]];
        [Master GetWebImage:Wself.tableheaderView withUrl:Wself.productDetailViewModel.model.imagePath];
        /** 评论列表 */
        [Master HttpPostRequestByParams:@{@"id":_id,@"type":@"1"} url:mlqqm serviceCode:pllb Success:^(id json) {
            Wself.productDetailViewModel.listArray=[[NSArray alloc]initWithArray:json[@"info"]];
            [_tableView reloadData];
        } Failure:nil andNavigation:Wself.navigationController];
    } Failure:nil andNavigation:Wself.navigationController];
}
@end
