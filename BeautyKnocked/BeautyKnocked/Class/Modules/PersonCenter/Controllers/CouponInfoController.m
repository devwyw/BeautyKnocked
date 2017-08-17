//
//  CouponInfoController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/17.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "CouponInfoController.h"
#import "CouponUseCell.h"

@interface CouponInfoController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * tableview;
@property (nonatomic,strong) NSArray * titleq;
@property (nonatomic,strong) NSArray * messagea;
@end

@implementation CouponInfoController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
-(NSArray*)titleq{
    if(!_titleq){
        _titleq=[[NSArray alloc]initWithObjects:@"优惠券是否可以叠加使用？",@"取消订单后，优惠券会返还吗？",@"优惠券可以找零或体现吗？",@"优惠券为什么不可使用？",@"如何获得美丽敲敲门优惠券？", nil];
    }
    return _titleq;
}
-(NSArray*)messagea{
    if(!_messagea){
        _messagea=[[NSArray alloc]initWithObjects:@"一个订单最多只能使用1张优惠券，优惠券可与其他折扣同时进行。",@"订单不可取消，如果顾客因个人原因违约预定的项目只能拨打客服热线400-915-8919进行预约时间上的变更。",@"优惠券不支持找零，不支持提现。",@"某些优惠券使用是有时间规定的，请顾客一定要看清优惠券有效使用时间，部分优惠券只限定某些固定产品或者项目使用。",@"美丽敲敲门APP和官方微信会不定期推出优惠活动，手机用户请尽量关注客户端弹出的活动通知，机会不容错过！", nil];
    }
    return _messagea;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.title=@"优惠券使用说明";
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableview.estimatedRowHeight=100;
    _tableview.backgroundColor=[UIColor clearColor];
    _tableview.bounces=NO;
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(185))];
    _tableview.tableFooterView=footView;
    [_tableview registerClass:[CouponUseCell class] forCellReuseIdentifier:@"CouponUseCell"];
    [self.view addSubview:_tableview];
    
    UILabel *label1=[[UILabel alloc]init];
    label1.font=[UIFont systemFontOfSize:Font_Size(35)];
    label1.text=@"对于本使用说明美丽敲敲门保留最终解释权。";
    [footView addSubview:label1];
    
    UILabel *label2=[[UILabel alloc]init];
    label2.font=[UIFont systemFontOfSize:Font_Size(35)];
    label2.text=@"如有疑问，请拨打客服电话400-915-8919";
    [footView addSubview:label2];
    
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [label1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(footView);
        make.bottom.equalTo(footView.mas_centerY).offset(-Height_Pt(20));
    }];
    [label2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footView.mas_centerY);
        make.centerX.equalTo(footView);
    }];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleq.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponUseCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CouponUseCell" forIndexPath:indexPath];
    cell.titles=self.titleq[indexPath.row];
    cell.messages=self.messagea[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Height_Pt(185);
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
