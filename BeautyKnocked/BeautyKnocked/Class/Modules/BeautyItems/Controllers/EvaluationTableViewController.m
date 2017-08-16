//
//  EvaluationTableViewController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/5.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "EvaluationTableViewController.h"
#import "EvaluationCell.h"
#import "CommentModel.h"

static NSString *const evaluationCellIdentifier = @"EvaluationCell";

@interface EvaluationTableViewController ()
@property (nonatomic,strong) NSArray * list;
@end

@implementation EvaluationTableViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.backgroundColor=[UIColor clearColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(NSArray*)list{
    if (!_list) {
        _list=[[NSArray alloc]init];
    }
    return _list;
}
-(void)setListArray:(NSArray *)listArray{
    self.list=[[NSArray alloc]initWithArray:listArray];
    [self.tableView reloadData];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentModel *model=[[CommentModel alloc]init];
    model=[CommentModel mj_objectWithKeyValues:self.list[indexPath.row]];
    EvaluationCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[EvaluationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EvaluationCell"];
    }
    cell.model=model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
@end
