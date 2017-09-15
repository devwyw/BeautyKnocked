//
//  ExchangeRecordingController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/7.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ExchangeRecordingController.h"
#import "ExchangeRecordingCell.h"

static NSString *const recordingCellIdentifier = @"ExchangeRecordingCell";
@interface ExchangeRecordingController ()
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) UIView * nilview;
@end

@implementation ExchangeRecordingController

-(instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}
-(NSArray*)dataArray{
    if (!_dataArray) {
        _dataArray=[[NSArray alloc]init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兑换记录";
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self.tableView registerClass:[ExchangeRecordingCell class] forCellReuseIdentifier:recordingCellIdentifier];
    self.tableView.estimatedRowHeight = 100;

    _nilview=[[UIView alloc]init];
    [self.view addSubview:_nilview];
    [_nilview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(Height_Pt(237));
        make.size.sizeOffset(CGSizeMake(Width, Height_Pt(675)));
    }];
    
    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wujilu"]];
    [_nilview addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nilview);
        make.centerX.equalTo(_nilview);
        make.size.sizeOffset(CGSizeMake(Width_Pt(580), Height_Pt(580)));
    }];
    
    UILabel *title=[[UILabel alloc]init];
    title.text=@"啊哦，您还没有兑换记录~";
    title.textColor=[UIColor darkGrayColor];
    title.font=[UIFont systemFontOfSize:Font_Size(40)];
    [_nilview addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_nilview);
        make.centerX.equalTo(_nilview);
    }];
    
    [self loadHttpData];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExchangeRecordingCell *cell = [tableView dequeueReusableCellWithIdentifier:recordingCellIdentifier forIndexPath:indexPath];
    cell.isType=indexPath.row%2==1;
    cell.model=[IntegraListModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return Height_Pt(20);
}
-(void)loadHttpData{
    Weakify(self);
    [Master HttpPostRequestByParams:@{@"clientId":[Acount shareManager].id} url:mlqqm serviceCode:dhjl Success:^(id json) {
        _dataArray=[[NSArray alloc]initWithArray:json[@"info"]];
        _nilview.hidden=_dataArray.count>0 ? YES:NO;
        [Wself.tableView reloadData];
    } Failure:nil andNavigation:self.navigationController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
