//
//  BeauticianItemController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/22.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeauticianItemController.h"
#import "BeautyItemsCell.h"
#import "PSFooterReserveView.h"
#import "ConfirmOrderController.h"

@interface BeauticianItemController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) PSFooterReserveView *reserveView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) NSMutableArray * selectArray;
@end

@implementation BeauticianItemController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F2F2F2"];
    [self addViews];
    [self addConstraints];
    [self loadHttpData];
}
-(NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    return _dataArray;
}
-(NSMutableArray*)selectArray{
    if (!_selectArray) {
        _selectArray=[[NSMutableArray alloc]init];
    }
    return _selectArray;
}
-(void)addViews {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.reserveView];
}
-(void)addConstraints {
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(self.view);
        make.bottom.equalTo(_reserveView.mas_top);
    }];
    
    [_reserveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.height.mas_equalTo(Height_Pt(146));
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BeautyItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BeautyItemsCell" forIndexPath:indexPath];
    cell.model=[ItemClassModel mj_objectWithKeyValues:_dataArray[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemClassModel *model=[ItemClassModel mj_objectWithKeyValues:_dataArray[indexPath.row]];
    if (!model.isSelect) {
        if (self.selectArray.count>=4) {
            switch ([_model.type integerValue]) {
                case 7:
                    [Master showSVProgressHUD:@"您已添加四个产品，不能再继续添加产品咯~" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                    break;
                case 8:
                    [Master showSVProgressHUD:@"您已添加四个套餐，不能再继续添加套餐咯~" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                    break;
                default:
                    [Master showSVProgressHUD:@"您已添加四个项目，考虑时间因素不能再继续添加项目咯~" withType:ShowSVProgressTypeInfo withShowBlock:nil];
                    break;
            }
        }else{
            model.isSelect=!model.isSelect;
            _reserveView.price=[NSString stringWithFormat:@"%.f",[_reserveView.price floatValue]+[model.price floatValue]];
            [_selectArray addObject:model.mj_keyValues];
            [_dataArray replaceObjectAtIndex:indexPath.row withObject:model.mj_keyValues];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    }else{
        [_selectArray removeObject:model.mj_keyValues];
        model.isSelect=!model.isSelect;
        _reserveView.price=[NSString stringWithFormat:@"%.f",[_reserveView.price floatValue]-[model.price floatValue]];
        [_dataArray replaceObjectAtIndex:indexPath.row withObject:model.mj_keyValues];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Height_Pt(320);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor=[UIColor clearColor];
        [_tableView registerClass:[BeautyItemsCell class] forCellReuseIdentifier:@"BeautyItemsCell"];
    }
    return _tableView;
}
-(PSFooterReserveView *)reserveView {
    if (!_reserveView) {
        _reserveView = [[PSFooterReserveView alloc] init];
        if ([_model.type integerValue]<7) {
            _reserveView.btnName=@"立即预约";
        }else{
            _reserveView.btnName=@"立即购买";
        }
        Weakify(self);
        [_reserveView.subPush subscribeNext:^(id  _Nullable x) {
            if (_selectArray.count>=1) {
                switch ([_model.type integerValue]) {
                    case 7:
                    {
                        ConfirmOrderController *controller=[[ConfirmOrderController alloc]init];
                        controller.orderStyle=MLProduct;
                        controller.carArray=[[NSArray alloc]initWithArray:_selectArray];
                        [Wself.navigationController pushViewController:controller animated:YES];
                    }
                        break;
                    case 8:
                    {
                        
                    }
                        break;
                    default:
                    {
                        ConfirmOrderController *controller=[[ConfirmOrderController alloc]init];
                        controller.orderStyle=MLItem;
                        controller.carArray=[[NSArray alloc]initWithArray:_selectArray];
                        [Wself.navigationController pushViewController:controller animated:YES];
                    }
                        break;
                }
            }else{
                [Master showSVProgressHUD:@"最少选择1项进行结算" withType:ShowSVProgressTypeInfo withShowBlock:nil];
            }
        }];
    }
    return _reserveView;
}
-(void)loadHttpData{
    [Master HttpPostRequestByParams:@{@"type":_model.type} url:mlqqm serviceCode:_model.interfacePath Success:^(id json) {
        _dataArray=[[NSMutableArray alloc]initWithArray:json[@"info"]];
        [_tableView reloadData];
    } Failure:nil andNavigation:self.navigationController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
