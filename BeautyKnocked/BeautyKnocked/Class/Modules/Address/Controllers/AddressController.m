//
//  AddressController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/5.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AddressController.h"
#import "CommonAddressCell.h"
#import "EditAddressController.h"

static NSString *const addressCellReuseIdentifier = @"CommonAddressCell";
@interface AddressController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *addNewAddressBtn;
@property (nonatomic, strong) NSMutableArray * listArray;
@end

@implementation AddressController
-(NSMutableArray*)listArray{
    if (!_listArray) {
        _listArray=[[NSMutableArray alloc]init];
    }
    return _listArray;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadHttpData];
}
-(void)setIsSelected:(BOOL)isSelected{
    _isSelected=isSelected;
    if (_isSelected) {
        self.addNewAddressBtn.hidden=YES;
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isSelected) {
        [self.addressId sendNext:self.listArray[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"常用地址";
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    
    [self initializeViews];
    [self addConstraints];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCellReuseIdentifier forIndexPath:indexPath];
    cell.model=[AddressModel mj_objectWithKeyValues:self.listArray[indexPath.row]];
    Weakify(self);
    [[cell.addressEditSignal takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
        EditAddressController *editController = [[EditAddressController alloc] init];
        editController.editStyle = AddressEditStyleUpdate;
        editController.model=cell.model;
        [Wself.navigationController pushViewController:editController animated:YES];
    }];
    [[cell.addressDeleteSignal takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
         UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kulian"]];
        [Master PopAlertView:image WithTitle:@"您确定要删除当前地址吗？" WithDoneBlock:^{
            [Master HttpPostRequestByParams:@{@"id":cell.model.id,@"clientId":[Acount shareManager].id} url:mlqqm serviceCode:scfwdz Success:^(id json) {
                [_listArray removeObjectAtIndex:indexPath.row];
                [_tableView reloadData];
            } Failure:nil andNavigation:Wself.navigationController];
        }];
    }];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}
-(void)initializeViews {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addNewAddressBtn];
}
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate  = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.estimatedRowHeight = 100;
        [_tableView registerClass:[CommonAddressCell class] forCellReuseIdentifier:addressCellReuseIdentifier];
    }
    return _tableView;
}
-(UIButton*)addNewAddressBtn{
    if (!_addNewAddressBtn) {
        _addNewAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addNewAddressBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
        _addNewAddressBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
        [_addNewAddressBtn setImage:[UIImage imageNamed:@"address_add"] forState:UIControlStateNormal];
        [_addNewAddressBtn setBackgroundColor:[UIColor colorWithHexString:@"#E1BF6E"]];
        Weakify(self);
        [[_addNewAddressBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            EditAddressController *editController = [[EditAddressController alloc] init];
            editController.editStyle = AddressEditStyleAddNew;
            [Wself.navigationController pushViewController:editController animated:YES];
        }];
    }
    return _addNewAddressBtn;
}
-(void)addConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, Height_Pt(170), 0));
    }];
    
    [self.addNewAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.top.equalTo(self.tableView.mas_bottom);
    }];
}
-(void)loadHttpData{
    [Master HttpPostRequestByParams:@{@"clientId":[Acount shareManager].id} url:mlqqm serviceCode:fwdzlb Success:^(id json) {
        self.listArray=[[NSMutableArray alloc]initWithArray:json[@"info"]];
        for (int i=0; i<_listArray.count; i++) {
            if ([_listArray[i][@"isDefault"] integerValue]==1) {
                NSDictionary *defaultAddress=[[NSDictionary alloc]initWithDictionary:_listArray[i]];
                [_listArray replaceObjectAtIndex:i withObject:_listArray[0]];
                [_listArray replaceObjectAtIndex:0 withObject:defaultAddress];
                break;
            }
        }
        [_tableView reloadData];
    } Failure:nil andNavigation:self.navigationController];
}
@end
