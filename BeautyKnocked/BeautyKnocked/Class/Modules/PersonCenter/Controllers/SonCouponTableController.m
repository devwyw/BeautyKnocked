//
//  SonCouponTableController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/17.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "SonCouponTableController.h"
#import "CouponCell.h"
#import "CouponInfoController.h"

@interface SonCouponTableController ()
@property (nonatomic,strong) UIButton * item;
@end

@implementation SonCouponTableController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    {
        _item = [[UIButton alloc]initWithFrame:CGRectMake(Width-80, 2, 70, 40)];
        [_item setTag:101];
        _item.titleLabel.font=[UIFont systemFontOfSize:Font_Size(45)];
        [_item setTitle:@"使用说明" forState:UIControlStateNormal];
        [_item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_item setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        Weakify(self);
        [[_item rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            CouponInfoController *controller=[[CouponInfoController alloc]init];
            [Wself.navigationController pushViewController:controller animated:YES];
        }];
        [self.navigationController.navigationBar addSubview:_item];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_item removeFromSuperview];
}
-(instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F2F2F2"];

    self.tableView.estimatedRowHeight=100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CouponCell class] forCellReuseIdentifier:@"CouponCell"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CouponCell" forIndexPath:indexPath];
    return cell;
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
