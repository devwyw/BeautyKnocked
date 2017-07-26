//
//  OrderPJController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "OrderPJController.h"

@interface OrderPJController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableview;
@end

@implementation OrderPJController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title=@"订单评价";

    _tableview=[[UITableView alloc]initWithFrame:Make style:UITableViewStyleGrouped];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableview.backgroundColor=[UIColor colorWithHexString:@"#EBEBEB"];
    _tableview.estimatedRowHeight = 120;
    // Do any additional setup after loading the view.
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
