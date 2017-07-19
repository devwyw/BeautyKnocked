//
//  BeauticianListViewModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/10.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeauticianListViewModel.h"
#import "BeauticianCell.h"
#import "BeauticianItemPageController.h"

@interface BeauticianListViewModel ()<BeauticianCellDelegate>


@end

static NSString *const cellIdentifier = @"BeauticianCell";
@implementation BeauticianListViewModel


-(NSUInteger)numberOfRowsAtSection:(NSUInteger)section {
    return 6;
}

-(UITableViewCell *)configureTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BeauticianCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.delegate = self;
    
    cell.number = indexPath.row + 1;
    
    return cell;
}

+(void)registerTableViewCellWithTableView:(UITableView *)tableView {
    [tableView registerClass:[BeauticianCell class] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark BeauticianCellDelegate

-(void)reserveBeautician {
    
    BeauticianItemPageController *beauticianPageController = [[BeauticianItemPageController alloc] init];
    [beauticianPageController setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:beauticianPageController animated:YES];
}

@end
