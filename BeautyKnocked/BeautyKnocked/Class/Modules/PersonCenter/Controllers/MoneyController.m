//
//  MoneyController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MoneyController.h"
#import "MoneyTableController.h"
#import "RechargeController.h"

@interface MoneyController ()
@property (nonatomic,strong) UIButton * item;
@end

@implementation MoneyController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    {
        _item = [[UIButton alloc]initWithFrame:CGRectMake(Width-80, 2, 70, 40)];
        [_item setTag:101];
        _item.titleLabel.font=[UIFont systemFontOfSize:Font_Size(45)];
        [_item setTitle:@"余额明细" forState:UIControlStateNormal];
        [_item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_item setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        Weakify(self);
        [[_item rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            MoneyTableController *table=[[MoneyTableController alloc]init];
            [Wself.navigationController pushViewController:table animated:YES];
        }];
        [self.navigationController.navigationBar addSubview:_item];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_item removeFromSuperview];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的钱包";
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    Acount *user=[Acount shareManager];
    
    /** 我的余额 */
    UIImageView *moneyImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yu-e1"]];
    [self.view addSubview:moneyImage];
    
    UILabel *moneyLabel=[[UILabel alloc]init];
    moneyLabel.text=@"我的余额";
    moneyLabel.font=[UIFont systemFontOfSize:Font_Size(42)];
    moneyLabel.textColor=[UIColor lightGrayColor];
    [self.view addSubview:moneyLabel];
    
    UILabel *money=[[UILabel alloc]init];
    if ([user.money floatValue]<1) {
        money.text=[NSString stringWithFormat:@"¥ %.2f",[user.money floatValue]];
    }else{
        money.text=[NSString stringWithFormat:@"¥ %@",user.money];
    }
    money.font=[UIFont systemFontOfSize:Font_Size(75)];
    money.textColor=[UIColor blackColor];
    [self.view addSubview:money];
    
    [moneyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(Height_Pt(350));
        make.left.equalTo(self.view).offset(Width_Pt(150));
    }];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyImage.mas_bottom).offset(Height_Pt(40));
        make.centerX.equalTo(moneyImage);
    }];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyLabel.mas_bottom).offset(Height_Pt(50));
        make.centerX.equalTo(moneyImage);
    }];
    
    /** 我的等级 */
    UIImageView *levelImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"VIP"]];
    [self.view addSubview:levelImage];
    
    UILabel *levelLabel=[[UILabel alloc]init];
    levelLabel.text=@"我的等级";
    levelLabel.font=[UIFont systemFontOfSize:Font_Size(42)];
    levelLabel.textColor=[UIColor lightGrayColor];
    [self.view addSubview:levelLabel];
    
    UILabel *level=[[UILabel alloc]init];
    level.text=[NSString stringWithFormat:@"VIP%@",user.rank];
    level.font=[UIFont systemFontOfSize:Font_Size(75)];
    level.textColor=[UIColor blackColor];
    [self.view addSubview:level];
    
    [levelImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(Height_Pt(350));
        make.right.equalTo(self.view).offset(-Width_Pt(150));
    }];
    [levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(levelImage.mas_bottom).offset(Height_Pt(40));
        make.centerX.equalTo(levelImage);
    }];
    [level mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(levelLabel.mas_bottom).offset(Height_Pt(50));
        make.centerX.equalTo(levelImage);
    }];
    
    /** 充值 */
    UIButton *normal=[[UIButton alloc]init];
    normal.titleLabel.font=[UIFont systemFontOfSize:Font_Size(47)];
    [normal setTitle:@"正常充值" forState:UIControlStateNormal];
    [normal setBackgroundColor:[UIColor colorWithHexString:@"#FFA700"]];
    [normal makeCornerRadius:Height_Pt(121)/2];
    [[normal rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self pushRecharge];
    }];
    [self.view addSubview:normal];
    
    UIButton *minMoney=[[UIButton alloc]init];
    minMoney.titleLabel.font=[UIFont systemFontOfSize:Font_Size(47)];
    [minMoney setTitle:@"小额充值" forState:UIControlStateNormal];
    [minMoney setBackgroundColor:[UIColor colorWithHexString:@"#E1BF6E"]];
    [minMoney makeCornerRadius:Height_Pt(121)/2];
    [[minMoney rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确定要继续小额充值吗?" message:@"(小额充值将改变您目前VIP等级折扣的优惠情况)" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [cancelAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
        [alertController addAction:cancelAction];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self pushRecharge];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
    [self.view addSubview:minMoney];
    
    [normal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(money.mas_bottom).offset(Height_Pt(285));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(802), Height_Pt(121)));
    }];
    [minMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(normal.mas_bottom).offset(Height_Pt(60));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(802), Height_Pt(121)));
    }];

    if ([[Acount shareManager].rank integerValue]==0) {
        UILabel *message=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(100))];
        message.font=[UIFont systemFontOfSize:Font_Size(30)];
        message.textAlignment=NSTextAlignmentCenter;
        message.text=@"成为VIP可以体验项目VIP价格以及折上折哦~";
        message.textColor=[UIColor colorWithHexString:@"#E0C06E"];
        message.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:message];
        minMoney.hidden=YES;
        [normal setTitle:@"我要充值" forState:UIControlStateNormal];
    }
    // Do any additional setup after loading the view.
}
-(void)pushRecharge{
    RechargeController *controller=[[RechargeController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
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
