//
//  ConfirmOrderController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/15.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ConfirmOrderController.h"
#import "ConfirmOrderAddressCell.h"
#import "ConfirmOrderFillCell.h"
#import "ConfirmOrderAddCell.h"
#import "ConfirmOrderProductCell.h"
#import "ConfirmOrderItemCell.h"
#import "ConfirmOrderRemarksCell.h"
#import "ConfirmOrderSubmitView.h"
#import "OrderModel.h"
#import "AddressModel.h"
#import "OrderSubDay.h"
#import "OrderModel.h"
#import "AddressController.h"
#import "BeauticianController.h"
#import "ProductModel.h"
#import "DetailModel.h"
#import "PackageInfoModel.h"

static NSString *const addressCell = @"ConfirmOrderAddressCell";
static NSString *const FillCell = @"ConfirmOrderFillCell";
static NSString *const ProductCell = @"ConfirmOrderProductCell";
static NSString *const ItemCell = @"ConfirmOrderItemCell";
static NSString *const AddCell = @"ConfirmOrderAddCell";
static NSString *const RemarksCell = @"ConfirmOrderRemarksCell";

@interface ConfirmOrderController ()<UITableViewDataSource,UITableViewDelegate,ConfirmOrderAddCellDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ConfirmOrderSubmitView *submitOrderView;
@property (nonatomic,strong) NSMutableArray * addArray;
@property (nonatomic,strong) NSArray *titles;

@property (nonatomic,strong) OrderModel * detailOrderModel;

@property (nonatomic,strong) AddressModel * addressModel;

@end

