//
//  SonCouponTableController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/17.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "SonCouponTableController.h"
#import "CouponCell.h"

@interface SonCouponTableController ()

@end

@implementation SonCouponTableController

-(NSMutableArray*)listArray{
    if (!_listArray) {
        _listArray=[[NSMutableArray alloc]init];
    }
    return _listArray;
}
-(instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isOrder) {
        self.title=@"可用优惠券";
    }
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F2F2F2"];
    self.tableView.estimatedRowHeight=100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CouponCell class] forCellReuseIdentifier:@"CouponCell"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CouponCell" forIndexPath:indexPath];
    cell.model=[CouponModel mj_objectWithKeyValues:self.listArray[indexPath.row]];
    Weakify(self)
    [[cell.useCoupon takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
        if (_isOrder) {
            CouponModel *model=[CouponModel mj_objectWithKeyValues:self.listArray[indexPath.row]];
            [Wself.subCouponId sendNext:model.id];
            [Wself.navigationController popViewControllerAnimated:YES];
        }else{
            switch ([cell.model.type integerValue]) {
                case 5:
                    [Master setTabBarItem:0 withNavigationController:Wself.navigationController];
                    break;
                default:
                    [Master setTabBarItem:2 withNavigationController:Wself.navigationController];
                    break;
            }
        }
    }];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponModel *model=[CouponModel mj_objectWithKeyValues:_listArray[indexPath.row]];
    model.isStatus=!model.isStatus;
    [_listArray replaceObjectAtIndex:indexPath.row withObject:model];
    [self.tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
