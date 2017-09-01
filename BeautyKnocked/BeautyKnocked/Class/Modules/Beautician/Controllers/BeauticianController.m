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
#import <MJRefresh.h>

@interface BeauticianController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) BeauticianSortMenuView *sortMenu;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * listArray;
@end

@implementation BeauticianController
- (void)viewDidLoad {
    [super viewDidLoad];
    if (_isType==1) {
        [self.navigationItem setTitle:@"选择美容师"];
    }else if(_isType==2){
        [self.navigationItem setTitle:@"收藏美容师"];
    }else{
        [self.navigationItem setTitle:@"预约美容师"];
    }
    self.edgesForExtendedLayout=UIRectEdgeNone;
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
    BeauticianModel *model=[BeauticianModel mj_objectWithKeyValues:self.listArray[indexPath.row]];
    BeauticianCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BeauticianCell" forIndexPath:indexPath];
    cell.isBeauticianSelect=_isType==1 ? YES:NO;
    cell.model=model;
    Weakify(self);
    [[cell.beaSelect takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
        //选择
        [Wself.beauticianId sendNext:model.id];
        [Wself.navigationController popViewControllerAnimated:YES];
    }];
    [[cell.collect takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
        //收藏
        Acount *user=[Acount shareManager];
        if ([user isSignInWithNavigationController:Wself.navigationController]) {
            UIButton *btn=(UIButton*)x;
            if (!btn.isSelected) {
                [Master HttpPostRequestByParams:@{@"clientId":user.id,@"beauticianId":model.id} url:mlqqm serviceCode:khsc Success:^(id json) {
                    btn.selected=!btn.isSelected;
                    [Master showSVProgressHUD:@"收藏成功" withType:ShowSVProgressTypeSuccess withShowBlock:^{
                        [Wself.tableView.mj_header beginRefreshing];
                    }];
                } Failure:nil andNavigation:Wself.navigationController];
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
        make.top.equalTo(self.view);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(Height_Pt(122));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sortMenu.mas_bottom);
        make.left.and.right.and.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    if (_isType!=0) {
        _sortMenu.hidden=YES;
        [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BeauticianSortMenuView *)sortMenu {
    if (!_sortMenu) {
        Weakify(self);
        _sortMenu = [[BeauticianSortMenuView alloc] init];
        _sortMenu.subRow=[RACSubject subject];
        [_sortMenu.subRow subscribeNext:^(id  _Nullable x) {
            switch ([x integerValue]) {
                case 1:
                {
                    [Wself loadHttpData:7];
                }
                    break;
                case 2:
                {
                    [Wself loadHttpData:6];
                }
                    break;
                default:
                    [_tableView.mj_header beginRefreshing];
                    break;
            }
        }];
        _sortMenu.subDay=[RACSubject subject];
        [_sortMenu.subDay subscribeNext:^(id  _Nullable x) {
            [Master HttpPostRequestByParams:@{@"clientId":[Acount shareManager].id,@"day":x} url:mlqqm serviceCode:mrssx Success:^(id json) {
                [_listArray removeAllObjects];
                _listArray=[[NSMutableArray alloc]initWithArray:json[@"info"]];
                [_tableView reloadData];
            } Failure:nil andNavigation:Wself.navigationController];
        }];
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
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadHttpData];
        }];
        [_tableView.mj_header beginRefreshing];
        [_tableView registerClass:[BeauticianCell class] forCellReuseIdentifier:@"BeauticianCell"];
    }
    return _tableView;
}
-(void)loadHttpData{
    if (isStringEmpty(_serviceTime)&&isStringEmpty(_pactServiceTime)) {
        NSString *aid=[[NSString alloc]init];
        if (isStringEmpty([Acount shareManager].id)) {
            aid=@"0";
        }else{
            aid=[Acount shareManager].id;
        }
        [Master HttpPostRequestByParams:@{@"clientId":aid} url:mlqqm serviceCode:mrslb Success:^(id json) {
            [self.listArray removeAllObjects];
            self.listArray=[[NSMutableArray alloc]initWithArray:json[@"info"]];
            [_tableView.mj_header endRefreshing];
            [_tableView reloadData];
        } Failure:nil andNavigation:self.navigationController];
    }else{
        [Master HttpPostRequestByParams:@{@"timeLength":_serviceTime,@"time":_pactServiceTime} url:mlqqm serviceCode:mrsskbsx Success:^(id json) {
            [self.listArray removeAllObjects];
            self.listArray=[[NSMutableArray alloc]initWithArray:json[@"info"]];
            [_tableView.mj_header endRefreshing];
            [_tableView reloadData];
        } Failure:nil andNavigation:self.navigationController];
    }
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
        self.listArray=[[NSMutableArray alloc]initWithArray:json[@"info"]];
        [_tableView reloadData];
    } Failure:nil andNavigation:self.navigationController];
}
@end
