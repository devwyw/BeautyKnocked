//
//  BeauticianController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/10.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeauticianController.h"
#import "BeauticianSortMenuView.h"
#import "BeauticianCell.h"
#import "BeauticianItemPageController.h"
#import "BeauticianModel.h"

@interface BeauticianController ()<UITableViewDelegate,UITableViewDataSource,BeauticianSortMenuViewDelegate>

@property (nonatomic,strong) BeauticianSortMenuView *sortMenu;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * listArray;
@end

@implementation BeauticianController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
-(void)setIsSelected:(BOOL)isSelected{
    _isSelected=isSelected;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (_isSelected) {
        [self.navigationItem setTitle:@"选择美容师"];
    }else{
        [self.navigationItem setTitle:@"预约美容师"];
    }
    
    [self addSubItemviews];
    [self configureConstraints];
}
-(NSMutableArray*)listArray{
    if (!_listArray) {
        _listArray=[[NSMutableArray alloc]init];
    }
    return _listArray;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BeauticianModel *model=[[BeauticianModel alloc]init];
    model=[BeauticianModel mj_objectWithKeyValues:self.listArray[indexPath.row]];
    BeauticianCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BeauticianCell" forIndexPath:indexPath];
    cell.isBeauticianSelect=_isSelected;
    cell.model=model;
    Weakify(self);
    [[cell.beaSelect takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
        //选择
        [self.beauticianId sendNext:model.id];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [[cell.collect takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
        //收藏
        Acount *user=[Acount shareManager];
        if ([user isSignInWithNavigationController:Wself.navigationController]) {
            UIButton *btn=(UIButton*)x;
            if (!btn.isSelected) {
                [Master HttpPostRequestByParams:@{@"device":UUID,@"clientId":user.id,@"beauticianId":model.id} url:mlqqm serviceCode:khsc Success:^(id json) {
                    btn.selected=!btn.isSelected;
                    [Master showSVProgressHUD:@"收藏成功" withType:ShowSVProgressTypeSuccess withShowBlock:^{
                        [Wself loadHttpData];
                    }];
                } Failure:nil];
            }
        }
    }];
    [[cell.reserve takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
        //预约
        BeauticianItemPageController *beauticianPageController = [[BeauticianItemPageController alloc] init];
        [beauticianPageController setHidesBottomBarWhenPushed:YES];
        [Wself.navigationController pushViewController:beauticianPageController animated:YES];
    }];
    return cell;
}
-(void)addSubItemviews {
    [self.view addSubview:self.sortMenu];
    [self.view addSubview:self.tableView];
}

-(void)configureConstraints {
    [self.sortMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64.f);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(Height_Pt(122.f));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sortMenu.mas_bottom);
        make.left.and.right.and.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-49.f);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BeauticianSortMenuView *)sortMenu {
    if (!_sortMenu) {
        _sortMenu = [[BeauticianSortMenuView alloc] init];
        _sortMenu.delegate=self;
    }
    return _sortMenu;
}
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = 0;
        _tableView.estimatedRowHeight = 100;
        _tableView.backgroundColor=[UIColor colorWithHexString:@"#F0F0F0"];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHttpData)];
        [_tableView.mj_header beginRefreshing];
        [_tableView registerClass:[BeauticianCell class] forCellReuseIdentifier:@"BeauticianCell"];
    }
    return _tableView;
}
-(void)loadHttpData{
    NSString *aid=[[NSString alloc]init];
    if (isStringEmpty([Acount shareManager].id)) {
        aid=@"0";
    }else{
        aid=[Acount shareManager].id;
    }
    [Master HttpPostRequestByParams:@{@"clientId":aid} url:mlqqm serviceCode:mrslb Success:^(id json) {
        [self.listArray removeAllObjects];
        self.listArray=json[@"info"];
        [_tableView.mj_header endRefreshing];
        [_tableView reloadData];
    } Failure:nil];
}
-(void)loadHttpData:(NSInteger)row{
    NSString *aid=[[NSString alloc]init];
    if (isStringEmpty([Acount shareManager].id)) {
        aid=@"0";
    }else{
        aid=[Acount shareManager].id;
    }
    [Master HttpPostRequestByParams:@{@"clientId":aid,@"field":[NSString stringWithFormat:@"%ld",row]} url:mlqqm serviceCode:mrslbpx Success:^(id json) {
        [self.listArray removeAllObjects];
        self.listArray=json[@"info"];
        [_tableView reloadData];
    } Failure:nil];
}
-(void)didSelectAtRow:(NSInteger)row{
    switch (row) {
        case 1:
        {
            [self loadHttpData:7];
        }
            break;
        case 2:
        {
            [self loadHttpData:6];
        }
            break;
        default:
            [self loadHttpData];
            break;
    }
}
-(void)selectedDay:(NSString *)day{
    NSLog(@"%@",day);
}
@end
