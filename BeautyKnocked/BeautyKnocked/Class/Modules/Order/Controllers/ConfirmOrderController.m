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
#import "OrderSubDay.h"
#import "AddressController.h"
#import "BeauticianController.h"
#import "SonItemController.h"
#import "SonCouponTableController.h"
#import "PaySheetView.h"
#import "PayViewController.h"
#import "OrderModel.h"
#import "PackageOrderModel.h"

static NSString *const addressCell = @"ConfirmOrderAddressCell";
static NSString *const FillCell = @"ConfirmOrderFillCell";
static NSString *const ProductCell = @"ConfirmOrderProductCell";
static NSString *const ItemCell = @"ConfirmOrderItemCell";
static NSString *const AddCell = @"ConfirmOrderAddCell";
static NSString *const RemarksCell = @"ConfirmOrderRemarksCell";

@interface ConfirmOrderController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ConfirmOrderSubmitView *submitOrderView;
@property (nonatomic,strong) NSMutableArray * addArray;
@property (nonatomic,strong) NSArray *titles;

@property (nonatomic,strong) OrderModel * detailOrderModel;
@property (nonatomic,strong) PackageOrderModel * packageOrderModel;

@property (nonatomic,strong) AddressModel * addressModel;

@end

@implementation ConfirmOrderController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.BarAlpha = @"1";
}
-(OrderModel*)detailOrderModel{
    if (!_detailOrderModel) {
        _detailOrderModel=[[OrderModel alloc]init];
    }
    return _detailOrderModel;
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
        _titles = @[@[@""],@[@"选择技师:",@"预约时间:",@"配送方式:"],@[@"选择优惠券:",@"备注:"]];
    }
    return _titles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    [self initializeInterface];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_orderStyle==MLPackage) {
        return 1;
    }else{
        return self.titles.count;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_orderStyle==MLPackage) {
        return self.addArray.count+2;
    }else{
        if (section == 1) {
            return self.addArray.count+3;
        }else{
            return [self.titles[section] count];
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            if (_orderStyle==MLPackage) {
                if (indexPath.row ==0) {
                    /** 选择技师 */
                    ConfirmOrderFillCell *cell = [tableView dequeueReusableCellWithIdentifier:FillCell forIndexPath:indexPath];
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
                    ConfirmOrderAddCell *cell = [tableView dequeueReusableCellWithIdentifier:AddCell forIndexPath:indexPath];
                    cell.title =@"添加套餐";
                    Weakify(self);
                    [[cell.addMore takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
                        SonItemController *controller=[[SonItemController alloc]init];
                        controller.index=7;
                        controller.isSelected=YES;
                        controller.subModel=[RACSubject subject];
                        [controller.subModel subscribeNext:^(id  _Nullable x) {
                            PackageInfoModel *model=[PackageInfoModel mj_objectWithKeyValues:x];
                            _packageOrderModel.packageIds=[NSString stringWithFormat:@"%@,%@",_packageOrderModel.packageIds,model.id];
                            _submitOrderView.totalPrice=[NSString stringWithFormat:@"%.2f",[_submitOrderView.totalPrice floatValue]+[model.price floatValue]];
                            [_addArray addObject:x];
                            [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_addArray.count inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
                            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_addArray.count+1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                        }];
                        [Wself.navigationController pushViewController:controller animated:YES];
                    }];
                    return cell;
                }else{
                    /** 套餐列表 */
                    ConfirmOrderItemCell *cell  = [tableView dequeueReusableCellWithIdentifier:ItemCell forIndexPath:indexPath];
                    cell.Pmodel = [PackageInfoModel mj_objectWithKeyValues:self.addArray[indexPath.row-1]];
                    return cell;
                }
            }else{
                /** 服务地址 */
                ConfirmOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCell forIndexPath:indexPath];
                if (isObjectEmpty(self.addressModel.id)) {
                    cell.isNull=YES;
                }else{
                    cell.model=self.addressModel;
                }
                return cell;
            }
        }
            break;
        case 1:
        {
            if (indexPath.row < 2) {
                ConfirmOrderFillCell *cell = [tableView dequeueReusableCellWithIdentifier:FillCell forIndexPath:indexPath];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                if (indexPath.row==0) {
                    /** 选择技师 */
                    cell.title = self.titles[indexPath.section][indexPath.row];
                    if ([self.detailOrderModel.beauticianId isEqualToString:@"0"]) {
                        cell.content=@"默认随机";
                    }else{
                        cell.content=[NSString stringWithFormat:@"%@号技师",self.detailOrderModel.beauticianId];
                    }
                }else{
                    /** 时间-邮寄 */
                    cell.title = self.orderStyle == MLItem ? self.titles[indexPath.section][indexPath.row]:self.titles[indexPath.section][indexPath.row+1];
                    if (_orderStyle==MLItem) {
                        NSString *time=self.detailOrderModel.pactServiceTime;
                        if (!isStringEmpty(time)) {
                            time=[time substringToIndex:time.length-3];
                        }
                        cell.content=time;
                    }else{
                        cell.content=@"默认邮费到付";
                    }
                }
                return cell;
            }else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
                /** 添加项目 */
                ConfirmOrderAddCell *cell = [tableView dequeueReusableCellWithIdentifier:AddCell forIndexPath:indexPath];
                cell.title = self.orderStyle == MLItem ? @"添加项目":@"添加产品";
                Weakify(self);
                [[cell.addMore takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
                    /** 添加 */
                    if (_orderStyle==MLItem) {
                        if (_addArray.count>=4) {
                            [Master showSVProgressHUD:@"您已超过四个项目，考虑时间因素不可继续添加项目" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                        }else{
                            SonItemController *controller=[[SonItemController alloc]init];
                            controller.index=4;
                            controller.isSelected=YES;
                            controller.subModel=[RACSubject subject];
                            [controller.subModel subscribeNext:^(id  _Nullable x) {
                                DetailModel *model=[DetailModel mj_objectWithKeyValues:x];
                                _detailOrderModel.projectIds=[NSString stringWithFormat:@"%@,%@",_detailOrderModel.projectIds,model.id];
                                _detailOrderModel.serviceTime=[NSString stringWithFormat:@"%ld",[_detailOrderModel.serviceTime integerValue]+[model.serviceTime integerValue]];
                                _submitOrderView.totalPrice=[NSString stringWithFormat:@"%.2f",[_submitOrderView.totalPrice floatValue]+[model.price floatValue]];
                                [_addArray addObject:x];
                                
                                [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_addArray.count+1 inSection:1]] withRowAnimation:UITableViewRowAnimationRight];
                                [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_addArray.count+2 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                            }];
                            [Wself.navigationController pushViewController:controller animated:YES];
                        }
                    }else{
                        
                        
                    }
                }];
                return cell;
            }else{
                if (self.orderStyle == MLItem) {
                    /** 项目列表 */
                    ConfirmOrderItemCell *cell  = [tableView dequeueReusableCellWithIdentifier:ItemCell forIndexPath:indexPath];
                    cell.model = [DetailModel mj_objectWithKeyValues:self.addArray[indexPath.row-2]];
                    return cell;
                }else{
                    ConfirmOrderProductCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductCell forIndexPath:indexPath];
                    cell.itemName = _addArray[indexPath.row-2];
                    cell.itemImage = [UIImage imageNamed:@"touxiang_03"];
                    cell.price = @"¥ 500";
                    return cell;
                }
            }
        }
            break;
        default:
        {
            if (indexPath.row == 0) {/** 优惠券 */
                ConfirmOrderFillCell *cell = [tableView dequeueReusableCellWithIdentifier:FillCell forIndexPath:indexPath];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.title = self.titles[indexPath.section][indexPath.row];
                if (![self.detailOrderModel.clientCouponId isEqualToString:@"0"]) {
                    cell.content=@"已选择";
                }
                return cell;
            }else{/** 备注 */
                ConfirmOrderRemarksCell *cell = [tableView dequeueReusableCellWithIdentifier:RemarksCell forIndexPath:indexPath];
                if (!isStringEmpty(_detailOrderModel.remark)) {
                    cell.text=_detailOrderModel.remark;
                }
                cell.subText=[RACSubject subject];
                [[cell.subText takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
                    _detailOrderModel.remark=x;
                }];
                return cell;
            }
        }
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return Height_Pt(20);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            if (_orderStyle==MLPackage) {
                if (indexPath.row==0) {
                    BeauticianController *controller=[[BeauticianController alloc]init];
                    controller.isType=1;
                    controller.beauticianId=[RACSubject subject];
                    [controller.beauticianId subscribeNext:^(id  _Nullable x) {
                        _packageOrderModel.beauticianId=x;
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
                    }];
                    [self.navigationController pushViewController:controller animated:YES];
                }
            }else{
                AddressController *controller = [[AddressController alloc] init];
                controller.isSelected=YES;
                controller.addressId=[RACSubject subject];
                [controller.addressId subscribeNext:^(id  _Nullable x) {
                    self.addressModel=(AddressModel*)x;
                    self.detailOrderModel.addressId=self.addressModel.id;
                    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
                }];
                [self.navigationController pushViewController:controller animated:YES];
            }
        }
            break;
            case 1:
            switch (indexPath.row) {
                    case 0:
                {
                    /** 选择技师 */
                    BeauticianController *controller=[[BeauticianController alloc]init];
                    controller.isType=1;
                    controller.beauticianId=[RACSubject subject];
                    [controller.beauticianId subscribeNext:^(id  _Nullable x) {
                        _detailOrderModel.beauticianId=x;
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
                    }];
                    if (!isStringEmpty(self.detailOrderModel.pactServiceTime)) {
                        /** 时间筛选技师 */
                        controller.serviceTime=self.detailOrderModel.serviceTime;
                        controller.pactServiceTime=self.detailOrderModel.pactServiceTime;
                    }
                    [self.navigationController pushViewController:controller animated:YES];
                }
                    break;
                case 1:
                {
                    if (self.orderStyle==MLItem) {
                        /** 项目-预约时间 */
                        [Master HttpPostRequestByParams:@{@"beauticianId":self.detailOrderModel.beauticianId,@"timeLength":self.detailOrderModel.serviceTime} url:mlqqm serviceCode:mrsskb Success:^(id json) {
                            WebTimeModel *model=[WebTimeModel mj_objectWithKeyValues:json[@"info"]];
                            /** 初始化 */
                            OrderSubDay *view=[OrderSubDay shareManager];
                            /** 开始时间 */
                            view.startDay=[[DayModel alloc]initGetHttpData:model.startTime];
                            /** 时间段 */
                            view.model=model;
                            /** 选中时间 */
                            view.subData=[RACSubject subject];
                            [view.subData subscribeNext:^(id  _Nullable x) {
                                _detailOrderModel.pactServiceTime=x;
                                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
                            }];
                            [LEEAlert alert].config
                            .LeeCustomView(view)
                            .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
                            .LeeHeaderColor([UIColor clearColor])
                            .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type) {
                                return Width_Pt(1018);
                            })
                            .LeeShow();
                        } Failure:nil andNavigation:self.navigationController];
                    }else{
                        /** 产品-配送方式 */
                        NSLog(@"产品");
                    }
                }
                    break;
                default:
                    break;
            }
            break;
        default:
            if (indexPath.row==0) {
                Weakify(self);
                [Master HttpPostRequestByParams:@{@"clientId":_detailOrderModel.clientId,@"commIds":self.detailOrderModel.projectIds,@"commType":@"1"} url:mlqqm serviceCode:yhqsx Success:^(id json) {
                    SonCouponTableController *controller=[[SonCouponTableController alloc]init];
                    controller.isOrder=YES;
                    controller.subCouponId=[RACSubject subject];
                    [controller.subCouponId subscribeNext:^(id  _Nullable x) {
                        _detailOrderModel.clientCouponId=x;
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
                    }];
                    controller.listArray=[[NSMutableArray alloc]initWithArray:json[@"info"]];
                    [Wself.navigationController pushViewController:controller animated:YES];
                } Failure:nil andNavigation:self.navigationController];
            }
            break;
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
    [self.view addSubview:self.tableView];
    
    _submitOrderView = [[ConfirmOrderSubmitView alloc] init];
    _submitOrderView.backgroundColor = [UIColor whiteColor];
    switch (_orderStyle) {
        case MLItem:
            _submitOrderView.totalPrice=self.detailModel.price;
            break;
        case MLPackage:
            _submitOrderView.totalPrice=self.packageInfoModel.price;
            break;
        default:
            break;
    }
    Weakify(self);
    [_submitOrderView.payInfo subscribeNext:^(id  _Nullable x) {
        /** 支付订单 */
        PaySheetView *paysheet=[[PaySheetView alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(205+180*4))];
        paysheet.subType=[RACSubject subject];
        switch (_orderStyle) {
            case MLPackage:
            {
                NSLog(@"%@",_packageOrderModel.mj_keyValues);
                [paysheet.subType subscribeNext:^(id  _Nullable x) {
                    _packageOrderModel.payType=x;
                    [Wself payOrder:_packageOrderModel.mj_keyValues WithCode:tjtcdd];
                }];
            }
                break;
            case MLItem:
            {
                NSLog(@"%@",_detailOrderModel.mj_keyValues);
                if (isStringEmpty(_detailOrderModel.addressId)) {
                    [Master showSVProgressHUD:@"请选择服务地址" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }else if (isStringEmpty(_detailOrderModel.pactServiceTime)){
                    [Master showSVProgressHUD:@"请选择预约时间" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }else{
                    [paysheet.subType subscribeNext:^(id  _Nullable x) {
                        _detailOrderModel.payType=x;
                        [Wself payOrder:_detailOrderModel.mj_keyValues WithCode:tjxmdd];
                    }];
                }
            }
                break;
            default:
            {
                
            }
                break;
        }
        [LEEAlert actionsheet].config
        .LeeCustomView(paysheet)
        .LeeActionSheetBottomMargin(-5)
        .LeeCornerRadius(0.0f)
        .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        .LeeHeaderColor([UIColor clearColor])
        .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type) {
            return Width;
        })
        .LeeShow();
    }];
    [self.view addSubview:self.submitOrderView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, Height_Pt(145), 0));
    }];
    
    [self.submitOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom);
        make.left.and.bottom.and.right.equalTo(self.view);
    }];
    [self getDefaultAddressModel];
}
-(void)payOrder:(NSDictionary*)keyValues WithCode:(NSString*)code{
    [Master HttpPostRequestByParams:keyValues url:mlqqm serviceCode:code Success:^(id json) {
        PayViewController *controller=[[PayViewController alloc]init];
        controller.isPayType=keyValues[@"payType"];
        controller.model=[OrderInfoModel mj_objectWithKeyValues:json[@"info"]];
        [self.navigationController pushViewController:controller animated:YES];
    } Failure:nil andNavigation:self.navigationController];
}
/** 默认数据 */
-(void)getDefaultAddressModel{
    NSString *ip=[Master getIPv4];
    NSString *clientId=[Acount shareManager].id;
    switch (self.orderStyle) {
            /** 初始默认设置 */
        case MLPackage:
            self.packageOrderModel.ip=ip;
            _packageOrderModel.clientId=clientId;
            _packageOrderModel.beauticianId=@"0";
            _packageOrderModel.packageIds=self.packageInfoModel.id;
            [self.addArray addObject:_packageInfoModel.mj_keyValues];
            break;
        case MLItem:
            self.detailOrderModel.ip=ip;
            _detailOrderModel.clientId=clientId;
            _detailOrderModel.beauticianId=@"0";
            _detailOrderModel.projectIds=self.detailModel.id;
            _detailOrderModel.clientCouponId=@"0";
            _detailOrderModel.serviceTime=_detailModel.serviceTime;
            [self.addArray addObject:_detailModel.mj_keyValues];
            break;
        default:
            
            break;
    }
    if (_orderStyle!=MLPackage) {
        [Master HttpPostRequestByParams:@{@"clientId":clientId} url:mlqqm serviceCode:fwdzlb Success:^(id json) {
            NSMutableArray *array=[[NSMutableArray alloc]initWithArray:json[@"info"]];
            for (int i=0; i<array.count; i++) {
                if ([array[i][@"isDefault"] integerValue]==1) {
                    self.addressModel=[AddressModel mj_objectWithKeyValues:array[i]];
                    if (_orderStyle==MLItem) {
                        self.detailOrderModel.addressId=self.addressModel.id;
                    }else{
                        
                    }
                    [_tableView reloadData];
                    break;
                }
            }
        } Failure:nil andNavigation:self.navigationController];
    }
    [_tableView reloadData];
}
@end
