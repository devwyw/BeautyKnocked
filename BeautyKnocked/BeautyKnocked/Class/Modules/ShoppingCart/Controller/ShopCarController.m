//
//  ShopCarController.m
//  Technician
//
//  Created by Mac on 2017/8/4.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ShopCarController.h"
#import "ItemCell.h"
#import "FootPriceView.h"
#import "ProductDetailController.h"
#import "ConfirmOrderController.h"
#import "BlankShopCarView.h"
#import "ItemClassModel.h"

@interface ShopCarController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIButton * carAction;
@property (nonatomic,strong) UITableView * tableview;
@property (nonatomic,strong) FootPriceView * footview;
@property (nonatomic,strong) NSMutableArray * cellArray;
@property (nonatomic,strong) NSMutableArray * selectArray;
@property (nonatomic,strong) BlankShopCarView * blankView;
@end

@implementation ShopCarController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.BarAlpha=@"1";
    self.BarColor = [ThemeColor toColorString];
    self.carAction.hidden=NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.carAction.hidden=YES;
}
-(NSMutableArray*)cellArray{
    if (!_cellArray) {
        _cellArray=[[NSMutableArray alloc]init];
    }
    return _cellArray;
}
-(NSMutableArray*)selectArray{
    if (!_selectArray) {
        _selectArray=[[NSMutableArray alloc]init];
    }
    return _selectArray;
}
#pragma mark ===== viewDidload =====
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"购物车";
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F2F2F2"];
    [self.navigationController.navigationBar addSubview:self.carAction];

    [self.view addSubview:self.tableview];
    [self.view addSubview:self.blankView];
    [self.view addSubview:self.footview];
    [self setframe];
    [self loadHttpData];
}
#pragma mark ===== 约束 =====
-(void)setframe{
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-Height_Pt(145));
    }];
    [_blankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-Height_Pt(145));
    }];
    [_footview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableview.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];
}
-(UIButton*)carAction{
    if (!_carAction) {
        _carAction = [[UIButton alloc]initWithFrame:CGRectMake(Width-Width_Pt(125), 5, Width_Pt(80), 34)];
        [_carAction setImage:[UIImage imageNamed:@"shanchu1"] forState:UIControlStateNormal];
        Weakify(self);
        [[_carAction rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (_selectArray.count>0) {
                UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kulian"]];
                [Master PopAlertView:image WithTitle:@"您确定要删除该宝贝吗？" WithDoneBlock:^{
                    [Master HttpPostRequestByParams:@{@"ids":[_selectArray componentsJoinedByString:@","]} url:mlqqm serviceCode:gwcplsc Success:^(id json) {
                        [Master showSVProgressHUD:@"宝贝删除成功" withType:ShowSVProgressTypeSuccess withShowBlock:^{
                            [_selectArray removeAllObjects];
                            [Wself loadHttpData];
                        }];
                    } Failure:nil andNavigation:self.navigationController];
                }];
            }else{
                [Master showSVProgressHUD:@"请最少选择一件宝贝~" withType:ShowSVProgressTypeInfo withShowBlock:nil];
            }
        }];
    }
    return _carAction;
}
-(UITableView*)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]init];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.backgroundColor=[UIColor clearColor];
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_tableview registerClass:[ItemCell class] forCellReuseIdentifier:@"ItemCell"];
    }
    return _tableview;
}
-(BlankShopCarView*)blankView{
    if (!_blankView) {
        Weakify(self);
        _blankView=[[BlankShopCarView alloc]init];
        _blankView.subModel=[RACSubject subject];
        [_blankView.subModel subscribeNext:^(id  _Nullable x) {
            ProductDetailController *productDetailController = [[ProductDetailController alloc] init];
            productDetailController.alpha=@"0";
            productDetailController.id=[ItemClassModel mj_objectWithKeyValues:x].id;
            [Wself.navigationController pushViewController:productDetailController animated:YES];
        }];
    }
    return _blankView;
}
-(FootPriceView*)footview{
    if (!_footview) {
        _footview=[[FootPriceView alloc]init];
        Weakify(self);
        [_footview.allAction subscribeNext:^(id  _Nullable x) {
            /** 全选 */
            _footview.price=@"0";
            [Wself.selectArray removeAllObjects];
            UIButton *button=(UIButton*)x;
            button.selected=!button.selected;
            for (int i = 0; i<_cellArray.count; i++) {
                ShopCarModel *model=[ShopCarModel mj_objectWithKeyValues:self.cellArray[i]];
                model.isSelect=button.selected;
                if (model.isSelect) {
                    [_selectArray addObject:model.id];
                    _footview.price=[NSString stringWithFormat:@"%.f",[_footview.price integerValue]+[model.pv.price floatValue]*[model.num integerValue]];
                }
                [_cellArray replaceObjectAtIndex:i withObject:model.mj_keyValues];
            }
            _footview.btnName=[NSString stringWithFormat:@"%ld",_selectArray.count];
            [_tableview reloadData];
        }];
        [_footview.allBuy subscribeNext:^(id  _Nullable x) {
            /** 结算 */
            if (_selectArray.count>4) {
                [Master showSVProgressHUD:@"只能选择4件宝贝进行结算" withType:ShowSVProgressTypeInfo withShowBlock:nil];
            }else if(_selectArray.count>=1){
                [Master startStatus];
                NSMutableArray *addArray=[[NSMutableArray alloc]init];
                for (NSString *cid in _selectArray) {
                    for (NSDictionary *dict in _cellArray) {
                        ShopCarModel *model=[ShopCarModel mj_objectWithKeyValues:dict];
                        if ([cid integerValue]==[model.id integerValue]) {
                            [Master WebPostRequestByParams:@{@"id":model.pv.id} url:mlqqm serviceCode:cpxq Success:^(id json) {
                                [json[@"info"] setObject:model.num forKey:@"count"];
                                [addArray addObject:json[@"info"]];
                                if (addArray.count==_selectArray.count) {
                                    [Master stopStatus];
                                    ConfirmOrderController *controller=[[ConfirmOrderController alloc]init];
                                    controller.orderStyle=MLProduct;
                                    controller.cartIds=[_selectArray componentsJoinedByString:@","];
                                    controller.carArray=[[NSArray alloc]initWithArray:addArray];
                                    [Wself.navigationController pushViewController:controller animated:YES];
                                }
                            } Failure:nil andNavigation:Wself.navigationController];
                        }
                    }
                }
            }else{
                [Master showSVProgressHUD:@"最少选择1件宝贝进行结算" withType:ShowSVProgressTypeInfo withShowBlock:nil];
            }
        }];
    }
    return _footview;
}
#pragma mark ===== UITableViewDelegate =====
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Height_Pt(320);
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    cell.model=[ShopCarModel mj_objectWithKeyValues:self.cellArray[indexPath.row]];
    cell.subCounts=[RACSubject subject];
    Weakify(self);
    [[cell.subCounts takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
        [Master HttpPostRequestByParams:@{@"id":cell.model.id,@"num":x} url:mlqqm serviceCode:gwcsl Success:^(id json) {
            [Wself loadHttpData];
        } Failure:nil andNavigation:Wself.navigationController];
    }];
    cell.subEdits=[RACSubject subject];
    [[cell.subEdits takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
        cell.model.isEdit=[x integerValue]==1 ? YES:NO;
        [_cellArray replaceObjectAtIndex:indexPath.row withObject:cell.model.mj_keyValues];
    }];
    cell.subCountViews=[RACSubject subject];
    [[cell.subCountViews takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
        cell.model.count=x;
        [_cellArray replaceObjectAtIndex:indexPath.row withObject:cell.model.mj_keyValues];
    }];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopCarModel *model=[ShopCarModel mj_objectWithKeyValues:self.cellArray[indexPath.row]];
    model.isSelect=!model.isSelect;
    if (model.isSelect) {
        [self.selectArray addObject:model.id];
        _footview.price=[NSString stringWithFormat:@"%.f",[_footview.price integerValue]+[model.pv.price floatValue]*[model.num integerValue]];
        _footview.btnName=[NSString stringWithFormat:@"%ld",_selectArray.count];
    }else{
        [self.selectArray removeObject:model.id];
        _footview.price=[NSString stringWithFormat:@"%.f",[_footview.price integerValue]-[model.pv.price floatValue]*[model.num integerValue]];
        _footview.btnName=[NSString stringWithFormat:@"%ld",_selectArray.count];
    }
    [_cellArray replaceObjectAtIndex:indexPath.row withObject:model.mj_keyValues];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark ===== 左滑删除 =====
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopCarModel *model=[ShopCarModel mj_objectWithKeyValues:self.cellArray[indexPath.row]];
    Weakify(self);
    [Master HttpPostRequestByParams:@{@"ids":model.id} url:mlqqm serviceCode:gwcplsc Success:^(id json) {
        [Master showSVProgressHUD:@"宝贝删除成功" withType:ShowSVProgressTypeSuccess withShowBlock:^{
            [Wself loadHttpData];
        }];
    } Failure:nil andNavigation:self.navigationController];
}
-(void)loadHttpData{
    Weakify(self);
    [Master HttpPostRequestByParams:@{@"clientId":[Acount shareManager].id} url:mlqqm serviceCode:gwclb Success:^(id json) {
        [_cellArray removeAllObjects];
        _footview.price=@"0";
        _footview.btnName=@"0";
        _cellArray=[[NSMutableArray alloc]initWithArray:json[@"info"]];
        if (_cellArray.count>0) {
            _blankView.hidden=YES;
        }else{
            _blankView.hidden=NO;
            [Master HttpPostRequestByParams:nil url:mlqqm serviceCode:gycp Success:^(id json) {
                _blankView.data=[[NSArray alloc]initWithArray:json[@"info"]];
            } Failure:nil andNavigation:Wself.navigationController];
        }
        [_tableview reloadData];
    } Failure:nil andNavigation:self.navigationController];
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
