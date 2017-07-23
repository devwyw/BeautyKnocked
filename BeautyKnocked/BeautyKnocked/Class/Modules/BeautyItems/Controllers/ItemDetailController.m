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

@interface ItemDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AddAndReserveView *addReserveView;
@property (nonatomic, strong) ItemDetailViewModel *itemDetailViewModel;
@property (nonatomic, strong) UIImageView *tableheaderView;
@property (nonatomic,strong) UIView * addView;
@end

@implementation ItemDetailController

-(ItemDetailViewModel *)itemDetailViewModel {
    if (!_itemDetailViewModel) {
        _itemDetailViewModel = [[ItemDetailViewModel alloc] init];
    }
    return _itemDetailViewModel;
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat newoffsetY = scrollView.contentOffset.y;
//    NSInteger x=64;
//    if (newoffsetY >= 0 && newoffsetY <= x) {
//        [self.navigationController.navigationBar setAlpha:1- newoffsetY/x];
//    }else if(newoffsetY > x){
//        [self.navigationController.navigationBar setAlpha:0];
//    }else{
//        [self.navigationController.navigationBar setAlpha:1];
//    }
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"项目详情";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initializeViews];
    [self addConstraints];
    {
        UIView *gview=[[UIView alloc]initWithFrame: self.view.bounds];
        gview.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.3];
        [gview setTag:101];
        gview.hidden=YES;
        [self.view addSubview:gview];
        
        _addView=[[UIView alloc]initWithFrame:CGRectMake(0, Height, Width, Height_Pt(740))];
        [_addView setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(Width_Pt(60), -Height_Pt(50), Width_Pt(305), Height_Pt(305))];
        image.layer.masksToBounds=YES;
        image.layer.cornerRadius=8;
        //image.backgroundColor=[UIColor clearColor];
        image.contentMode=UIViewContentModeScaleAspectFit;
        [image setImage:[UIImage imageNamed:@"mote"]];
        [_addView addSubview:image];
        
        UIButton *done=[[UIButton alloc]initWithFrame:CGRectMake(0,Height_Pt(740)-Height_Pt(145), Width, Height_Pt(145))];
        [done setBackgroundColor:[UIColor colorWithHexString:@"#E1BF6E"]];
        [done setTitle:@"确定" forState:UIControlStateNormal];
        [done addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
        [_addView addSubview:done];
        
        [self.view addSubview:_addView];
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
    _tableView.estimatedRowHeight = 200;
    _tableView.tableHeaderView = self.tableheaderView;
    [self.itemDetailViewModel configRegisterTableView:_tableView];
    
    _addReserveView = [[AddAndReserveView alloc] init];
    [_addReserveView.reserveNowSignal subscribeNext:^(id  _Nullable x) {
        ConfirmOrderController *confirmController = [[ConfirmOrderController alloc] init];
        confirmController.orderStyle = MLItem;
        [self.navigationController pushViewController:confirmController animated:YES];
    }];

    [_addReserveView.addCar subscribeNext:^(id  _Nullable x) {
        UIView *view=[self.view viewWithTag:101];
        view.hidden=NO;
        [UIView animateWithDuration:0.5 animations:^{
            [_addView setFrame:CGRectMake(0, Height-64-Height_Pt(740), Width, Height_Pt(740))];
        }];
    }];
    
    self.itemDetailViewModel.navigationController = self.navigationController;
    
    [self.view addSubview:_tableView];
    [self.view addSubview:_addReserveView];
}
-(void)done:(UIButton*)btn{
    UIView *view=[self.view viewWithTag:101];
    view.hidden=YES;
    [UIView animateWithDuration:0.5 animations:^{
        [_addView setFrame:CGRectMake(0, Height, Width, Height_Pt(740))];
    }];
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
        _tableheaderView.frame = CGRectMake(0, 0, Width, Height_Pt(675));
        _tableheaderView.image = [UIImage imageNamed:@"mote"];
    }
    return _tableheaderView;
}

@end
