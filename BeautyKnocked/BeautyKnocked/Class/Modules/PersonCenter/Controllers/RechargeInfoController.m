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

@interface RechargeInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableview;
@property (nonatomic,strong) UIButton * payDone;

@end
static NSInteger indexSelect=1;

@implementation RechargeInfoController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"充值详情";
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F2F2F2"];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self initializeViews];
    [self addConstraints];
}
-(void)initializeViews {
    [self.view addSubview:self.tableview];
    
    _payDone=[[UIButton alloc]init];
    [_payDone setTitle:@"确认支付" forState:UIControlStateNormal];
    [_payDone setBackgroundColor:[UIColor colorWithHexString:@"#67D75A"]];
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
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.estimatedRowHeight=Height_Pt(100);
        _tableview.backgroundColor=[UIColor clearColor];
        _tableview.bounces=NO;
    }
    return _tableview;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 2:
            return 3;
        default:
            return 1;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            PayInfoCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell=[[PayInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PayInfoCell"];
            }
            return cell;
        }
        case 2:
        {
            if (indexPath.row==0) {
                UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellStyleDefault"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.textLabel.font=[UIFont systemFontOfSize:Font_Size(40)];
                cell.textLabel.text=@"请选择支付方式";
                return cell;
            }else{
                PayTypeCell *cell=[tableView cellForRowAtIndexPath:indexPath];
                if (!cell) {
                    cell=[[PayTypeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PayTypeCell"];
                }
                if (indexPath.row==indexSelect) {
                    UIImageView *image=(UIImageView*)cell.accessoryView;
                    image.highlighted=YES;
                }
                return cell;
            }
        }
        default:
        {
            UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCellStyleValue1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.textLabel.text=@"技师推荐";
            cell.detailTextLabel.text=@"默认随机";
            cell.textLabel.font=[UIFont systemFontOfSize:Font_Size(40)];
            cell.detailTextLabel.font=cell.textLabel.font;
            cell.detailTextLabel.textColor=[UIColor grayColor];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text=@"7号技师";
    }else if (indexPath.section==2 && indexPath.row>0){
        PayTypeCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        indexSelect=indexPath.row;
        for (UITableViewCell *allCell in tableView.visibleCells) {
            UIImageView *image=(UIImageView*)allCell.accessoryView;
            image.highlighted=[cell isEqual:allCell] ? YES : NO;
        }
    }
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
