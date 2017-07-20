//
//  HomeController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/6.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "HomeController.h"
#import "HomePageViewModel.h"

@interface HomeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HomePageViewModel *homePageViewModel;

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
    [super viewWillAppear:YES];
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
    [super viewWillDisappear:YES];
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
    [SVProgressHUD showInfoWithStatus:@"目前只提供南昌地区的服务"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD dismissWithDelay:1.85];
}
-(void)setHeaderView{
    //顶部控件
    {
        UIButton *item = [[UIButton alloc]initWithFrame:CGRectMake(15, 2, 60, 40)];
        [item setTag:101];
        [item setTitle:@"南昌" forState:UIControlStateNormal];
        [item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:@"shouyelocation"] forState:UIControlStateNormal];
        [item setImagePosition:LXMImagePositionRight spacing:5];
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
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4009158919"]];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setHeaderView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.homePageViewModel.navigationController = self.navigationController;
    [self addSubItemviews];
    [self configureConstraints];

    /** 购物车 */
    UIButton *button=[DocumentsManager getCarViewWithOrigin:CGPointMake(5, Height-170)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(Car:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)Car:(UIButton*)button{
    NSLog(@"1");
}
-(void)addSubItemviews {
    [self.view addSubview:self.tableView];
}

-(void)configureConstraints {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
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
    // Dispose of any resources that can be recreated.
}


-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = 0;
        _tableView.estimatedRowHeight = 300;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}




@end
