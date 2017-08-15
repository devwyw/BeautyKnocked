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
#import <UIImageView+WebCache.h>
#import "ProductModel.h"

@interface ProductDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AddAndReserveView *addReserveView;
@property (nonatomic, strong) ProductDetailViewModel *productDetailViewModel;
@property (nonatomic, strong) UIImageView *tableheaderView;
@property (nonatomic, strong) CarItem * carItem;
@end

@implementation ProductDetailController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat OffsetY=scrollView.contentOffset.y;
    if (OffsetY >= 0 && OffsetY <= 64) {
        _alpha = [NSString stringWithFormat:@"%f",OffsetY/64];
    }else if(OffsetY > 64){
        _alpha = @"1";
    }else{
        _alpha=@"0";
    }
    self.navBarBgAlpha = _alpha;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = _alpha;
    _carItem.count=100;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"产品详情";
    [self setAutomaticallyAdjustsScrollViewInsets:NO];//关闭自动布局
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
    [self loadHttpData:self.productID];
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
    [_addReserveView.reserveNowSignal subscribeNext:^(id  _Nullable x) {
        ConfirmOrderController *confirmController = [[ConfirmOrderController alloc] init];
        confirmController.orderStyle = MLProduct;
        [self.navigationController pushViewController:confirmController animated:YES];
    }];
    
    [_addReserveView.addCar subscribeNext:^(id  _Nullable x) {
        AddCarView *view=[[AddCarView alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(790))];
        [view.doneAction subscribeNext:^(id  _Nullable x) {
            [LEEAlert closeWithCompletionBlock:^{
                NSLog(@"%@",view.count);
            }];
        }];
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
-(void)loadHttpData:(NSString*)productID{
    [Master HttpPostRequestByParams:@{@"id":productID} url:mlqqm serviceCode:cpxq Success:^(id json) {
        self.productDetailViewModel.model=[ProductModel mj_objectWithKeyValues:json[@"info"]];
        [self.tableheaderView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mlqqm,self.productDetailViewModel.model.imagePath]] placeholderImage:[UIImage imageNamed:@"chanppic"]];
        /** 评论列表 */
        [Master HttpPostRequestByParams:@{@"id":productID,@"type":@"1"} url:mlqqm serviceCode:pllb Success:^(id json) {
            self.productDetailViewModel.listArray=[[NSArray alloc]initWithArray:json[@"info"]];
            [_tableView reloadData];
        } Failure:nil];
    } Failure:nil];
}
@end
