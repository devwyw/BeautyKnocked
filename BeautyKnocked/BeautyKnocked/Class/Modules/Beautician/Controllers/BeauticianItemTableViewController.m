//
//  BeauticianItemTableViewController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeauticianItemTableViewController.h"
#import "BeauticianItemViewModel.h"


@interface BeauticianItemTableViewController ()

@property (nonatomic, strong) BeauticianItemViewModel *beauticianItemViewModel;

@end

@implementation BeauticianItemTableViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        self.beauticianItemViewModel = [[BeauticianItemViewModel alloc] init];        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.beauticianItemViewModel registerCellOfBeauticianItemTableView:self.tableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.beauticianItemViewModel numberOfSectionsInBeauticianItemTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.beauticianItemViewModel numberOfRowsInBeauticianItemTableViewAtSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [self.beauticianItemViewModel configureBeauticianItemTableView:tableView AtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.beauticianItemViewModel congigureCellHeightAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.beauticianItemViewModel configureFooterHeightAtSection:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.beauticianItemViewModel configureHeaderHeightAtSection:section];
}

@end
