//
//  MoneyTableController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MoneyTableController.h"
#import "MoneyCell.h"

@interface MoneyTableController ()

@end

@implementation MoneyTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"余额明细";
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    self.tableView.backgroundColor=self.view.backgroundColor;
    self.tableView.estimatedRowHeight=120;
    [self.tableView registerClass:[MoneyCell class] forCellReuseIdentifier:@"MoneyCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoneyCell" forIndexPath:indexPath];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
@end
