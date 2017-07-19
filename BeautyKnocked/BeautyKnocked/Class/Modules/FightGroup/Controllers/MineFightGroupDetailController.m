//
//  MineFightGroupDetailController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/13.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MineFightGroupDetailController.h"
#import "MineFightGroupDetailViewModel.h"

@interface MineFightGroupDetailController ()

@property (nonatomic, strong) MineFightGroupDetailViewModel *viewModel;

@end

@implementation MineFightGroupDetailController

-(MineFightGroupDetailViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MineFightGroupDetailViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"拼团详情";
    

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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel ddcs_tableView:tableView heightForRowAtIndexPath:indexPath];
}


@end
