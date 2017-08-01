//
//  RechargeController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "RechargeController.h"

@interface RechargeController ()
@property (nonatomic,strong) UITextField * textField;
@end

@implementation RechargeController

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
        _textField.backgroundColor=[UIColor colorWithHexString:@"#F0F0F0"];
        [_textField makeCornerRadius:5];
        [whiteview addSubview:_textField];
        
        UIButton *done=[[UIButton alloc]init];
        [done makeCornerRadius:Height_Pt(50)];
        [done makeBorderWidth:0.5 withColor:[UIColor colorWithHexString:@"#F0B71F"]];
        done.titleLabel.font=[UIFont systemFontOfSize:Font_Size(40)];
        [done setTitle:@"兑换" forState:UIControlStateNormal];
        [done setTitleColor:[UIColor colorWithHexString:@"#F0B71F"] forState:UIControlStateNormal];
        [whiteview addSubview:done];
    }



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
