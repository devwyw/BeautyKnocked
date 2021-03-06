//
//  PSSetupController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/27.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PSSetupController.h"
#import "SetupViewModel.h"

@interface PSSetupController ()
@property (nonatomic, strong)SetupViewModel *setupViewModel;
@end

@implementation PSSetupController

-(instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStylePlain];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_setupViewModel getUserNotificationSwitchWithTableView:self.tableView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.setupViewModel.navigationController = self.navigationController;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(SetupViewModel *)setupViewModel {
    if (!_setupViewModel) {
        _setupViewModel = [[SetupViewModel alloc] init];
    }
    return _setupViewModel;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.setupViewModel numberOfRowsAtSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.setupViewModel configureTableView:tableView cellForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.setupViewModel configTableView:tableView heightForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return Height_Pt(214);
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [self.setupViewModel configTableView:tableView viewForFooterInSection:section];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.setupViewModel configTableView:tableView didSelectRowAtIndexPath:indexPath];
}
@end
