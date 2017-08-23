//
//  CollectBeauticianTableViewController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/6.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "CollectBeauticianTableViewController.h"
#import "BeauticianCell.h"

static NSString *const beauticianCellReuseIdentifier = @"BeauticianCell";
@interface CollectBeauticianTableViewController ()

@end

@implementation CollectBeauticianTableViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏技师";
    self.tableView.estimatedRowHeight = 100;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
    [self.tableView registerClass:[BeauticianCell class] forCellReuseIdentifier:beauticianCellReuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BeauticianCell *cell = [tableView dequeueReusableCellWithIdentifier:beauticianCellReuseIdentifier forIndexPath:indexPath];
    [[cell.collect takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
        //收藏
        UIButton *btn=(UIButton*)x;
        if (!btn.isSelected) {
            btn.selected=!btn.isSelected;
        }
    }];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}


@end
