//
//  AddressController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/5.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AddressController.h"
#import "CommonAddressCell.h"
#import "EditAddressController.h"

static NSString *const addressCellReuseIdentifier = @"CommonAddressCell";
@interface AddressController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *addNewAddressBtn;
@end

@implementation AddressController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"常用地址";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    
    [self initializeViews];
    [self addConstraints];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommonAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCellReuseIdentifier forIndexPath:indexPath];
    
    cell.address = @"[默认]喜马拉雅省古怪市阳光滩新区沙迦路888号金久国际大厦";
    Weakify(self);
    [cell.addressEditSignal subscribeNext:^(id  _Nullable x) {
        [Wself pushToEditController:AddressEditStyleUpdate];
    }];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}
-(void)initializeViews {
    self.tableView = ({
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate  = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor=[UIColor clearColor];
        [_tableView registerClass:[CommonAddressCell class] forCellReuseIdentifier:addressCellReuseIdentifier];
        _tableView.estimatedRowHeight = 100;
        
        self.tableView;
    });
    
    self.addNewAddressBtn = ({
        _addNewAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addNewAddressBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
        _addNewAddressBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
        [_addNewAddressBtn setImage:[UIImage imageNamed:@"address_add"] forState:UIControlStateNormal];
        [_addNewAddressBtn setBackgroundColor:[UIColor colorWithHexString:@"#E1BF6E"]];
        Weakify(self);
        [[_addNewAddressBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [Wself pushToEditController:AddressEditStyleAddNew];
        }];
        
        self.addNewAddressBtn;
    });
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addNewAddressBtn];
    
}
-(void)addConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, Height_Pt(170), 0));
    }];
    
    [self.addNewAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.top.equalTo(self.tableView.mas_bottom);
    }];
}

-(void)pushToEditController:(AddressEditStyle)style {
    EditAddressController *editController = [[EditAddressController alloc] init];
    editController.editStyle = style;
    [self.navigationController pushViewController:editController animated:YES];
}

@end
