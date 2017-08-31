//
//  FightGroupMallController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "FightGroupMallController.h"
#import "FightGroupMallViewModel.h"
#import "PaySheetView.h"

@interface FightGroupMallController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) FightGroupMallViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *openGroupBtn;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *tableViewHeaderImgView;

@end

@implementation FightGroupMallController

-(FightGroupMallViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FightGroupMallViewModel alloc] init];
    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.title = @"拼团商城";

    [self initializeViews];
    [self addConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel ddcs_numberOfSectionsInTableView:tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel ddcs_tableView:tableView numberOfRowsInSection:section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel ddcs_tableView:tableView cellForRowAtIndexPath:indexPath];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.viewModel ddcs_tableView:tableView viewForHeaderInSection:section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.viewModel ddcs_tableView:tableView heightForHeaderInSection:section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.viewModel ddcs_tableView:tableView heightForFooterInSection:section];
}
-(void)initializeViews {
    self.viewModel.navigationController = self.navigationController;

    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 100;
    [self.viewModel ddcs_registerClass:_tableView];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.tableHeaderView = self.tableViewHeaderImgView;
    
    _openGroupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_openGroupBtn setTitle:@"一键开团" forState:UIControlStateNormal];
    _openGroupBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [_openGroupBtn setBackgroundImage:[UIImage imageNamed:@"kaituankuang"] forState:UIControlStateNormal];
    [_openGroupBtn addTarget:self action:@selector(fightGroupPayAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_tableView];
    [self.view addSubview:_backView];
    [_backView addSubview:_openGroupBtn];
}
-(void)addConstraints {
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, Height_Pt(160), 0));
    }];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom);
        make.left.and.right.and.bottom.equalTo(self.view);
    }];
    
    [_openGroupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_backView);
        make.size.mas_equalTo(CGSizeMake(Width_Pt(480), Height_Pt(120)));
    }];
}

-(UIImageView *)tableViewHeaderImgView {
    if (!_tableViewHeaderImgView) {
        _tableViewHeaderImgView = [[UIImageView alloc] init];
        _tableViewHeaderImgView.frame = CGRectMake(0, 0, Width, Height_Pt(675));
        [_tableViewHeaderImgView setImage:[UIImage imageNamed:@"chanppic"]];
        _tableViewHeaderImgView.clipsToBounds = YES;
        _tableViewHeaderImgView.contentMode = UIViewContentModeScaleAspectFill;
        
        UIImageView *monthExclusive = [[UIImageView alloc] init];
        [monthExclusive setImage:[UIImage imageNamed:@"benyuezhaunxiang"]];
        [_tableViewHeaderImgView addSubview:monthExclusive];
        
        [monthExclusive mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.equalTo(_tableViewHeaderImgView).with.offset(12);
            make.size.mas_equalTo(CGSizeMake(Width_Pt(193), Height_Pt(183)));
        }];
    }
    return _tableViewHeaderImgView;
}

-(void)fightGroupPayAction:(UIButton *)button {
    PaySheetView *paysheet=[[PaySheetView alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(205+180*4))];
    paysheet.subType=[RACSubject subject];
    [paysheet.subType subscribeNext:^(id  _Nullable x) {
      NSLog(@"%@",x);
    }];
    [LEEAlert actionsheet].config
    .LeeCustomView(paysheet)
    .LeeActionSheetBottomMargin(-5)
    .LeeCornerRadius(0.0f)
    .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderColor([UIColor clearColor])
    .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type) {
        return Width;
    })
    .LeeShow();
}

@end
