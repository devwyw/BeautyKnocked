//
//  MineController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/6.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MineController.h"
#import "UserCnterViewModel.h"

static NSString *const cellIdentifier = @"UserCenterTableViewCell";
@interface MineController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UserCnterViewModel *userCenterViewModel;
@end

@implementation MineController

-(instancetype)init {
    self = [super init];
    if (self) {
        _userCenterViewModel = [[UserCnterViewModel alloc]init];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.userCenterViewModel.headView getUserData];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.StatusDefaultBar=@"0";
    self.BarColor = [ThemeColor toColorString];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F0F0F0"];
    [self createViews];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.userCenterViewModel numberForRowsInSection:section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [self.userCenterViewModel configureCell:cell indexPath:indexPath];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.userCenterViewModel heightForRowAtIndexPath:indexPath];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.userCenterViewModel configureTableView:tableView didSelectedAtIndexPath:indexPath];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section==2) {
        return CGFLOAT_MIN;
    }
    return Height_Pt(20);
}
-(void)createViews {
    self.userCenterViewModel.navigationController = self.navigationController;
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor=[UIColor clearColor];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces=NO;
    [self.view addSubview:_tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(-20, 0, 0, 0));
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
