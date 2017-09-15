//
//  MyPLMessageController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/9/13.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MyPLMessageController.h"

@interface MyPLMessageController ()

@end

@implementation MyPLMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的评论";
    self.view.backgroundColor=[UIColor whiteColor];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
