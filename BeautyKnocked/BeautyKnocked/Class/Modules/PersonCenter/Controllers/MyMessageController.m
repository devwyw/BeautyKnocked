//
//  MyMessageController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MyMessageController.h"
#import "NewsCenterCell.h"
#import "NewsCenterModel.h"

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
#warning Incomplete implementation, return the number of rows
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCellReuseIdentifier forIndexPath:indexPath];
    [self configureCell:cell indexPath:indexPath];
    return cell;
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

-(void)configureCell:(NewsCenterCell *)cell indexPath:(NSIndexPath *)indexPath {
    NewsCenterModel *news = self.dataSource[indexPath.row];
    cell.imageName = news.imgName;
    cell.signText = news.sign;
    cell.title = news.title;
    cell.descrText = news.descr;
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        NewsCenterModel *system = [[NewsCenterModel alloc] initWithImageName:@"xitongxiaoxi" sign:@"官方" title:@"系统消息" descr:@"【系统消息】您有1张优惠券,价值20元,水电费离开快速的"];
        NewsCenterModel *evaluation = [[NewsCenterModel alloc] initWithImageName:@"wodepinglun" sign:@"" title:@"我的评论" descr:@"点击查看我对产品/项目的评价"];
        NewsCenterModel *reply = [[NewsCenterModel alloc] initWithImageName:@"huifuwode" sign:@"" title:@"回复我的" descr:@"点击查看所有回复消息"];
        _dataSource = [NSMutableArray arrayWithObjects:system,evaluation,reply, nil];
    }
    return _dataSource;
}

@end
