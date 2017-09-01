//
//  BeauticianRegistrationController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/28.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeauticianRegistrationController.h"
#import "BeauticianRegisterViewModel.h"

@interface BeauticianRegistrationController ()
@property (nonatomic, strong) BeauticianRegisterViewModel *viewModel;
@end

@implementation BeauticianRegistrationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"美容师报名";
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self.viewModel configureRegisterTableView:self.tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRowsAtSection:section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel configureTableView:tableView cellForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel configTableView:tableView heightForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(BeauticianRegisterViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BeauticianRegisterViewModel alloc] init];
    }
    return _viewModel;
}

@end
