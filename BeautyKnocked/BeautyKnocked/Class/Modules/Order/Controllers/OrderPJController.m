//
//  OrderPJController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "OrderPJController.h"
#import "PJBeautViewCell.h"
#import "PJItemViewCell.h"

@interface OrderPJController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableview;
@end

@implementation OrderPJController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title=@"订单评价";

    _tableview=[[UITableView alloc]init];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableview.backgroundColor=[UIColor colorWithHexString:@"#EBEBEB"];
    _tableview.estimatedRowHeight = 100;
    
    [_tableview registerClass:[PJBeautViewCell class] forCellReuseIdentifier:@"PJBeautViewCell"];
    [_tableview registerClass:[PJItemViewCell class] forCellReuseIdentifier:@"PJItemViewCell"];
    
    [self.view addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        PJBeautViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PJBeautViewCell" forIndexPath:indexPath];
        cell.imageName=@"meirongshi_03";
        cell.titleStr=@"01  橙梦露";
        return cell;
    }else{
        PJItemViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PJItemViewCell" forIndexPath:indexPath];
        cell.imageName=@"meirongshi_03";
        cell.titleStr=@"深层卸妆乳-100ml";
        return cell;
    }
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
