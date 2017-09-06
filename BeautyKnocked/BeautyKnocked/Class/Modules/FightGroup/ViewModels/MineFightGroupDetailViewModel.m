//
//  MineFightGroupDetailViewModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/14.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MineFightGroupDetailViewModel.h"
#import "FightGroupHourglassShareView.h"
#import "FightGroupPeopleView.h"


static NSString *const cellReuseIdentifier0 = @"reuseIdentifier0";
static NSString *const cellReuseIdentifier1 = @"reuseIdentifier1";
static NSString *const cellReuseIdentifier2 = @"reuseIdentifier2";
@interface MineFightGroupDetailViewModel ()

@property (nonatomic, strong) NSArray<NSArray *> *titles;
@property (nonatomic, strong) FightGroupHourglassShareView *inviteView;
@property (nonatomic, strong) FightGroupPeopleView *peopleView;

@end

@implementation MineFightGroupDetailViewModel

-(NSInteger)ddcs_numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
-(NSInteger)ddcs_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 4;
    }
    return 1;
}
-(UITableViewCell *)ddcs_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    if (section == 0) {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:self.inviteView];
            [self.inviteView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }
    }else if (section == 1) {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellReuseIdentifier1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:Font_Size(36)];
            cell.textLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
        }
        if (row == 0) {
            [cell.contentView addSubview:self.peopleView];
            [self.peopleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];

        }else {
            cell.textLabel.text = self.titles[section][row];
            cell.detailTextLabel.text = @"详情内容";
        }
        
    }else {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellReuseIdentifier2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:Font_Size(36)];
            cell.textLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            [cell.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.textLabel.mas_bottom).with.offset(Height_Pt(30));
                make.left.equalTo(cell.textLabel.mas_left);
            }];
        }
        cell.textLabel.text = self.titles[section][row];
        cell.detailTextLabel.text = @"•邀请好友参团  •人满则领取优惠券  •人不满将退款";
    }
    
    return cell;
}

-(CGFloat)ddcs_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)ddcs_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return Height_Pt(20);
}
-(CGFloat)ddcs_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return Height_Pt(720);
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return Height_Pt(240);
        }
        return Height_Pt(130);
    }
    return Height_Pt(198);
}
-(NSArray<NSArray *> *)titles {
    if (!_titles) {
        _titles = @[@[@""],@[@"",@"项目名称",@"参团时间",@"订单编号"],@[@"拼团须知"]];
    }
    return _titles;
}

-(FightGroupHourglassShareView *)inviteView {
    if (!_inviteView) {
        _inviteView = [[FightGroupHourglassShareView alloc] init];
        NSString *time = @"18 小时 18 分 30 秒";
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:time];
        NSDictionary *dict = @{NSBackgroundColorAttributeName:[UIColor orangeColor],NSForegroundColorAttributeName:[UIColor whiteColor]};
        [attributeString addAttributes:dict range:NSMakeRange(0, 2)];
        [attributeString addAttributes:dict range:NSMakeRange(6, 2)];
        [attributeString addAttributes:dict range:NSMakeRange(11, 2)];
        _inviteView.hourglass = attributeString;
        
        NSMutableAttributedString *people = [[NSMutableAttributedString alloc] initWithString:@"还差4人,赶快邀请好友来参团吧"];
        [people addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(2, 1)];
        _inviteView.people = people;
        
        [_inviteView setFightGroupShareBlock:^(NSUInteger shareStyle){
            NSArray *shareStyles = @[@"微信好友",@"朋友圈",@"QQ好友",@"微博"];
            NSLog(@"%@",[shareStyles objectAtIndex:shareStyle]);
        }];
        
    }
    return _inviteView;
}



-(FightGroupPeopleView *)peopleView {
    if (!_peopleView) {
        _peopleView = [[FightGroupPeopleView alloc] init];
    }
    return _peopleView;
}

@end
