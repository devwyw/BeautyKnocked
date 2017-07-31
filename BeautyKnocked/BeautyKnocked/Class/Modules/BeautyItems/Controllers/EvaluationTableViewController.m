//
//  EvaluationTableViewController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/5.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "EvaluationTableViewController.h"
#import "EvaluationCell.h"

static NSString *const evaluationCellIdentifier = @"EvaluationCell";

@interface EvaluationTableViewController ()

@end

@implementation EvaluationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 150;
    [self.tableView registerClass:[EvaluationCell class] forCellReuseIdentifier:evaluationCellIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EvaluationCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluationCellIdentifier forIndexPath:indexPath];
    
    NSArray *names = @[@"美容师-李荣萍",@"美容师-吴思雨",@"美容师-平平",@"",@"美容师-楚留香"];
    NSArray *images = @[@[@"touxiang_03"],
                        @[@"touxiang_03",@"touxiang_03"],
                        @[@"touxiang_03",@"touxiang_03",@"touxiang_03"],
                        @[],
                        @[@"touxiang_03",@"touxiang_03",@"touxiang_03"]];
    cell.images = images[indexPath.row];
    cell.beauticianName = self.name ? names[indexPath.row] : @"";
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

@end
