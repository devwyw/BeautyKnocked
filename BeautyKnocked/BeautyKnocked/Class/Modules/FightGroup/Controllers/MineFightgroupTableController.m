//
//  MineFightgroupTableController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/13.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MineFightgroupTableController.h"
#import "MineFightGroupViewModel.h"

@interface MineFightgroupTableController ()

@property (nonatomic, strong) MineFightGroupViewModel *viewModel;

@end

@implementation MineFightgroupTableController

-(MineFightGroupViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [MineFightGroupViewModel new];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewModel ddcs_registerClass:self.tableView];
    self.tableView.estimatedRowHeight = 100;
    self.viewModel.navigationController = self.navigationController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel ddcs_numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel ddcs_tableView:tableView numberOfRowsInSection:section];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(20))];
    view.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.viewModel ddcs_tableView:tableView cellForRowAtIndexPath:indexPath];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.viewModel ddcs_tableView:tableView heightForHeaderInSection:section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.viewModel ddcs_tableView:tableView heightForFooterInSection:section];
}

@end
