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
#import "PayViewController.h"
#import "OrderModel.h"
#import "PackageOrderModel.h"
#import "ProductOrderModel.h"
#import "ExpressView.h"
#import "PayTypeCell.h"

static NSString *const addressCell = @"ConfirmOrderAddressCell";
static NSString *const FillCell = @"ConfirmOrderFillCell";
static NSString *const ProductCell = @"ConfirmOrderProductCell";
static NSString *const ItemCell = @"ConfirmOrderItemCell";
static NSString *const AddCell = @"ConfirmOrderAddCell";
static NSString *const RemarksCell = @"ConfirmOrderRemarksCell";

@interface ConfirmOrderController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ConfirmOrderSubmitView *submitOrderView;
@property (nonatomic,strong) NSArray *titles;

@property (nonatomic,strong) AddressModel * addressModel;
@property (nonatomic,strong) NSMutableArray * addArray;

@property (nonatomic,strong) OrderModel * detailOrderModel;
@property (nonatomic,strong) ProductOrderModel * productOrderModel;
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
-(ProductOrderModel*)productOrderModel{
    if (!_productOrderModel) {
        _productOrderModel=[[ProductOrderModel alloc]init];
    }
    return _productOrderModel;
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
        _titles = [[NSArray alloc]initWithObjects:@[@""],@[@"选择技师:",@"预约时间:",@"配送方式:"],
  @[@{@"name":@"支付方式",@"image":@"yu-e"},
  @{@"name":@"余额支付",@"image":@"yu-e"},
  @{@"name":@"微信支付",@"image":@"weixin"},
  @{@"name":@"支付宝支付",@"image":@"zhifubao"}],
  @[@"选择优惠券:",@"备注:"],
                   nil];
    }
    return _titles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    [self initializeInterface];
}
-(void)initializeInterface {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 100;
    _tableView.scrollsToTop=NO;
    [_tableView registerClass:[ConfirmOrderAddressCell class] forCellReuseIdentifier:addressCell];
    [_tableView registerClass:[ConfirmOrderFillCell class] forCellReuseIdentifier:FillCell];
    [_tableView registerClass:[ConfirmOrderProductCell class] forCellReuseIdentifier:ProductCell];
    [_tableView registerClass:[ConfirmOrderItemCell class] forCellReuseIdentifier:ItemCell];
    [_tableView registerClass:[ConfirmOrderAddCell class] forCellReuseIdentifier:AddCell];
    [_tableView registerClass:[ConfirmOrderRemarksCell class] forCellReuseIdentifier:RemarksCell];
    [_tableView registerClass:[PayTypeCell class] forCellReuseIdentifier:@"PayTypeCell"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:_tableView];
    
    _submitOrderView = [[ConfirmOrderSubmitView alloc] init];
    _submitOrderView.backgroundColor = [UIColor whiteColor];
    /** 提交订单 */
    Weakify(self);
    [_submitOrderView.payInfo subscribeNext:^(id  _Nullable x) {
        switch (_orderStyle) {
            case MLItem:
            {
                NSLog(@"%@",_detailOrderModel.mj_keyValues);
                if (isStringEmpty(_detailOrderModel.addressId)) {
                    [Master showSVProgressHUD:@"请选择服务地址" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }else if (isStringEmpty(_detailOrderModel.pactServiceTime)){
                    [Master showSVProgressHUD:@"请选择预约时间" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }else if (isStringEmpty(_detailOrderModel.payType)) {
                    [Master showSVProgressHUD:@"请选择支付方式" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }else{
                    [Wself payOrder:_detailOrderModel.mj_keyValues WithCode:tjxmdd];
                }
            }
                break;
            default:
            {
                NSLog(@"%@",_productOrderModel.mj_keyValues);
                if (isStringEmpty(_productOrderModel.addressId)) {
                    [Master showSVProgressHUD:@"请选择服务地址" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }else if (isStringEmpty(_productOrderModel.payType)) {
                    [Master showSVProgressHUD:@"请选择支付方式" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                }else{
                    [Wself payOrder:_productOrderModel.mj_keyValues WithCode:tjcpdd];
                }
            }
                break;
        }
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

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.addArray.count+3;
    }else{
        NSArray *arrayCounts=[[NSArray alloc]initWithArray:self.titles[section]];
        return arrayCounts.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            /** 服务地址 */
            ConfirmOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCell forIndexPath:indexPath];
            if (isObjectEmpty(self.addressModel.id)) {
                cell.isNull=YES;
            }else{
                cell.model=self.addressModel;
            }
            return cell;
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
                    if (_orderStyle==MLItem) {
                        cell.content=[self.detailOrderModel.beauticianId integerValue]==0 ? @"默认随机" : [NSString stringWithFormat:@"%@号技师",_detailOrderModel.beauticianId];
                    }else{
                        cell.content=[self.productOrderModel.beauticianId integerValue]==0 ? @"默认随机" : [NSString stringWithFormat:@"%@号技师",_productOrderModel.beauticianId];
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
                        cell.content=[_productOrderModel.expressMode integerValue]==0 ? @"默认邮费到付" : @"美容师携带";
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
                    if (_addArray.count>=4) {
                        if (_orderStyle==MLItem) {
                            [Master showSVProgressHUD:@"您已添加四个项目，考虑时间因素不能再继续添加项目咯~" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                        }else{
                            [Master showSVProgressHUD:@"您已添加四个产品，不能再继续添加产品咯~" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                        }
                    }else{
                        SonItemController *controller=[[SonItemController alloc]init];
                        controller.isSelected=YES;
                        controller.subModel=[RACSubject subject];
                        if (_orderStyle==MLItem) {
                            controller.index=0;
                            [controller.subModel subscribeNext:^(id  _Nullable x) {
                                DetailModel *model=[DetailModel mj_objectWithKeyValues:x];
                                _detailOrderModel.projectIds=[NSString stringWithFormat:@"%@,%@",_detailOrderModel.projectIds,model.id];
                                _detailOrderModel.serviceTime=[NSString stringWithFormat:@"%ld",[_detailOrderModel.serviceTime integerValue]+[model.serviceTime integerValue]];
                                _submitOrderView.totalPrice=[NSString stringWithFormat:@"%f",[_submitOrderView.totalPrice floatValue]+[model.price floatValue]];
                                [Wself reloadWithAddArray:x];
                            }];
                        }else{
                            controller.index=6;
                            [controller.subModel subscribeNext:^(id  _Nullable x) {
                                ProductModel *model=[ProductModel mj_objectWithKeyValues:x];
                                _productOrderModel.productIds=[NSString stringWithFormat:@"%@,%@",_productOrderModel.productIds,model.id];
                                _submitOrderView.totalPrice=[NSString stringWithFormat:@"%f",[_submitOrderView.totalPrice floatValue]+[model.price floatValue]];
                                [Wself reloadWithAddArray:x];
                            }];
                        }
                        [Wself.navigationController pushViewController:controller animated:YES];
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
                    /** 产品列表 */
                    ConfirmOrderProductCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductCell forIndexPath:indexPath];
                    cell.model=[ProductModel mj_objectWithKeyValues:_addArray[indexPath.row-2]];
                    cell.subCount=[RACSubject subject];
                    [[cell.subCount takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
                        _productOrderModel.productIds=nil;
                        _submitOrderView.totalPrice=nil;
                        cell.model.count=x;
                        [_addArray replaceObjectAtIndex:indexPath.row-2 withObject:cell.model.mj_keyValues];
                        
                        for (NSDictionary *dict in _addArray) {
                            ProductModel *model=[ProductModel mj_objectWithKeyValues:dict];
                            _submitOrderView.totalPrice=[NSString stringWithFormat:@"%f",([model.count integerValue]*[model.price floatValue])+[_submitOrderView.totalPrice floatValue]];
                            for (int i=0; i<[model.count integerValue]; i++) {
                                if (!isStringEmpty(_productOrderModel.productIds)) {
                                    _productOrderModel.productIds=[NSString stringWithFormat:@"%@,%@",_productOrderModel.productIds,model.id];
                                }else{
                                    _productOrderModel.productIds=model.id;
                                }
                            }
                        }
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }];
                    return cell;
                }
            }
        }
            break;
            case 2:
        {
            /** 支付方式 */
            if (indexPath.row==0) {
                UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.textLabel.font=[UIFont systemFontOfSize:Font_Size(40)];
                cell.textLabel.text=@"支付方式";
                return cell;
            }else{
                PayTypeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PayTypeCell" forIndexPath:indexPath];
                cell.model=self.titles[indexPath.section][indexPath.row];
                if (_orderStyle==MLItem) {
                    cell.isSelected=[_detailOrderModel.payType integerValue]+1==indexPath.row ? YES:NO;
                }else{
                    cell.isNode=indexPath.row==1 ? YES:NO;
                    if (indexPath.row>1) {
                        cell.isSelected=[_productOrderModel.payType integerValue]+1==indexPath.row ? YES:NO;
                    }
                }
                return cell;
            }
        }
            break;
        default:
        {
            if (indexPath.row == 0) {
                /** 优惠券 */
                ConfirmOrderFillCell *cell = [tableView dequeueReusableCellWithIdentifier:FillCell forIndexPath:indexPath];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.title = self.titles[indexPath.section][indexPath.row];
                if (_orderStyle==MLItem) {
                    cell.content=[self.detailOrderModel.clientCouponId isEqualToString:@"0"] ? @"":@"已选择";
                }else{
                    cell.content=[self.productOrderModel.clientCouponId isEqualToString:@"0"] ? @"":@"已选择";
                }
                return cell;
            }else{
                /** 备注 */
                ConfirmOrderRemarksCell *cell = [tableView dequeueReusableCellWithIdentifier:RemarksCell forIndexPath:indexPath];
                NSString *remark=nil;
                if (_orderStyle==MLItem) {
                    remark=self.detailOrderModel.remark;
                }else{
                    remark=self.productOrderModel.remark;
                }
                cell.text=remark;
                if (!isStringEmpty(remark)) {
                    
                }
                cell.subText=[RACSubject subject];
                [[cell.subText takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
                    if (_orderStyle==MLItem) {
                        _detailOrderModel.remark=x;
                    }else{
                        _productOrderModel.remark=x;
                    }
                }];
                return cell;
            }
        }
            break;
    }
}
-(void)reloadWithAddArray:(NSDictionary*)dict{
    [_addArray addObject:dict];
    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_addArray.count+1 inSection:1]] withRowAnimation:UITableViewRowAnimationRight];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_addArray.count+2 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            AddressController *controller = [[AddressController alloc] init];
            controller.isSelected=YES;
            controller.addressId=[RACSubject subject];
            [controller.addressId subscribeNext:^(id  _Nullable x) {
                _addressModel=[AddressModel mj_objectWithKeyValues:x];
                if (_orderStyle==MLItem) {
                    _detailOrderModel.addressId=_addressModel.id;
                }else{
                    _productOrderModel.addressId=_addressModel.id;
                }
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            }];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    /** 选择技师 */
                    BeauticianController *controller=[[BeauticianController alloc]init];
                    controller.isType=1;
                    controller.beauticianId=[RACSubject subject];
                    [controller.beauticianId subscribeNext:^(id  _Nullable x) {
                        if (_orderStyle==MLItem) {
                            _detailOrderModel.beauticianId=x;
                        }else{
                            _productOrderModel.beauticianId=x;
                        }
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
                    }];
                    if (!isStringEmpty(self.detailOrderModel.pactServiceTime)) {
                        /** 时间筛选技师 */
                        controller.serviceTime=_detailOrderModel.serviceTime;
                        controller.pactServiceTime=_detailOrderModel.pactServiceTime;
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
                            [Master PopAlertView:view];
                        } Failure:nil andNavigation:self.navigationController];
                    }else{
                        /** 产品-配送方式 */
                        ExpressView *expview=[[ExpressView alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(150*7))];
                        expview.index=_productOrderModel.expressMode;
                        expview.subType=[RACSubject subject];
                        [expview.subType subscribeNext:^(id  _Nullable x) {
                            _productOrderModel.expressMode=x;
                            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
                        }];
                        [Master PopSheetView:expview];
                    }
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            /** 支付方式 */
            if (_orderStyle==MLItem) {
                _detailOrderModel.payType=[NSString stringWithFormat:@"%ld",indexPath.row-1];
                [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            }else{
                if (indexPath.row!=0) {
                    if (indexPath.row>1) {
                        _productOrderModel.payType=[NSString stringWithFormat:@"%ld",indexPath.row-1];
                        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }
            }
            
        }
            break;
        default:
            if (indexPath.row==0) {
                Weakify(self);
                NSString *commIds=nil;
                if (_orderStyle==MLItem) {
                    commIds=_detailOrderModel.projectIds;
                }else{
                    commIds=_productOrderModel.productIds;
                }
                [Master HttpPostRequestByParams:@{@"clientId":[Acount shareManager].id,@"commIds":commIds,@"commType":_orderStyle==MLItem ? @"1":@"3"} url:mlqqm serviceCode:yhqsx Success:^(id json) {
                    SonCouponTableController *controller=[[SonCouponTableController alloc]init];
                    controller.isOrder=YES;
                    controller.listArray=[[NSMutableArray alloc]initWithArray:json[@"info"]];
                    controller.subCouponId=[RACSubject subject];
                    [controller.subCouponId subscribeNext:^(id  _Nullable x) {
                        if (_orderStyle==MLItem) {
                            _detailOrderModel.clientCouponId=x;
                        }else{
                            _productOrderModel.clientCouponId=x;
                        }
                        [tableView reloadData];
                        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                    }];
                    [Wself.navigationController pushViewController:controller animated:YES];
                } Failure:nil andNavigation:self.navigationController];
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
        case MLItem:
            self.detailOrderModel.ip=ip;
            _detailOrderModel.clientId=clientId;
            _detailOrderModel.beauticianId=@"0";
            _detailOrderModel.clientCouponId=@"0";
            _detailOrderModel.payType=@"0";
            if (isArrayEmpty(_carArray)) {
                _detailOrderModel.projectIds=_detailModel.id;
                _detailOrderModel.serviceTime=_detailModel.serviceTime;
                _submitOrderView.totalPrice=_detailModel.price;
                [self.addArray addObject:_detailModel.mj_keyValues];
            }else{
                self.addArray=[[NSMutableArray alloc]initWithArray:_carArray];
                for (NSDictionary *dict in _addArray) {
                    DetailModel *model=[DetailModel mj_objectWithKeyValues:dict];
                    if (!isStringEmpty(_detailOrderModel.projectIds)) {
                        _detailOrderModel.projectIds=[NSString stringWithFormat:@"%@,%@",_detailOrderModel.projectIds,model.id];
                    }else{
                        _detailOrderModel.projectIds=model.id;
                    }
                    _detailOrderModel.serviceTime=[NSString stringWithFormat:@"%ld",[_detailOrderModel.serviceTime integerValue]+[model.serviceTime integerValue]];
                    _submitOrderView.totalPrice=[NSString stringWithFormat:@"%f",([model.price floatValue])+[_submitOrderView.totalPrice floatValue]];
                }
            }
            break;
        default:
            self.productOrderModel.ip=ip;
            _productOrderModel.clientId=clientId;
            _productOrderModel.beauticianId=@"0";
            _productOrderModel.clientCouponId=@"0";
            _productOrderModel.expressMode=@"0";
            _productOrderModel.shoppingCartIds=_cartIds;
            if (isArrayEmpty(_carArray)) {
                _productOrderModel.productIds=_productModel.id;
                _submitOrderView.totalPrice=_productModel.price;
                [self.addArray addObject:_productModel.mj_keyValues];
            }else{
                self.addArray=[[NSMutableArray alloc]initWithArray:_carArray];
                for (NSDictionary *dict in _addArray) {
                    ProductModel *model=[ProductModel mj_objectWithKeyValues:dict];
                    _submitOrderView.totalPrice=[NSString stringWithFormat:@"%f",([model.count integerValue]*[model.price floatValue])+[_submitOrderView.totalPrice floatValue]];
                    for (int i=0; i<[model.count integerValue]; i++) {
                        if (!isStringEmpty(_productOrderModel.productIds)) {
                            _productOrderModel.productIds=[NSString stringWithFormat:@"%@,%@",_productOrderModel.productIds,model.id];
                        }else{
                            _productOrderModel.productIds=model.id;
                        }
                    }
                }
            }
            break;
    }
    [Master HttpPostRequestByParams:@{@"clientId":clientId} url:mlqqm serviceCode:fwdzlb Success:^(id json) {
        NSMutableArray *array=[[NSMutableArray alloc]initWithArray:json[@"info"]];
        for (int i=0; i<array.count; i++) {
            if ([array[i][@"isDefault"] integerValue]==1) {
                _addressModel=[AddressModel mj_objectWithKeyValues:array[i]];
                if (_orderStyle==MLItem) {
                    _detailOrderModel.addressId=_addressModel.id;
                }else{
                    _productOrderModel.addressId=_addressModel.id;
                }
                break;
            }
        }
        [_tableView reloadData];
    } Failure:nil andNavigation:self.navigationController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
