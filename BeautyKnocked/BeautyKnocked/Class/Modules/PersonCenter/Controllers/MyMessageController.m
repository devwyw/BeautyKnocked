//
//  MyMessageController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MyMessageController.h"
#import "NewsCenterCell.h"
#import "SystemMessageController.h"
#import "MyPLMessageController.h"

static NSString *const messageCellReuseIdentifier = @"NewsCenterCell";
@interface MyMessageController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MyMessageController

-(instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    [self.tableView registerClass:[NewsCenterCell class] forCellReuseIdentifier:messageCellReuseIdentifier];
    self.tableView.rowHeight = Height_Pt(218);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCellReuseIdentifier forIndexPath:indexPath];
    cell.model=self.dataSource[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        SystemMessageController *controller=[[SystemMessageController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        MyPLMessageController *controller=[[MyPLMessageController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,Width_Pt(185),0,0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,Width_Pt(185),0,0)];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        NewsCenterModel *system = [[NewsCenterModel alloc] initWithImageName:@"xitongxiaoxi" title:@"【系统消息】" descr:@"查看最新推送的消息及各种优惠信息..."];
        NewsCenterModel *evaluation = [[NewsCenterModel alloc] initWithImageName:@"wodepinglun" title:@"我的评论" descr:@"查看我对产品/项目的评价"];
        _dataSource = [NSMutableArray arrayWithObjects:system,evaluation,nil];
    }
    return _dataSource;
}

@end
