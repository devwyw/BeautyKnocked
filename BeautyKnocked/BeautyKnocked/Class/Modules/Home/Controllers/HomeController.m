//
//  HomeController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/6.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "HomeController.h"
#import "HomePageViewModel.h"
#import "UIButton+Category.h"
#import "CarItem.h"
#import <MJRefresh.h>

@interface HomeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HomePageViewModel *homePageViewModel;
@property (nonatomic,strong) CarItem * carItem;

@end

@implementation HomeController

-(instancetype)init {
    self = [super init];
    if (self) {
        _homePageViewModel = [[HomePageViewModel alloc] init];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _carItem.count=100;
    for (int i =101; i<=102; i++) {
        UIButton *item=(UIButton*)[self.navigationController.navigationBar viewWithTag:i];
        [item setHidden:NO];
    }
    {
        UIImageView *item=(UIImageView*)[self.navigationController.navigationBar viewWithTag:103];
        [item setHidden:NO];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    for (int i =101; i<=102; i++) {
        UIButton *item=(UIButton*)[self.navigationController.navigationBar viewWithTag:i];
        [item setHidden:YES];
    }
    {
        UIImageView *item=(UIImageView*)[self.navigationController.navigationBar viewWithTag:103];
        [item setHidden:YES];
    }
}
-(void)locationClick:(UIButton*)button{
    [Master showSVProgressHUD:@"目前只提供南昌地区的服务" withType:ShowSVProgressTypeInfo withShowBlock:nil];
}
-(void)setHeaderView{
    /** 顶部控件 */
    {
        UIButton *item = [[UIButton alloc]initWithFrame:CGRectMake(15, 2, 60, 40)];
        [item setTag:101];
        [item setTitle:@"南昌" forState:UIControlStateNormal];
        [item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:@"shouyelocation"] forState:UIControlStateNormal];
        [item setImgViewStyle:ButtonImgViewStyleRight imageSize:[UIImage imageNamed:@"shouyelocation"].size space:5];
        [item addTarget:self action:@selector(locationClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.navigationBar addSubview:item];
    }
    {
        UIButton *item = [[UIButton alloc]initWithFrame:CGRectMake(Width-Width_Pt(80)-15, 22-Height_Pt(80)/2, Width_Pt(80), Height_Pt(80))];
        [item setTag:102];
        [item setImage:[UIImage imageNamed:@"cell-phone_03"] forState:UIControlStateNormal];
        [item addTarget:self action:@selector(phone:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.navigationBar addSubview:item];
    }
    {
        UIImageView *item=[[UIImageView alloc]initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width/2-Width_Pt(282)/2, 22-Height_Pt(71)/2, Width_Pt(282), Height_Pt(71))];
        [item setTag:103];
        [item setImage:[UIImage imageNamed:@"top-logo_03"]];
        [item setContentMode:UIViewContentModeScaleAspectFill];
        [self.navigationController.navigationBar addSubview:item];
    }
}
-(void)phone:(UIButton*)button{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否需要拨打客服电话4009158919" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [Master pushSystemSettingWithUrl:@"tel://4009158919"];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.BarColor = [ThemeColor toColorString];
    self.StatusDefaultBar=@"0";
    [self setHeaderView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.homePageViewModel.navigationController = self.navigationController;
    /** UITableView */
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    /** 购物车Item */
    {
        _carItem=[[CarItem alloc]initWithOriginY:Height-175];
        [_carItem.pushCar subscribeNext:^(id  _Nullable x) {
            NSLog(@"购物车");
        }];
        [self.view addSubview:_carItem];
    }
    [self loadHttpImageData];
}
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHttpImageData)];
        [_tableView.mj_header beginRefreshing];
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.homePageViewModel numberOfSectionsInHomePageTableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.homePageViewModel numberOfRowsInHomePageTableViewAtSection:section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.homePageViewModel configureTableView:tableView AtIndexPath:indexPath andObject:self];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.homePageViewModel congigureCellheightAtIndexPath:indexPath];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.homePageViewModel configureHeaderHeightAtSection:section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.homePageViewModel configureFooterHeightAtSection:section];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)loadHttpImageData{
    [Master HttpPostRequestByParams:nil url:mlqqm serviceCode:lbt Success:^(id json) {
        [self.homePageViewModel.imageArray removeAllObjects];
        self.homePageViewModel.imageArray=[[NSMutableArray alloc]initWithArray:json[@"info"]];
        [_tableView.mj_header endRefreshing];
        [_tableView reloadData];
    } Failure:nil andNavigation:self.navigationController];
}
@end
