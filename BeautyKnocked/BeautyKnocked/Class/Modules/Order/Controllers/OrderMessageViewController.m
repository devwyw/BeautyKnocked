//
//  OrderMessageViewController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/25.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "OrderMessageViewController.h"
#import "ConfirmOrderFillCell.h"
#import "ConfirmOrderAddCell.h"
#import "ConfirmOrderItemCell.h"
#import "TopMessageView.h"
#import "OrderHeaderView.h"
#import "PayInfoController.h"

@interface OrderMessageViewController ()<UITableViewDelegate,UITableViewDataSource,ConfirmOrderAddCellDelegate>
@property (nonatomic,strong) UITableView * tableview;
@end

@implementation OrderMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"订单详情";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F3F2F3"]];
    [self.view addSubview:self.tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
-(UITableView*)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        [_tableview setBackgroundColor:[UIColor clearColor]];
        _tableview.estimatedRowHeight = 100;
        _tableview.separatorInset=UIEdgeInsetsMake(0,10,0,10);
        [self registerCell:_tableview];
    }
    return _tableview;
}
-(void)registerCell:(UITableView*)tableview{
    [tableview registerClass:[ConfirmOrderFillCell class] forCellReuseIdentifier:@"ConfirmOrderFillCell"   ];
    [tableview registerClass:[ConfirmOrderItemCell class] forCellReuseIdentifier:@"ConfirmOrderItemCell"];
    [tableview registerClass:[ConfirmOrderAddCell class] forCellReuseIdentifier:@"ConfirmOrderAddCell"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 4;
        case 1:
            return 5;
        case 2:
            return 2;
        default:
            return 0;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row < 2) {
                ConfirmOrderFillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderFillCell" forIndexPath:indexPath];
                cell.title = @"预约技师:";
                cell.content=@"李军晴";
                return cell;
            }else if(indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
                ConfirmOrderAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderAddCell" forIndexPath:indexPath];
                cell.delegate = self;
                cell.title = @"添加项目";
                //cell.colorStr=@"#E1BF6E";
                return cell;
            }else{
                ConfirmOrderItemCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderItemCell" forIndexPath:indexPath];
                return cell;
            }
        }
        default:
        {
            ConfirmOrderFillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderFillCell" forIndexPath:indexPath];
            cell.title = @"预约技师:";
            if (indexPath.section==1 && indexPath.row==3) {
                NSMutableAttributedString *AttStr=[[NSMutableAttributedString alloc]initWithString:@"¥468.0"];
                [AttStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, AttStr.length)];
                cell.attributed = AttStr;
            }else{
                cell.content=@"李军晴";
            }
            return cell;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return Height_Pt(200);
        default:
            return Height_Pt(135);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==2) {
        return Height_Pt(385);
    }
    return CGFLOAT_MIN;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OrderHeaderView *view=[[OrderHeaderView alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(135))];
    switch (section) {
        case 0:
        {
            TopMessageView *view=[[TopMessageView alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(200))];
            view.title1=@"交易进行中";
            view.title2=@"50 分 16 秒";
            return view;
        }
        case 1:
        {
            view.title=@"支付信息";
            return view;
        }
        case 2:
        {
            view.title=@"订单信息";
            return view;
        }
        default:
            return view;
    }
}
-(void)wantAddMore:(NSString *)currentTitle{
    NSLog(@"添加项目");
    PayInfoController *controller=[[PayInfoController alloc]init];
    controller.isStatus=YES;
    [self.navigationController pushViewController:controller animated:YES];
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
