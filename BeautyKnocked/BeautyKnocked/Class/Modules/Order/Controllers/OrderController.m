//
//  OrderController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "OrderController.h"
#import "ConfirmOrderSubmitView.h"

#import "AddressController.h"
#import "BeauticianController.h"
#import "PayViewController.h"
#import "SonItemController.h"

#import "ConfirmOrderFillCell.h"
#import "ConfirmOrderAddCell.h"
#import "ConfirmOrderItemCell.h"
#import "PayTypeCell.h"

#import "PackageOrderModel.h"

@interface OrderController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableview;
@property (nonatomic,strong) ConfirmOrderSubmitView *submitOrderView;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) AddressModel * addressModel;
@property (nonatomic,strong) NSMutableArray * addArray;
@property (nonatomic,strong) PackageOrderModel * packageOrderModel;
@end

@implementation OrderController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.BarAlpha = @"1";
}
-(PackageOrderModel*)packageOrderModel{
    if (!_packageOrderModel) {
        _packageOrderModel=[[PackageOrderModel alloc]init];
    }
    return _packageOrderModel;
}
-(AddressModel*)addressModel{
    if (!_addressModel) {
        _addressModel=[[AddressModel alloc]init];
    }
    return _addressModel;
}
-(NSMutableArray*)addArray{
    if (!_addArray) {
        _addArray=[[NSMutableArray alloc]init];
    }
    return _addArray;
}
-(NSArray *)titles {
    if (!_titles) {
        _titles = [[NSArray alloc]initWithObjects:
                   @{@"name":@"支付方式",@"image":@"yu-e"},
                   @{@"name":@"余额支付",@"image":@"yu-e"},
                   @{@"name":@"微信支付",@"image":@"weixin"},
                   @{@"name":@"支付宝支付",@"image":@"zhifubao"},nil];
    }
    return _titles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    self.view.backgroundColor=[UIColor colorWithHexString:@"#f5f5f5"];
    [self initializeInterface];
}
-(void)initializeInterface {
    _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.estimatedRowHeight = 100;
    _tableview.scrollsToTop=NO;
    _tableview.backgroundColor=[UIColor clearColor];
    [_tableview registerClass:[ConfirmOrderFillCell class] forCellReuseIdentifier:@"ConfirmOrderFillCell"];
    [_tableview registerClass:[ConfirmOrderAddCell class] forCellReuseIdentifier:@"ConfirmOrderAddCell"];
    [_tableview registerClass:[ConfirmOrderItemCell class] forCellReuseIdentifier:@"ConfirmOrderItemCell"];
    [_tableview registerClass:[PayTypeCell class] forCellReuseIdentifier:@"PayTypeCell"];
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:_tableview];
    
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, Height_Pt(145), 0));
    }];
    
    _submitOrderView = [[ConfirmOrderSubmitView alloc] init];
    _submitOrderView.backgroundColor = [UIColor whiteColor];
    _submitOrderView.totalPrice=self.packageInfoModel.price;
    /** 提交订单 */
    Weakify(self);
    [_submitOrderView.payInfo subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",_packageOrderModel.mj_keyValues);
        if (isStringEmpty(_packageOrderModel.payType)) {
            [Master showSVProgressHUD:@"请选择支付方式" withType:ShowSVProgressTypeInfo withShowBlock:nil];
        }else{
            [Master HttpPostRequestByParams:_packageOrderModel.mj_keyValues url:mlqqm serviceCode:tjtcdd Success:^(id json) {
                PayViewController *controller=[[PayViewController alloc]init];
                controller.isPayType=_packageOrderModel.payType;
                controller.model=[OrderInfoModel mj_objectWithKeyValues:json[@"info"]];
                [Wself.navigationController pushViewController:controller animated:YES];
            } Failure:nil andNavigation:Wself.navigationController];
        }
    }];
    [self.view addSubview:_submitOrderView];
    [_submitOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableview.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];

    self.packageOrderModel.ip=[Master getIPv4];
    _packageOrderModel.clientId=[Acount shareManager].id;
    _packageOrderModel.beauticianId=@"0";
    _packageOrderModel.packageIds=_packageInfoModel.id;
    [self.addArray addObject:_packageInfoModel.mj_keyValues];
    [_tableview reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return self.addArray.count+2;
    }else{
        return 4;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row ==0) {
            /** 选择技师 */
            ConfirmOrderFillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderFillCell" forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.title = @"选择技师:";
            if ([self.packageOrderModel.beauticianId isEqualToString:@"0"]) {
                cell.content=@"默认随机";
            }else{
                cell.content=[NSString stringWithFormat:@"%@号技师",_packageOrderModel.beauticianId];
            }
            return cell;
        }else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
            /** 添加套餐 */
            ConfirmOrderAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderAddCell" forIndexPath:indexPath];
            cell.title =@"添加套餐";
            Weakify(self);
            [[cell.addMore takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
                if (_addArray.count>=4) {
                    [Master showSVProgressHUD:@"您已添加四个套餐，不能再继续添加套餐咯~" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }else{
                    SonItemController *controller=[[SonItemController alloc]init];
                    controller.index=7;
                    controller.isSelected=YES;
                    controller.subModel=[RACSubject subject];
                    [controller.subModel subscribeNext:^(id  _Nullable x) {
                        PackageInfoModel *model=[PackageInfoModel mj_objectWithKeyValues:x];
                        _packageOrderModel.packageIds=[NSString stringWithFormat:@"%@,%@",_packageOrderModel.packageIds,model.id];
                        _submitOrderView.totalPrice=[NSString stringWithFormat:@"%f",[_submitOrderView.totalPrice floatValue]+[model.price floatValue]];
                        [_addArray addObject:x];
                        [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_addArray.count inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
                        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_addArray.count+1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                    }];
                    [Wself.navigationController pushViewController:controller animated:YES];
                }
            }];
            return cell;
        }else{
            /** 套餐列表 */
            ConfirmOrderItemCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderItemCell" forIndexPath:indexPath];
            cell.Pmodel = [PackageInfoModel mj_objectWithKeyValues:self.addArray[indexPath.row-1]];
            return cell;
        }
    }else{
        /** 支付方式 */
        if (indexPath.row==0) {
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.textLabel.font=[UIFont systemFontOfSize:Font_Size(40)];
            cell.textLabel.text=@"支付方式";
            return cell;
        }else{
            PayTypeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PayTypeCell" forIndexPath:indexPath];
            cell.isNode=indexPath.row==1 ? YES:NO;
            cell.model=self.titles[indexPath.row];
            if (indexPath.row>1) {
                cell.isSelected=[_packageOrderModel.payType integerValue]+1==indexPath.row ? YES:NO;
            }
            return cell;
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            /** 选择技师 */
            BeauticianController *controller=[[BeauticianController alloc]init];
            controller.isType=YES;
            controller.beauticianId=[RACSubject subject];
            [controller.beauticianId subscribeNext:^(id  _Nullable x) {
                _packageOrderModel.beauticianId=x;
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            }];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }else{
        /** 支付方式 */
        if (indexPath.row>1) {
            _packageOrderModel.payType=[NSString stringWithFormat:@"%ld",indexPath.row-1];
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return Height_Pt(20);
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
