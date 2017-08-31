//
//  RechargeController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "RechargeController.h"
#import "RechargeCell.h"
#import "RechargeInfoController.h"

@interface RechargeController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITextField * textField;
@property (nonatomic,strong) UITableView * tableview;
@property (nonatomic,strong) NSMutableArray * rechargeArray;
@end

@implementation RechargeController

-(NSMutableArray*)rechargeArray{
    if (!_rechargeArray) {
        _rechargeArray=[[NSMutableArray alloc]init];
    }
    return _rechargeArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"充值中心";
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    // Do any additional setup after loading the view.
    {
        UIView *whiteview=[[UIView alloc]init];
        whiteview.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:whiteview];
        
        UILabel *title=[[UILabel alloc]init];
        title.text=@"有充值卡序列号？手动兑换充值卡";
        [whiteview addSubview:title];
        
        _textField=[[UITextField alloc]init];
        _textField.placeholder=@"请输入充值卡序列号";
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
        [_textField makeCornerRadius:5];
        [whiteview addSubview:_textField];
        
        UIButton *done=[[UIButton alloc]init];
        [done makeCornerRadius:Height_Pt(50)];
        [done makeBorderWidth:0.5 withColor:[UIColor colorWithHexString:@"#F0B71F"]];
        done.titleLabel.font=[UIFont systemFontOfSize:Font_Size(40)];
        [done setTitle:@"兑换" forState:UIControlStateNormal];
        [done setTitleColor:[UIColor colorWithHexString:@"#F0B71F"] forState:UIControlStateNormal];
        [whiteview addSubview:done];
        
        /** TableView */
        [self.view addSubview:self.tableview];
        
        [whiteview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(Height_Pt(300));
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(whiteview).offset(Height_Pt(30));
            make.left.equalTo(whiteview).offset(Width_Pt(50));
        }];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom).offset(Height_Pt(35));
            make.left.equalTo(whiteview).offset(Width_Pt(50));
            make.bottom.equalTo(whiteview).offset(-Height_Pt(60));
            make.right.equalTo(done.mas_left).offset(-Width_Pt(25));
        }];
        [done mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_textField);
            make.right.equalTo(whiteview).offset(-Width_Pt(25));
            make.size.mas_equalTo(CGSizeMake(Width_Pt(203), Height_Pt(100)));
        }];
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(whiteview.mas_bottom);
            make.left.bottom.right.equalTo(self.view);
        }];
    }
    [self loadHttpData];
}
-(UITableView*)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.estimatedRowHeight=100;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
        [_tableview registerClass:[RechargeCell class] forCellReuseIdentifier:@"RechargeCell"];
    }
    return _tableview;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rechargeArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RechargeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RechargeCell" forIndexPath:indexPath];
    cell.model=[RechargeModel mj_objectWithKeyValues:self.rechargeArray[indexPath.row]];
    Weakify(self);
    [[cell.push takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
        RechargeInfoController *controller=[[RechargeInfoController alloc]init];
        controller.Cid=cell.model.id;
        [Wself.navigationController pushViewController:controller animated:YES];
    }];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RechargeModel *model=[RechargeModel mj_objectWithKeyValues:_rechargeArray[indexPath.row]];
    model.isSelected=!model.isSelected;
    [_rechargeArray replaceObjectAtIndex:indexPath.row withObject:model];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Height_Pt(40);
}
#pragma mark ===== 充值列表 =====
-(void)loadHttpData{
    NSString *code;
    if (_isType) {
        code=xeczlb;
    }else{
        code=czlb;
    }
    Weakify(self);
    [Master HttpPostRequestByParams:@{@"rank":[Acount shareManager].rank} url:mlqqm serviceCode:code Success:^(id json) {
        Wself.rechargeArray=[[NSMutableArray alloc]initWithArray:json[@"info"]];
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
