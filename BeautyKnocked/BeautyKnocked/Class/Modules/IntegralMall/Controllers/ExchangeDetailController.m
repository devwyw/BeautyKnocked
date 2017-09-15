//
//  ExchangeDetailController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/7.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ExchangeDetailController.h"
#import "ExchangeSuccessController.h"
#import "IntegraHeaderCell.h"
#import "IntegraDataCell.h"
#import "IntegraInfoCell.h"

@interface ExchangeDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *exchangeButton;
@property (nonatomic,strong) IntegraListModel * model;
@end

@implementation ExchangeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"兑换详情";
    self.view.backgroundColor=[UIColor whiteColor];
    [self initializeViews];
    [self addConstraints];
}
-(IntegraListModel*)model{
    if (!_model) {
        _model=[[IntegraListModel alloc]init];
    }
    return _model;
}
-(void)initializeViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 100;
    _tableView.backgroundColor=[UIColor colorWithHexString:@"#f0f0f0"];
    [_tableView registerClass:[IntegraHeaderCell class] forCellReuseIdentifier:@"IntegraHeaderCell"];
    [_tableView registerClass:[IntegraDataCell class] forCellReuseIdentifier:@"IntegraDataCell"];
    [_tableView registerClass:[IntegraInfoCell class] forCellReuseIdentifier:@"IntegraInfoCell"];
    [self.view addSubview:_tableView];
    
    _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_exchangeButton setTitle:@"立即兑换" forState:UIControlStateNormal];
    _exchangeButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    [_exchangeButton setBackgroundColor:[UIColor colorWithHexString:@"#67d75a"]];
    [_exchangeButton makeCornerRadius:6];
    Weakify(self);
    [[_exchangeButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"您确定使用%@积分兑换?",_model.integral] message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [cancelAction setValue:[UIColor darkGrayColor] forKey:@"_titleTextColor"];
        UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            /** 兑换 */
            [Master HttpPostRequestByParams:@{@"clientId":[Acount shareManager].id,@"exchangeId":_model.id} url:mlqqm serviceCode:dh Success:^(id json) {
                ExchangeSuccessController *successController = [[ExchangeSuccessController alloc] init];
                successController.model=[IntegraInfoModel mj_objectWithKeyValues:json[@"info"]];
                [Wself.navigationController pushViewController:successController animated:YES];
            } Failure:nil andNavigation:Wself.navigationController];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okayAction];
        [Wself.navigationController presentViewController:alertController animated:YES completion:nil];
    }];
    [self.view addSubview:_exchangeButton];
    [self loadHttpData];
}
-(void)addConstraints {
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, Height_Pt(214), 0));
    }];
    
    [_exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom).offset(Height_Pt(35));
        make.left.equalTo(self.view).offset(Width_Pt(35));
        make.bottom.equalTo(self.view).offset(-Height_Pt(35));
        make.right.equalTo(self.view).offset(-Width_Pt(35));
    }];
}
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        IntegraHeaderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"IntegraHeaderCell" forIndexPath:indexPath];
        cell.isType=self.isType;
        if (!isStringEmpty(self.model.id)) {
            cell.model=_model;
        }
        return cell;
    }else if (indexPath.section==1){
        IntegraDataCell *cell=[tableView dequeueReusableCellWithIdentifier:@"IntegraDataCell" forIndexPath:indexPath];
        if (!isStringEmpty(self.model.id)) {
            cell.model=_model;
        }
        return cell;
    }else{
        IntegraInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"IntegraInfoCell" forIndexPath:indexPath];
        if (!isStringEmpty(self.model.id)) {
            cell.model=_model;
        }
        return cell;
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
-(void)loadHttpData{
    Weakify(self);
    [Master HttpPostRequestByParams:@{@"id":_aid} url:mlqqm serviceCode:dhxq Success:^(id json) {
        Wself.model=[IntegraListModel mj_objectWithKeyValues:json[@"info"]];
        [_tableView reloadData];
    } Failure:nil andNavigation:self.navigationController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
