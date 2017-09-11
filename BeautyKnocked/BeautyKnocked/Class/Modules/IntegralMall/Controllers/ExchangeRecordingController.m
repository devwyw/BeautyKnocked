//
//  ExchangeRecordingController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/7.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ExchangeRecordingController.h"
#import "ExchangeRecordingCell.h"

static NSString *const recordingCellIdentifier = @"ExchangeRecordingCell";
@interface ExchangeRecordingController ()

@end

@implementation ExchangeRecordingController

-(instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兑换记录";
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self.tableView registerClass:[ExchangeRecordingCell class] forCellReuseIdentifier:recordingCellIdentifier];
    self.tableView.estimatedRowHeight = 100;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExchangeRecordingCell *cell = [tableView dequeueReusableCellWithIdentifier:recordingCellIdentifier forIndexPath:indexPath];
    cell.isType=indexPath.row+1%2==1;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return Height_Pt(20);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
