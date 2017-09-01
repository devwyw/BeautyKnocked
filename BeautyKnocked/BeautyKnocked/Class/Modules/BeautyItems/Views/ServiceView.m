//
//  ServiceView.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/26.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ServiceView.h"
#import "ServiceCell.h"

@interface ServiceView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UILabel *selectPaymentLabel;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *confirmPayButton;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation ServiceView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self setupUI];
    }
    return self;
}
-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]initWithObjects:
                       @{@"image":@"chidaoshengji",@"name":@"迟到升级",@"cont":@"美容师迟到30分钟，按当次服务实付金额的150%免费升级项目。"},
                       @{@"image":@"shaungyuepeichang",@"name":@"爽约赔偿",@"cont":@"服务开始前60分钟，美容师临时爽约，平台予以顾客全额退款。"},
                       @{@"image":@"yuyuebiangeng",@"name":@"预约变更",@"cont":@"如需变更服务时间或服务地址，请至少提前三小时联系您的专属美容师，或拨打美丽敲敲门热线：400-915-8919"},
                       @{@"image":@"rushimiaoshu",@"name":@"如实描述",@"cont":@"说到做到，实际服务时长、产品品质低于平台发布的作品描述，当次服务免单，额外获赔100%！"},
                       @{@"image":@"xianxingpeifu",@"name":@"先行赔付",@"cont":@"平台先行赔付；如果美容师跳开平台与您私下交易，额外获赔3000元奖励！"},
                       @{@"image":@"zengsongbaoxian",@"name":@"赠送保险",@"cont":@"每单赠送保障险，用户因服务受到人身或财产意外损害，享高额保险赔偿。"},nil];
    }
    return _dataSource;
}
-(void)setupUI {
    _selectPaymentLabel = [[UILabel alloc]init];
    _selectPaymentLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    _selectPaymentLabel.text = @"服务保障";
    [self addSubview:_selectPaymentLabel];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight=100;
    [_tableView registerClass:[ServiceCell class] forCellReuseIdentifier:@"ServiceCell"];
    [self addSubview:_tableView];
    
    _confirmPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmPayButton setTitle:@"我知道了" forState:UIControlStateNormal];
    _confirmPayButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    [_confirmPayButton setBackgroundColor:ThemeColor];
    [[_confirmPayButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [Master RemovePopViewWithBlock:nil];
    }];
    [self addSubview:_confirmPayButton];
    
    [_selectPaymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(Height_Pt(150));
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_selectPaymentLabel.mas_bottom);
        make.left.and.right.equalTo(self);
    }];
    
    [_confirmPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom);
        make.left.bottom.right.equalTo(self);
        make.height.offset(Height_Pt(150));
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ServiceCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ServiceCell" forIndexPath:indexPath];
    cell.imageName=self.dataSource[indexPath.row][@"image"];
    cell.titleText=self.dataSource[indexPath.row][@"name"];
    cell.messageText=self.dataSource[indexPath.row][@"cont"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
@end
