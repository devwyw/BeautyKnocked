//
//  UserCnterViewModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/10.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "UserCnterViewModel.h"
#import "PersonCenterHeadView.h"
#import "ToolItemView.h"
#import "PersonInfoViewController.h"
#import "PSSetupController.h"
#import "UserAgreementController.h"
#import "MyMessageController.h"
#import "AddressController.h"
#import "CollectBeauticianTableViewController.h"
#import "IntegralMallController.h"
#import "SusoensionFlowLayout.h"
#import "MineFightgroupTableController.h"
#import "MyGroupController.h"

@interface UserCnterViewModel ()<PSheaderViewDelegate,ToolItemViewDelegate>

@property (nonatomic, strong) PersonCenterHeadView *headView;

@property (nonatomic, strong) ToolItemView *toolItemView;

@property (nonatomic, strong) NSArray *thirdSectionRows;

@end

@implementation UserCnterViewModel

-(NSUInteger)numberForRowsInSection:(NSUInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    }
    return self.thirdSectionRows.count;
}

-(void)configureCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        [cell.contentView addSubview:self.headView];
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }else if (indexPath.section == 1) {
        [cell.contentView addSubview:self.toolItemView];
        [self.toolItemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }else if (indexPath.section == 2) {
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.text = [self.thirdSectionRows objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

-(void)configureTableView:(UITableView *)tableView didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([indexPath isEqual:[NSIndexPath indexPathForRow:2 inSection:2]]) {
        UserAgreementController *userAgreementController = [[UserAgreementController alloc] init];
        userAgreementController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userAgreementController animated:YES];
    }

}

-(CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return Height_Pt(952);
    }else if (indexPath.section == 1) {
        return Height_Pt(401);
    }    
    return Height_Pt(125);
}

-(PersonCenterHeadView *)headView {
    if (!_headView) {
        _headView = [[PersonCenterHeadView alloc] init];
        _headView.delegate = self;
        
        [_headView.setClickedSignal subscribeNext:^(id  _Nullable x) {
            PSSetupController *setupVC = [[PSSetupController alloc] init];
            setupVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setupVC animated:YES];
        }];
        
        [_headView.messageClickedSignal subscribeNext:^(id  _Nullable x) {
            MyMessageController *newsVC = [[MyMessageController alloc] init];
            newsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:newsVC animated:YES];
        }];
        
    }
    return _headView;
}

-(ToolItemView *)toolItemView {
    if (!_toolItemView) {
        _toolItemView = [[ToolItemView alloc] init];
        _toolItemView.delegate = self;
    }
    return _toolItemView;
}

-(NSArray *)thirdSectionRows {
    if (!_thirdSectionRows) {
        _thirdSectionRows = @[@"联系我们",@"意见反馈",@"用户协议"];
    }
    return _thirdSectionRows;
}

#pragma mark PSheaderViewDelegate
-(void)headIconDidClicked {
    PersonInfoViewController *personInfoVC = [[PersonInfoViewController alloc] init];
    personInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personInfoVC animated:YES];
}
-(void)didSelectedItemAtIndex:(NSUInteger)index {
    NSLog(@"index == %lu",(unsigned long)index);
}
-(void)didGroupClicked:(NSUInteger)index {
    NSLog(@"index == %lu",(unsigned long)index);
    
    NSArray *viewControllerClasses = @[[MineFightgroupTableController class],
                                       [MineFightgroupTableController class],
                                       [MineFightgroupTableController class],
                                       [MineFightgroupTableController class]];
    NSArray *titles = @[@"全部",@"等待成团",@"拼团成功",@"拼团失败"];
    MyGroupController *pageController = [[MyGroupController alloc] initWithViewControllerClasses:viewControllerClasses andTheirTitles:titles];
    pageController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pageController animated:YES];
    
}

#pragma mark ToolItemViewDelegate
-(void)didChooseToolAtIndex:(NSUInteger)index {
    if (index == 1) {
        CollectBeauticianTableViewController *collectVC = [[CollectBeauticianTableViewController alloc] init];
        collectVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:collectVC animated:YES];
    }else if (index == 2) {
        
    }else if (index == 3) {
        AddressController *addressVC = [[AddressController alloc] init];
        addressVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addressVC animated:YES];
    }else if (index == 4) {
        IntegralMallController *integralMallVC = [[IntegralMallController alloc] initWithCollectionViewLayout:[[SusoensionFlowLayout alloc] init]];
        integralMallVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:integralMallVC animated:YES];
    }
}
@end
