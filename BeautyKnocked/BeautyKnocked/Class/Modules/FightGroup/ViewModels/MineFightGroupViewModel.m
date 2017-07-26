//
//  MineFightGroupViewModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/13.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MineFightGroupViewModel.h"
#import "MineFightGroupCell.h"
#import "MineFightGroupDetailController.h"
#import "FightGroupInvitationView.h"


static NSString *const mineFightGroupCellReuseIdentifier = @"MineFightGroupCell";
@interface MineFightGroupViewModel ()<MineFightGroupCellDelegate,FightGroupInvitationViewDelegate>

@end

@implementation MineFightGroupViewModel

-(void)ddcs_registerClass:(UITableView *)tableView {
    [tableView registerClass:[MineFightGroupCell class] forCellReuseIdentifier:mineFightGroupCellReuseIdentifier];
}
-(NSInteger)ddcs_numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}
-(NSInteger)ddcs_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(UITableViewCell *)ddcs_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineFightGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:mineFightGroupCellReuseIdentifier forIndexPath:indexPath];
    
    cell.orderNumber = @"订单: 2155646887897878";
    cell.date = @"日期: 2017-05-31 12:40";
    cell.imageName = @"touxiang_03";
    cell.status = @"待成团";
    cell.itemName = @"水漾海洋特润";
    cell.people = @"5人团";
    cell.hourglass = @"56小时3分50秒";
    cell.price = [[NSAttributedString alloc] initWithString:@"市场价: 380 折扣价: 108"];
    cell.title0 = @"邀请好友成团";
    cell.title1 = @"查看拼团详情";
    cell.delegate = self;
    
    return cell;
}
-(CGFloat)ddcs_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return Height_Pt(20);
}
-(CGFloat)ddcs_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark MineFightGroupCellDelegate
-(void)didClickedAtIndex:(NSUInteger)index {
    if (index == 0) {
        FightGroupInvitationView *inviteview = [[FightGroupInvitationView alloc] initWithFrame:CGRectMake(0, 64, Width, Height-64)];        
        [inviteview.rulesSignal subscribeNext:^(id  _Nullable x) {
            Class ruleViewControllerClass = NSClassFromString(@"FightGroupRulesController");
            [self.navigationController pushViewController:[[ruleViewControllerClass alloc] init] animated:YES];
        }];
        inviteview.delegate = self;
        
        [inviteview showInView:self.navigationController.viewControllers[1].view];
        
    }else if (index == 1) {
        [self.navigationController pushViewController:[[MineFightGroupDetailController alloc] init] animated:YES];
    }else if (index == 2) {
        
    }else if (index == 3) {
        
    }else if (index == 4) {
        
    }else {
        
    }
}

#pragma mark FightGroupInvitationViewDelegate
-(void)didSelectShareStyle:(NSUInteger)style {
    NSArray *shareStyles = @[@"微信好友",@"朋友圈",@"QQ好友",@"微博"];
    NSLog(@"%@",[shareStyles objectAtIndex:style]);
}

@end
