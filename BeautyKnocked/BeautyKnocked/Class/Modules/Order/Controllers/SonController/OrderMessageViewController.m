//
//  OrderMessageViewController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/25.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "OrderMessageViewController.h"
#import "OrderListModel.h"
#import "ConfirmOrderFillCell.h"
#import "ConfirmOrderAddCell.h"
#import "ConfirmOrderItemCell.h"
#import "TopMessageView.h"
#import "OrderHeaderView.h"
#import "SonItemController.h"

@interface OrderMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableview;
@property (nonatomic,strong) NSArray * titleArray;
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
-(NSArray*)titleArray{
    if (!_titleArray) {
        _titleArray=[[NSArray alloc]initWithObjects:@[@"预约技师：",@"预约时间："],@[@"优惠券：",@"实付金额："],@[@"订单编号：",@"下单时间："], nil];
    }
    return _titleArray;
}
-(UITableView*)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        [_tableview setBackgroundColor:[UIColor clearColor]];
        _tableview.estimatedRowHeight = 100;
        _tableview.contentInset=UIEdgeInsetsMake(0, 0, Height_Pt(350), 0);
        _tableview.separatorInset=UIEdgeInsetsMake(0,10,0,10);
        [self registerCell:_tableview];
    }
    return _tableview;
}
-(void)registerCell:(UITableView*)tableview{
    [tableview registerClass:[ConfirmOrderFillCell class] forCellReuseIdentifier:@"ConfirmOrderFillCell"];
    [tableview registerClass:[ConfirmOrderItemCell class] forCellReuseIdentifier:@"ConfirmOrderItemCell"];
    [tableview registerClass:[ConfirmOrderAddCell class] forCellReuseIdentifier:@"ConfirmOrderAddCell"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        if ([_model.status integerValue]==1||[_model.status integerValue]==2) {
            if (_model.list.count>=4) {
                return 2+_model.list.count;
            }else{
                return 3+_model.list.count;
            }
        }else{
            return 2+_model.list.count;
        }
    }else{
        return 2;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row < 2) {
                ConfirmOrderFillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderFillCell" forIndexPath:indexPath];
                cell.title = self.titleArray[indexPath.section][indexPath.row];
                if (indexPath.row==0) {
                    if (isStringEmpty(_model.beauticianName)) {
                        cell.content=@"随机技师";
                    }else{
                        cell.content=_model.beauticianName;
                    }
                }else{
                    cell.content=[self getWebTime:_model.pactServiceTime];
                }
                return cell;
            }else if(indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1 &&_model.list.count<4&&([_model.status integerValue]==1||[_model.status integerValue]==2)) {
                ConfirmOrderAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderAddCell" forIndexPath:indexPath];
                cell.title = @"添加项目";
                Weakify(self);
                [[cell.addMore takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
                    if (_model.list.count>=4) {
                        [Master showSVProgressHUD:@"您已添加四个项目，考虑时间因素不能再继续添加项目咯~" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                    }else{
                        SonItemController *controller=[[SonItemController alloc]init];
                        controller.isOrder=YES;
                        controller.isSelected=YES;
                        controller.index=0;
                        controller.subModel=[RACSubject subject];
                        [controller.subModel subscribeNext:^(id  _Nullable x) {
                            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确认加单？" message:@"订单内加单将会自动扣除账户相应余额，请确认支付" preferredStyle:UIAlertControllerStyleAlert];
                            [alert addAction:[UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:nil]];
                            [alert addAction:[UIAlertAction actionWithTitle:@"支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                [Master HttpPostRequestByParams:@{@"billId":_model.id,@"clientId":[Acount shareManager].id,@"projectId":x[@"id"]} url:mlqqm serviceCode:jd Success:^(id json) {
                                    if ([json[@"info"] boolValue]) {
                                        [Master showSVProgressHUD:@"加单成功，已扣除用户余额~" withType:ShowSVProgressTypeSuccess withShowBlock:^{
                                        }];
                                    }
                                } Failure:nil andNavigation:Wself.navigationController];
                            }]];
                            [Wself presentViewController:alert animated:YES completion:nil];
                        }];
                        [Wself.navigationController pushViewController:controller animated:YES];
                    }
                }];
                return cell;
            }else{
                ConfirmOrderItemCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderItemCell" forIndexPath:indexPath];
                cell.infoModel=[OrderInfoListModel mj_objectWithKeyValues:_model.list[indexPath.row-2]];
                return cell;
            }
        }
            break;
            case 1:
        {
            ConfirmOrderFillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderFillCell" forIndexPath:indexPath];
            cell.title = self.titleArray[indexPath.section][indexPath.row];
            if (indexPath.row==0) {
                cell.content=@"未使用";
                for (NSDictionary *dict in _model.list) {
                    if ([dict[@"isUse"] integerValue]==1) {
                        cell.content=@"已使用";
                        break;
                    }
                }
            }else{
                NSMutableAttributedString *AttStr=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥ %@",_model.money]];
                [AttStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, AttStr.length)];
                cell.attributed = AttStr;
            }
            return cell;
        }
            break;
        default:
        {
            ConfirmOrderFillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderFillCell" forIndexPath:indexPath];
            cell.title = self.titleArray[indexPath.section][indexPath.row];
            if (indexPath.row==0) {
                cell.content=_model.code;
            }else{
                cell.content=[self getWebTime:_model.createDate];
            }
            return cell;
        }
    }
}

-(NSString*)getWebTime:(NSString*)time{
    NSTimeInterval interval=[[time substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateformatter stringFromDate:date];
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
    return CGFLOAT_MIN;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            TopMessageView *view=[[TopMessageView alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(200))];
            NSString *status=nil;
            switch ([_model.status integerValue]) {
                case 1:
                    status=@"等待服务";
                    break;
                case 2:
                    status=@"交易进行中";
                    break;
                case 3:
                    status=@"等待评价";
                    break;
                default:
                    status=@"交易完成";
                    break;
            }
            view.title1=status;
            view.title2=@"测试倒计时";
            return view;
        }
        case 1:
        {
            OrderHeaderView *view=[[OrderHeaderView alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(135))];
            view.title=@"支付信息";
            return view;
        }
        case 2:
        {
            OrderHeaderView *view=[[OrderHeaderView alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(135))];
            view.title=@"订单信息";
            return view;
        }
        default:
            return nil;
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
