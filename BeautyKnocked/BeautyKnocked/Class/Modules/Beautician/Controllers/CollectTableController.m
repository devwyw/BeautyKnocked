//
//  CollectTableController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/9/12.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "CollectTableController.h"
#import "BeauticianCell.h"
#import "BeauticianItemPageController.h"
#import <MJRefresh.h>

@interface CollectTableController ()
@property (nonatomic,strong) NSArray * listArray;
@end

@implementation CollectTableController
-(instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}
-(NSArray*)listArray{
    if (!_listArray) {
        _listArray=[[NSArray alloc]init];
    }
    return _listArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"收藏技师"];
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.backgroundColor=[UIColor colorWithHexString:@"#F0F0F0"];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[BeauticianCell class] forCellReuseIdentifier:@"BeauticianCell"];
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHttpData)];
    [self.tableView.mj_header beginRefreshing];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BeauticianCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BeauticianCell" forIndexPath:indexPath];
    cell.model=[BeauticianModel mj_objectWithKeyValues:self.listArray[indexPath.row]];
    cell.isCancel=YES;
    Weakify(self);
    [[cell.collect takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
        //取消收藏
        [Master HttpPostRequestByParams:@{@"clientId":[Acount shareManager].id,@"beauticianId":cell.model.id} url:mlqqm serviceCode:qxsc Success:^(id json) {
            if ([json[@"info"] boolValue]) {
                [Master showSVProgressHUD:@"取消成功" withType:ShowSVProgressTypeSuccess withShowBlock:^{
                    [Wself.tableView.mj_header beginRefreshing];
                }];
            }
        } Failure:nil andNavigation:Wself.navigationController];
    }];
    [[cell.reserve takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
        //预约
        BeauticianItemPageController *beauticianPageController = [[BeauticianItemPageController alloc] init];
        beauticianPageController.model=cell.model;
        [beauticianPageController setHidesBottomBarWhenPushed:YES];
        [Wself.navigationController pushViewController:beauticianPageController animated:YES];
    }];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(void)loadHttpData{
    Weakify(self);
    [Master HttpPostRequestByParams:@{@"clientId":[Acount shareManager].id} url:mlqqm serviceCode:sclb Success:^(id json) {
        _listArray=[[NSArray alloc]initWithArray:json[@"info"]];
        [Wself.tableView.mj_header endRefreshing];
        [Wself.tableView reloadData];
    } Failure:nil andNavigation:self.navigationController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
