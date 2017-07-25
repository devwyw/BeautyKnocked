//
//  OrderBaseTableViewController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "OrderBaseTableViewController.h"
#import "OrderTableViewCell.h"
#import "OrderMessageViewController.h"
#import "WuLiuController.h"

static NSString *const orderTableViewCellIdentifier = @"OrderTableViewCell";

@interface OrderBaseTableViewController ()<OrderTableViewCellDelegate>

@end

@implementation OrderBaseTableViewController

-(instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F7F7F7"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:orderTableViewCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    switch (_index) {
        case 0:
            return 15;
        case 1:
            return 4;
        case 2:
            return 5;
        case 3:
            return 6;
        default:
            return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderTableViewCellIdentifier forIndexPath:indexPath];
    cell.cellDelegate=self;
    
    [cell.leftButton addTarget:self action:@selector(leftPush:) forControlEvents:UIControlEventTouchUpInside];
    [cell.rightButton addTarget:self action:@selector(rightPush:) forControlEvents:UIControlEventTouchUpInside];
    /*
     查看评价 再次购买
     技师定位 联系技师 - 查看物流 确认收货
     追加订单 确认订单
     删除订单 去评价 All
     */
    return cell;
}
-(void)cellPush{
    OrderMessageViewController *controller=[[OrderMessageViewController alloc]init];
    controller.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)leftPush:(UIButton*)btn{
    NSLog(@"左边");
}
-(void)rightPush:(UIButton*)btn{
    WuLiuController *controller=[[WuLiuController alloc]init];
    controller.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:controller animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Height_Pt(110)*2+Height_Pt(300)*2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

@end
