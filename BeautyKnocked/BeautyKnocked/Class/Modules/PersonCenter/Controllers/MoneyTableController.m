//
//  MoneyTableController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MoneyTableController.h"
#import "MoneyCell.h"

@interface MoneyTableController ()
@property (nonatomic,strong) NSArray * dataArray;
@end

@implementation MoneyTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"余额明细";
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    self.tableView.backgroundColor=self.view.backgroundColor;
    self.tableView.estimatedRowHeight=100;
    [self.tableView registerClass:[MoneyCell class] forCellReuseIdentifier:@"MoneyCell"];
    [self loadHttpData];
}
-(NSArray*)dataArray{
    if (!_dataArray) {
        _dataArray=[[NSArray alloc]init];
    }
    return _dataArray;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoneyCell" forIndexPath:indexPath];
    cell.model=[MoneyInfoModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(void)loadHttpData{
    Weakify(self);
    [Master HttpPostRequestByParams:@{@"clientId":[Acount shareManager].id} url:mlqqm serviceCode:yemx Success:^(id json) {
        _dataArray=[[NSArray alloc]initWithArray:json[@"info"]];
        [Wself.tableView reloadData];
    } Failure:nil andNavigation:self.navigationController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
