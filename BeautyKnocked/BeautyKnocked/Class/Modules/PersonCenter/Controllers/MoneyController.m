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
@property (nonatomic,strong) UILabel * message;
@property (nonatomic,strong) UILabel * money;
@property (nonatomic,strong) UILabel * level;
@property (nonatomic,strong) UIButton * normal;
@property (nonatomic,strong) UIButton * minMoney;
@end

@implementation MoneyController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    {
        UIButton *item = [[UIButton alloc]initWithFrame:CGRectMake(Width-80, 2, 70, 40)];
        [item setTag:101];
        item.titleLabel.font=[UIFont systemFontOfSize:Font_Size(45)];
        [item setTitle:@"余额明细" forState:UIControlStateNormal];
        [item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [item addTarget:self action:@selector(moneyPush:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.navigationBar addSubview:item];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIButton *item=(UIButton*)[self.navigationController.navigationBar viewWithTag:101];
    [item removeFromSuperview];
}
-(void)moneyPush:(UIButton*)btn{
    MoneyTableController *table=[[MoneyTableController alloc]init];
    [self.navigationController pushViewController:table animated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的钱包";
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    {
        _message=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(100))];
        _message.font=[UIFont systemFontOfSize:Font_Size(30)];
        _message.textAlignment=NSTextAlignmentCenter;
        _message.text=@"成为VIP可以体验项目VIP价格以及折上折哦~";
        _message.textColor=[UIColor colorWithHexString:@"#E0C06E"];
        _message.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:_message];
    }
    {
        /** 我的余额 */
        UIImageView *moneyImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yu-e1"]];
        [self.view addSubview:moneyImage];
        
        UILabel *moneyLabel=[[UILabel alloc]init];
        moneyLabel.text=@"我的余额";
        moneyLabel.font=[UIFont systemFontOfSize:Font_Size(42)];
        moneyLabel.textColor=[UIColor lightGrayColor];
        [self.view addSubview:moneyLabel];
        
        _money=[[UILabel alloc]init];
        _money.text=@"¥ 5120";
        _money.font=[UIFont systemFontOfSize:Font_Size(75)];
        _money.textColor=[UIColor blackColor];
        [self.view addSubview:_money];
        
        [moneyImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(Height_Pt(350));
            make.left.equalTo(self.view).offset(Width_Pt(150));
        }];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(moneyImage.mas_bottom).offset(Height_Pt(40));
            make.centerX.equalTo(moneyImage);
        }];
        [_money mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(moneyLabel.mas_bottom).offset(Height_Pt(50));
            make.centerX.equalTo(moneyImage);
        }];
    }
    {
        /** 我的等级 */
        UIImageView *levelImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"VIP"]];
        [self.view addSubview:levelImage];
        
        UILabel *levelLabel=[[UILabel alloc]init];
        levelLabel.text=@"我的等级";
        levelLabel.font=[UIFont systemFontOfSize:Font_Size(42)];
        levelLabel.textColor=[UIColor lightGrayColor];
        [self.view addSubview:levelLabel];
        
        _level=[[UILabel alloc]init];
        _level.text=@"VIP3";
        _level.font=[UIFont systemFontOfSize:Font_Size(75)];
        _level.textColor=[UIColor blackColor];
        [self.view addSubview:_level];
        
        [levelImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(Height_Pt(350));
            make.right.equalTo(self.view).offset(-Width_Pt(150));
        }];
        [levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(levelImage.mas_bottom).offset(Height_Pt(40));
            make.centerX.equalTo(levelImage);
        }];
        [_level mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(levelLabel.mas_bottom).offset(Height_Pt(50));
            make.centerX.equalTo(levelImage);
        }];
    }
    {
        /** 充值 */
        _normal=[[UIButton alloc]init];
        _normal.titleLabel.font=[UIFont systemFontOfSize:Font_Size(47)];
        [_normal setTitle:@"正常充值" forState:UIControlStateNormal];
        [_normal setBackgroundColor:[UIColor colorWithHexString:@"#FFA700"]];
        [_normal makeCornerRadius:Height_Pt(121)/2];
        [[_normal rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self pushRecharge];
        }];
        [self.view addSubview:_normal];
        
        _minMoney=[[UIButton alloc]init];
        _minMoney.titleLabel.font=[UIFont systemFontOfSize:Font_Size(47)];
        [_minMoney setTitle:@"小额充值" forState:UIControlStateNormal];
        [_minMoney setBackgroundColor:[UIColor colorWithHexString:@"#E1BF6E"]];
        [_minMoney makeCornerRadius:Height_Pt(121)/2];
        [[_minMoney rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确定要继续小额充值吗?" message:@"(小额充值将改变您目前VIP等级折扣的优惠情况)" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            [cancelAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
            [alertController addAction:cancelAction];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self pushRecharge];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }];
        [self.view addSubview:_minMoney];
        
        [_normal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_money.mas_bottom).offset(Height_Pt(285));
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(Width_Pt(802), Height_Pt(121)));
        }];
        [_minMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_normal.mas_bottom).offset(Height_Pt(60));
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(Width_Pt(802), Height_Pt(121)));
        }];
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
