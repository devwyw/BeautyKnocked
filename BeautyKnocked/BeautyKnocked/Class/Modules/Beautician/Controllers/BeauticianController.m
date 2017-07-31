//
//  BeauticianController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/10.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeauticianController.h"
#import "BeauticianListViewModel.h"
#import "BeauticianSortMenuView.h"

@interface BeauticianController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BeauticianSortMenuView *sortMenu;

@property (nonatomic, strong) BeauticianListViewModel *beauticianViewModel;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BeauticianController

-(instancetype)init {
    self = [super init];
    if (self) {
        self.beauticianViewModel = [BeauticianListViewModel new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"预约美容师"];
    // Do any additional setup after loading the view.
    self.beauticianViewModel.navigationController = self.navigationController;
    
    [self addSubItemviews];
    [self configureConstraints];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.beauticianViewModel numberOfRowsAtSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.beauticianViewModel configureTableView:tableView cellForRowAtIndexPath:indexPath];
}
-(void)addSubItemviews {
    
    [self.view addSubview:self.sortMenu];
    [self.view addSubview:self.tableView];
}

-(void)configureConstraints {
    
    [self.sortMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64.f);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(Height_Pt(122.f));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sortMenu.mas_bottom);
        make.left.and.right.and.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-49.f);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BeauticianSortMenuView *)sortMenu {
    if (!_sortMenu) {
        _sortMenu = [[BeauticianSortMenuView alloc] init];
    }
    return _sortMenu;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = 0;
        _tableView.estimatedRowHeight = 300;
        _tableView.backgroundColor=[UIColor colorWithHexString:@"#F0F0F0"];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        [BeauticianListViewModel registerTableViewCellWithTableView:self.tableView];
    }
    return _tableView;
}

@end
