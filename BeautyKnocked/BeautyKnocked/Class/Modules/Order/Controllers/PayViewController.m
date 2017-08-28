//
//  PayViewController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/28.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PayViewController.h"
#import "NSString+Attribute.h"

@interface PayViewController ()
@property (nonatomic,strong) UILabel * message;
@property (nonatomic,strong) UILabel * money;
@property (nonatomic,strong) UIView * line;
@property (nonatomic,strong) UILabel * myTitle;
@property (nonatomic,strong) UITableView * tableview;
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"支付收银台";
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self initializeViews];
    [self addConstraints];
}
-(void)initializeViews {
    _message=[[UILabel alloc]init];
    _message.font=[UIFont systemFontOfSize:Font_Size(40)];
    _message.text=@"您总共需要支付:";
    [self.view addSubview:_message];
    
    _money=[[UILabel alloc]init];
    [self.view addSubview:_money];
}
-(void)addConstraints {
    
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
