//
//  RechargeInfoController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "RechargeInfoController.h"
#import "PayTypeCell.h"
#import "PayInfoCell.h"
#import "BeauticianController.h"
#import "RechargePayModel.h"
#import "AppDelegate+Alipay.h"
#import "AppDelegate+WXApi.h"
#import "RechargeItemModel.h"
#import "RechargeItemCell.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface RechargeInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableview;
@property (nonatomic,strong) UIButton * payDone;
@property (nonatomic,strong) RechargeModel * rechargeModel;
@property (nonatomic,strong) RechargePayModel * model;
@property (nonatomic,strong) RechargeItemModel * itemModel;
@end

@implementation RechargeInfoController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(RechargeModel*)rechargeModel{
    if (!_rechargeModel) {
        _rechargeModel=[[RechargeModel alloc]init];
    }
    return _rechargeModel;
}
-(RechargePayModel*)model{
    if (!_model) {
        _model=[[RechargePayModel alloc]init];
    }
    return _model;
}
-(RechargeItemModel*)itemModel{
    if (!_itemModel) {
        _itemModel=[[RechargeItemModel alloc]init];
    }
    return _itemModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"充值详情";
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F2F2F2"];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self initializeViews];
    [self addConstraints];
    [self loadHttpData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(success) name:paySuccess object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(failure) name:payFailure object:nil];
}
-(void)success{
    [Master showSVProgressHUD:@"账号充值成功" withType:ShowSVProgressTypeSuccess withShowBlock:nil];
}
-(void)failure{
    [Master showSVProgressHUD:@"账号充值失败" withType:ShowSVProgressTypeError withShowBlock:nil];
}
-(void)initializeViews {
    [self.view addSubview:self.tableview];
    
    _payDone=[[UIButton alloc]init];
    [_payDone setTitle:@"确认支付" forState:UIControlStateNormal];
    [_payDone setBackgroundColor:[UIColor colorWithHexString:@"#67D75A"]];
    Weakify(self);
    [[_payDone rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        if ([_itemModel.choose integerValue]>0){
            [Master showSVProgressHUD:@"请选择选择赠品" withType:ShowSVProgressTypeInfo withShowBlock:nil];
        }else if ([_model.payType integerValue]==0) {
            [Master showSVProgressHUD:@"请选择支付方式" withType:ShowSVProgressTypeInfo withShowBlock:nil];
        }else{
            _model.rules=nil;
            for (NSDictionary *dict in _itemModel.list) {
                RechargeItemInfoModel *model=[RechargeItemInfoModel mj_objectWithKeyValues:dict];
                if (model.isSelected) {
                    if (!isStringEmpty(_model.rules)) {
                        _model.rules=[NSString stringWithFormat:@"%@,%@",_model.rules,model.id];
                    }else{
                        _model.rules=[NSString stringWithFormat:@"%@",model.id];
                    }
                }
            }
            NSLog(@"%@",_model.mj_keyValues);
            [Master HttpPostRequestByParams:_model.mj_keyValues url:mlqqm serviceCode:czdd Success:^(id json) {
                if ([_model.payType integerValue]==1) {
                    [AppDelegate WXPayWithPrepayId:json[@"info"]];
                }else{
                    [AppDelegate AliPayWithPayOrder:json[@"info"]];
                }
            } Failure:nil andNavigation:Wself.navigationController];
        }
    }];
    [self.view addSubview:_payDone];
}
-(void)addConstraints {
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-Height_Pt(150));
    }];
    [_payDone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableview.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];
}
-(UITableView*)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.showsVerticalScrollIndicator=NO;
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.estimatedRowHeight=Height_Pt(100);
        _tableview.backgroundColor=[UIColor clearColor];
        _tableview.bounces=NO;
        [_tableview registerClass:[PayInfoCell class] forCellReuseIdentifier:@"PayInfoCell"];
        [_tableview registerClass:[PayTypeCell class] forCellReuseIdentifier:@"PayTypeCell"];
        [_tableview registerClass:[RechargeItemCell class] forCellReuseIdentifier:@"RechargeItemCell"];
    }
    return _tableview;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 2:
            return self.itemModel.list.count+1;
        case 3:
            return 3;
        default:
            return 1;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            PayInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PayInfoCell" forIndexPath:indexPath];
            cell.model=self.rechargeModel;
            return cell;
        }
            break;
        case 2:
        {
            if (indexPath.row==0) {
                UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellStyleDefault"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.textLabel.font=[UIFont systemFontOfSize:Font_Size(40)];
                cell.textLabel.text=[NSString stringWithFormat:@"赠送列表: %@选%@",self.itemModel.num,self.itemModel.choose];
                return cell;
            }else{
                RechargeItemCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RechargeItemCell" forIndexPath:indexPath];
                cell.model=[RechargeItemInfoModel mj_objectWithKeyValues:self.itemModel.list[indexPath.row-1]];
                return cell;
            }
        }
            break;
        case 3:
        {
            if (indexPath.row==0) {
                UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellStyleDefault"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.textLabel.font=[UIFont systemFontOfSize:Font_Size(40)];
                cell.textLabel.text=@"支付方式";
                return cell;
            }else{
                PayTypeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PayTypeCell" forIndexPath:indexPath];
                NSArray *array=[[NSArray alloc]initWithObjects:@{@"name":@"微信支付",@"image":@"weixin"},@{@"name":@"支付宝支付",@"image":@"zhifubao"},nil];
                cell.model=array[indexPath.row-1];
                if ([self.model.payType integerValue]==indexPath.row) {
                    cell.isSelected=YES;
                }else{
                    cell.isSelected=NO;
                }
                return cell;
            }
        }
            break;
        default:
        {
            UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCellStyleValue1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.textLabel.text=@"技师推荐";
            if ([self.model.beauticianId integerValue]==0) {
                cell.detailTextLabel.text=@"默认随机";
            }else{
                cell.detailTextLabel.text=[NSString stringWithFormat:@"%@号技师",_model.beauticianId];
            }
            cell.textLabel.font=[UIFont systemFontOfSize:Font_Size(40)];
            cell.detailTextLabel.font=cell.textLabel.font;
            cell.detailTextLabel.textColor=[UIColor grayColor];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 1:
        {
            BeauticianController *controller=[[BeauticianController alloc]init];
            controller.isType=1;
            controller.beauticianId=[RACSubject subject];
            [controller.beauticianId subscribeNext:^(id  _Nullable x) {
                _model.beauticianId=x;
                [_tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            }];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            case 2:
        {
            if (indexPath.row!=0) {
                RechargeItemInfoModel *model=[RechargeItemInfoModel mj_objectWithKeyValues:self.itemModel.list[indexPath.row-1]];
                if (!model.isSelected) {
                    if ([_itemModel.choose integerValue]==0)break;
                    model.isSelected=!model.isSelected;
                    _itemModel.choose=[NSString stringWithFormat:@"%ld",[_itemModel.choose integerValue]-1];
                    [_itemModel.list replaceObjectAtIndex:indexPath.row-1 withObject:model.mj_keyValues];
                    [_tableview reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
                }else{
                    model.isSelected=!model.isSelected;
                    _itemModel.choose=[NSString stringWithFormat:@"%ld",[_itemModel.choose integerValue]+1];
                    [_itemModel.list replaceObjectAtIndex:indexPath.row-1 withObject:model.mj_keyValues];
                    [_tableview reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
                }
            }
        }
            break;
        case 3:
        {
            if (indexPath.row==0) return;
            _model.payType=[NSString stringWithFormat:@"%ld",indexPath.row];
            [_tableview reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        default:
            break;
    }
}
-(void)loadHttpData{
    self.model.ip=[Master getIPv4];
    self.model.clientId=[Acount shareManager].id;
    self.model.beauticianId=@"0";
    self.model.payType=@"0";
    self.model.rechargeId=_Cid;

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    {/** 菊花 */
        [SVProgressHUD show];
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD setMinimumDismissTimeInterval:3];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20;
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
    /** 第一次请求 */
    [manager POST:[NSString stringWithFormat:@"%@%@",mlqqm,czxq] parameters:@{@"id":_model.rechargeId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = responseObject;
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _rechargeModel=[RechargeModel mj_objectWithKeyValues:resultDic[@"info"]];
        [_tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        /** 第二次请求 */
        [manager POST:[NSString stringWithFormat:@"%@%@",mlqqm,czzslb] parameters:@{@"rId":_model.rechargeId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
            [SVProgressHUD dismiss];
            NSData *data = responseObject;
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            _itemModel=[RechargeItemModel mj_objectWithKeyValues:resultDic[@"info"]];
            [_tableview reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
            [SVProgressHUD dismiss];
            NSLog(@"网络请求错误: %@",error);
            [Master showSVProgressHUD:[NSString stringWithFormat:@"网络连接错误,错误代码%ld",error.code] withType:ShowSVProgressTypeError withShowBlock:nil];
        }];
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
        [SVProgressHUD dismiss];
        NSLog(@"网络请求错误: %@",error);
        [Master showSVProgressHUD:[NSString stringWithFormat:@"网络连接错误,错误代码%ld",error.code] withType:ShowSVProgressTypeError withShowBlock:nil];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Height_Pt(20);
}

@end
