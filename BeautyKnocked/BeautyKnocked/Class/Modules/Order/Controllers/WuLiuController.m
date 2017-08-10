//
//  WuLiuController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/25.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "WuLiuController.h"
#import "WuLiuCell.h"

@interface WuLiuController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIImageView * imageCar;
@property (nonatomic,strong) UILabel * Gslabel;
@property (nonatomic,strong) UILabel * Dhlabel;
@property (nonatomic,strong) UILabel * Gslabel1;
@property (nonatomic,strong) UILabel * Dhlabel1;
@property (nonatomic,strong) UIView * line;
@property (nonatomic,strong) UITableView * tableview;
@end

@implementation WuLiuController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"物流信息"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initializeViews];
    [self addConstraints];
    // Do any additional setup after loading the view.
}
-(void)initializeViews {
    _imageCar=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kuaidi"]];
    [self.view addSubview:_imageCar];
    
    _Gslabel=[[UILabel alloc]init];
    _Gslabel.text=@"物流公司：";
    _Gslabel.textColor=[UIColor grayColor];
    [_Gslabel setFont:[UIFont systemFontOfSize:Font_Size(40)]];
    [self.view addSubview:_Gslabel];
    
    _Dhlabel=[[UILabel alloc]init];
    _Dhlabel.text=@"物流单号：";
    _Dhlabel.textColor=[UIColor grayColor];
    [_Dhlabel setFont:[UIFont systemFontOfSize:Font_Size(40)]];
    [self.view addSubview:_Dhlabel];
    
    _Gslabel1=[[UILabel alloc]init];
    _Gslabel1.text=@"顺丰快递";
    [_Gslabel1 setFont:[UIFont systemFontOfSize:Font_Size(40)]];
    [self.view addSubview:_Gslabel1];
    
    _Dhlabel1=[[UILabel alloc]init];
    _Dhlabel1.text=@"DFC1212A22";
    [_Dhlabel1 setFont:[UIFont systemFontOfSize:Font_Size(40)]];
    [self.view addSubview:_Dhlabel1];
    
    _line=[[UIView alloc]init];
    _line.backgroundColor=[UIColor colorWithHexString:@"#E0E0E0"];
    [self.view addSubview:_line];
    
    [self.view addSubview:self.tableview];
}
-(void)addConstraints {
    [_imageCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(Height_Pt(75));
        make.left.equalTo(self.view).offset(Width_Pt(75));
    }];
    [_Gslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageCar.mas_top);
        make.left.equalTo(_imageCar.mas_right).offset(Width_Pt(85));
    }];
    [_Dhlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_imageCar.mas_bottom);
        make.left.equalTo(_imageCar.mas_right).offset(Width_Pt(85));
    }];
    
    [_Gslabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_Gslabel.mas_top);
        make.left.equalTo(_Gslabel.mas_right);
    }];
    [_Dhlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_Dhlabel.mas_top);
        make.left.equalTo(_Dhlabel.mas_right);
    }];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_Dhlabel1.mas_bottom).offset(Height_Pt(75));
        make.left.right.bottom.equalTo(self.view);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_tableview.mas_top);
        make.height.mas_equalTo(0.2);
        make.left.right.equalTo(self.view);
    }];
}
-(UITableView*)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]init];
        _tableview.dataSource=self;
        _tableview.delegate=self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor=[UIColor colorWithHexString:@"#FAFAFA"];
        _tableview.estimatedRowHeight = 100;
    }
    return _tableview;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WuLiuCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[WuLiuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WuLiuCell"];
    }
    if (indexPath.row==0) {
        cell.isBegin=1;
    }
    if (indexPath.row==3) {
        cell.isBegin=0;
    }
    return cell;
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