@implementation ConfirmOrderController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"1";
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
-(OrderModel*)detailOrderModel{
    if (!_detailOrderModel) {
        _detailOrderModel=[[OrderModel alloc]init];
    }
    return _detailOrderModel;
}
-(AddressModel*)addressModel{
    //默认地址
    if (!_addressModel) {
        _addressModel=[[AddressModel alloc]init];
    }
    return _addressModel;
}
-(NSMutableArray*)addArray{
    if (!_addArray) {
        _addArray=[[NSMutableArray alloc]initWithObjects:@"水美人", nil];
    }
    return _addArray;
}
-(NSArray *)titles {
    if (!_titles) {
        _titles = @[@[@""],@[@"选择技师:",@"预约时间:",@"配送方式:"],@[@"选择优惠券:",@"备注:"]];
    }
    return _titles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"确认订单";
    [self initializeInterface];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.addArray.count+3;
    }
    return [self.titles[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //地址
        ConfirmOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCell forIndexPath:indexPath];
        if (isObjectEmpty(self.addressModel.id)) {
            cell.isNull=YES;
        }else{
            cell.model=self.addressModel;
        }
        return cell;
    }else if (indexPath.section == 1) {
        if (indexPath.row < 2) {
            ConfirmOrderFillCell *cell = [tableView dequeueReusableCellWithIdentifier:FillCell forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row==0) {
                cell.title = self.titles[indexPath.section][indexPath.row];
                if (isStringEmpty(self.detailOrderModel.beauticianId)||[self.detailOrderModel.beauticianId integerValue]==0) {
                    cell.content=@"默认随机";
                    self.detailOrderModel.beauticianId=@"0";
                }else{
                    cell.content=[NSString stringWithFormat:@"%@号技师",self.detailOrderModel.beauticianId];
                }
            }else{
                cell.title = self.orderStyle == MLItem ? self.titles[indexPath.section][indexPath.row]:self.titles[indexPath.section][indexPath.row+1];
                cell.content= self.orderStyle == MLItem ? @"":@"默认邮费到付";
            }
            return cell;
        }else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
            ConfirmOrderAddCell *cell = [tableView dequeueReusableCellWithIdentifier:AddCell forIndexPath:indexPath];
            cell.delegate = self;
            cell.title = self.orderStyle == MLItem ? @"添加项目":@"添加产品";
            return cell;
        }
        if (self.orderStyle == MLProduct) {
            ConfirmOrderProductCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductCell forIndexPath:indexPath];
            cell.itemName = _addArray[indexPath.row-2];
            cell.itemImage = [UIImage imageNamed:@"touxiang_03"];
            cell.price = @"¥ 500";
            return cell;
        }
        if (self.orderStyle == MLItem) {
            ConfirmOrderItemCell *cell  = [tableView dequeueReusableCellWithIdentifier:ItemCell forIndexPath:indexPath];
            cell.itemName = _addArray[indexPath.row-2];
            cell.itemImage = [UIImage imageNamed:@"touxiang_03"];
            cell.price =88;
            cell.blcakprice=128;
            cell.serviceLength = [NSString stringWithFormat:@"服务时90长分钟"];
            return cell;
        }
    }else if(indexPath.section == 2) {
        if (indexPath.row == 0) {
            ConfirmOrderFillCell *cell = [tableView dequeueReusableCellWithIdentifier:FillCell forIndexPath:indexPath];
            cell.title = self.titles[indexPath.section][indexPath.row];
            cell.content=@"暂无优惠券";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        ConfirmOrderRemarksCell *cell = [tableView dequeueReusableCellWithIdentifier:RemarksCell forIndexPath:indexPath];
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return Height_Pt(20);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        AddressController *controller = [[AddressController alloc] init];
        controller.isSelected=YES;
        controller.addressId=[RACSubject subject];
        [controller.addressId subscribeNext:^(id  _Nullable x) {
            self.addressModel=(AddressModel*)x;
            self.detailOrderModel.addressId=self.addressModel.id;
            [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:controller animated:YES];
    }else if(indexPath.section==1){
        switch (indexPath.row) {
            case 0://选择技师
            {
                BeauticianController *controller=[[BeauticianController alloc]init];
                controller.isSelected=YES;
                controller.beauticianId=[RACSubject subject];
                [controller.beauticianId subscribeNext:^(id  _Nullable x) {
                    self.detailOrderModel.beauticianId=x;
                    [self.tableView reloadData];
                }];
                if (!isStringEmpty(self.detailOrderModel.pactServiceTime)) {
                    //时间筛选技师
                    //self.detailOrderModel.pactServiceTime
                }
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
            case 1:
            {
                if (self.orderStyle==MLItem) {
                    //项目-预约时间
                    [Master HttpPostRequestByParams:@{@"beauticianId":self.detailOrderModel.beauticianId,@"timeLength":self.detailOrderModel.serviceTime} url:mlqqm serviceCode:mrsskb Success:^(id json) {
                        OrderSubDay *view=[[OrderSubDay alloc]initWithFrame:CGRectMake(0, 0,Width_Pt(1018), Height_Pt(1186) + 20)];
                        [view makeCornerRadius:5];
                        [LEEAlert alert].config
                        .LeeCustomView(view)
                        .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
                        .LeeHeaderColor([UIColor clearColor])
                        .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type) {
                            return Width_Pt(1018);
                        })
                        .LeeShow();
                    } Failure:nil];
                }else{
                    //产品-配送方式
                    NSLog(@"产品");
                }
            }
                break;
            default:
                break;
        }
    }else{
        if (indexPath.row==0) {
            NSLog(@"优惠券");
        }
    }
}
-(void)initializeInterface {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 100;
    [_tableView registerClass:[ConfirmOrderAddressCell class] forCellReuseIdentifier:addressCell];
    [_tableView registerClass:[ConfirmOrderFillCell class] forCellReuseIdentifier:FillCell];
    [_tableView registerClass:[ConfirmOrderProductCell class] forCellReuseIdentifier:ProductCell];
    [_tableView registerClass:[ConfirmOrderItemCell class] forCellReuseIdentifier:ItemCell];
    [_tableView registerClass:[ConfirmOrderAddCell class] forCellReuseIdentifier:AddCell];
    [_tableView registerClass:[ConfirmOrderRemarksCell class] forCellReuseIdentifier:RemarksCell];
    
    _submitOrderView = [[ConfirmOrderSubmitView alloc] init];
    _submitOrderView.backgroundColor = [UIColor whiteColor];
    _submitOrderView.totalPrice = self.detailModel.vipPrice;
    [_submitOrderView.payInfo subscribeNext:^(id  _Nullable x) {
       NSLog(@"%@",self.detailOrderModel.mj_keyValues);
    }];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:_submitOrderView];
    [self getDefaultAddressModel];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, Height_Pt(147), 0));
    }];
    
    [self.submitOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.top.equalTo(self.tableView.mas_bottom);
    }];
}
-(void)getDefaultAddressModel{
    switch (self.orderStyle) {
        case MLProduct:
            
            break;
        case MLItem:
            self.detailOrderModel.projectIds=self.detailModel.id;
            self.detailOrderModel.serviceTime=self.detailModel.serviceTime;
            break;
        default:
            break;
    }
    //获取默认地址
    [Master HttpPostRequestByParams:@{@"device":UUID,@"clientId":[Acount shareManager].id} url:mlqqm serviceCode:fwdzlb Success:^(id json) {
        NSMutableArray *array=[[NSMutableArray alloc]initWithArray:json[@"info"]];
        for (int i=0; i<array.count; i++) {
            if ([array[i][@"isDefault"] integerValue]==1) {
                self.addressModel=[AddressModel mj_objectWithKeyValues:array[i]];
                self.detailOrderModel.addressId=self.addressModel.id;
                [self.tableView reloadData];
                break;
            }
        }
        [_tableView reloadData];
    } Failure:nil];
}
-(void)wantAddMore:(NSString *)currentTitle {
    if (_addArray.count>=4) {
        [Master showSVProgressHUD:@"您已超过四个项目，考虑时间因素不可继续添加项目" withType:ShowSVProgressTypeInfo withShowBlock:nil];
    }else{
        [_addArray addObject:currentTitle];
        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_addArray.count+1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_addArray.count+2 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}
@end
