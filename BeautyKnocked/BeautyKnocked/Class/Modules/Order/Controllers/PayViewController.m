//
//  PayViewController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/28.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PayViewController.h"
#import "NSString+Attribute.h"
#import "PayInfoViewCell.h"

@interface PayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UILabel * message;
@property (nonatomic,strong) UILabel * money;
@property (nonatomic,strong) UIView * line;
@property (nonatomic,strong) UILabel * myTitle;
@property (nonatomic,strong) UITableView * tableview;
@property (nonatomic,strong) UIButton * pushPay;
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
    NSString *text=[NSString stringWithFormat:@"¥ %@",_model.money];
    NSMutableAttributedString *attributeStr =[text setMinString:@"¥" withMinFont:Font_Size(35) andMaxString:_model.money withMaxFont:Font_Size(70)];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, text.length)];
    _money.attributedText=attributeStr;
    [self.view addSubview:_money];
    
    _line=[[UIView alloc]init];
    _line.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:_line];
    
    _myTitle=[[UILabel alloc]init];
    _myTitle.font=[UIFont systemFontOfSize:Font_Size(40)];
    _myTitle.text=@"60.0";
    [self.view addSubview:_myTitle];
    
    _tableview=[[UITableView alloc]init];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableview.bounces=NO;
    _tableview.estimatedRowHeight=Height_Pt(80);
    _tableview.backgroundColor=[UIColor clearColor];
    [_tableview registerClass:[PayInfoViewCell class] forCellReuseIdentifier:@"PayInfoViewCell"];
    [self.view addSubview:_tableview];
}
-(void)addConstraints {
    [_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(Height_Pt(75));
        make.left.equalTo(self.view).offset(Width_Pt(50));
    }];
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_message.mas_top).offset(Height_Pt(100));
        make.centerX.equalTo(self.view);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_money.mas_bottom).offset(Height_Pt(100));
        make.left.equalTo(self.view).offset(Width_Pt(40));
        make.right.equalTo(self.view).offset(-Width_Pt(40));
        make.height.offset(0.35);
    }];
    [_myTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(Height_Pt(40));
        make.left.equalTo(_message);
    }];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myTitle.mas_bottom).offset(Height_Pt(40));
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-Height_Pt(150));
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2+_model.listArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayInfoViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PayInfoViewCell" forIndexPath:indexPath];
    if (indexPath.row==0) {
        PayInfoModel *model=[[PayInfoModel alloc]init];
        model.name=@"商品名";
        model.num=@"数量";
        model.money=@"价格(元)";
        cell.model=model;
    }else if (indexPath.row==_model.listArray.count+1){
        PayInfoModel *model=[[PayInfoModel alloc]init];
        model.name=@"共计消费";
        model.num=[NSString stringWithFormat:@"%ld",_model.listArray.count];
        model.money=_model.money;
        cell.model=model;
    }else{
        cell.model=[PayInfoModel mj_objectWithKeyValues:_model.listArray[indexPath.row-1]];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
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
