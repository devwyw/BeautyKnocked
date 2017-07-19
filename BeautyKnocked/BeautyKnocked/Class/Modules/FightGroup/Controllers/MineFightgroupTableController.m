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
    self.tableView.estimatedRowHeight = Height_Pt(620);
    //self.tableView.rowHeight = Height_Pt(630);
    self.viewModel.navigationController = self.navigationController;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return [self.viewModel ddcs_numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.viewModel ddcs_tableView:tableView numberOfRowsInSection:section];
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
