//
//  SystemMessageController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/9/13.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "SystemMessageController.h"
#import "SystemMessageCell.h"

@interface SystemMessageController ()
@property (nonatomic,strong) NSMutableArray * dataArray;
@end

@implementation SystemMessageController
-(NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"系统消息";
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=[UIColor colorWithHexString:@"#f7f7f7"];
    self.tableView.separatorStyle=0;
    self.tableView.estimatedRowHeight=100;
    self.tableView.contentInset=UIEdgeInsetsMake(Height_Pt(100), 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator=NO;
    [self.tableView registerClass:[SystemMessageCell class] forCellReuseIdentifier:@"SystemMessageCell"];
    self.tableView.transform = CGAffineTransformMakeScale (1,-1);
    [self loadHttpData];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SystemMessageCell" forIndexPath:indexPath];
    cell.contentView.transform = CGAffineTransformMakeScale (1,-1);
    cell.model=[SystemMessageModel mj_objectWithKeyValues:self.dataArray[_dataArray.count-1-indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SystemMessageModel *model=[SystemMessageModel mj_objectWithKeyValues:self.dataArray[_dataArray.count-1-indexPath.row]];
    if ([model.status integerValue]==0) {
        Weakify(self);
        [Master HttpPostRequestByParams:@{@"id":model.id} url:mlqqm serviceCode:yd Success:^(id json) {
            if ([json[@"info"] boolValue]) {
                model.status=@"1";
                [_dataArray replaceObjectAtIndex:_dataArray.count-1-indexPath.row withObject:model.mj_keyValues];
                [Wself.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        } Failure:nil andNavigation:self.navigationController];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(void)loadHttpData{
    Weakify(self);
    [Master HttpPostRequestByParams:@{@"clientId":[Acount shareManager].id} url:mlqqm serviceCode:xtxx Success:^(id json) {
        _dataArray=[[NSMutableArray alloc]initWithArray:json[@"info"]];
        [Wself.tableView reloadData];
    } Failure:nil andNavigation:self.navigationController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
