//
//  UserCnterViewModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/10.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "UserCnterViewModel.h"
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
#import "MessageView.h"
#import "MoneyController.h"
#import "LoginController.h"
#import "CouponController.h"

@interface UserCnterViewModel ()<PSheaderViewDelegate,ToolItemViewDelegate>

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
    if (indexPath.section==2) {
        switch (indexPath.row) {
            case 0:
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"我们将会为您拨打美丽热线电话" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [Master pushSystemSettingWithUrl:@"tel://4009158919"];
                }]];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
            }
                break;
               case 1:
            {
                MessageView *message=[[MessageView alloc]initWithFrame:CGRectMake(0, 0, Width_Pt(1018), Height_Pt(1186)+20)];
                [LEEAlert alert].config
                .LeeCustomView(message)
                .LeeHeaderInsets(UIEdgeInsetsMake(0, 0, 0, 0))
                .LeeHeaderColor([UIColor clearColor])
                .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type) {
                    return Width_Pt(1018);
                })
                .LeeShow();
            }
                break;
            default:
            {
                UserAgreementController *userAgreementController = [[UserAgreementController alloc] init];
                userAgreementController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:userAgreementController animated:YES];
            }
                break;
        }
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
    if ([[Acount shareManager] isSignInWithNavigationController:self.navigationController]) {
        PersonInfoViewController *personInfoVC = [[PersonInfoViewController alloc] init];
        personInfoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:personInfoVC animated:YES];
    }
}
-(void)didSelectedItemAtIndex:(NSUInteger)index {
    if ([[Acount shareManager] isSignInWithNavigationController:self.navigationController]) {
        if (index==2) {
            CouponController *controller=[[CouponController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            MoneyController *controller=[[MoneyController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}
-(void)didGroupClicked:(NSUInteger)index{
    NSLog(@"index == %ld",index);
    
    NSArray *viewControllerClasses = @[[MineFightgroupTableController class],
                                       [MineFightgroupTableController class],
                                       [MineFightgroupTableController class],
                                       [MineFightgroupTableController class]];
    NSArray *titles = @[@"全部",@"等待成团",@"拼团成功",@"拼团失败"];
    
    MyGroupController *pageController = [[MyGroupController alloc] initWithViewControllerClasses:viewControllerClasses andTheirTitles:titles];
    pageController.selectIndex = (int)index;
    pageController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pageController animated:YES];
}

#pragma mark ToolItemViewDelegate
-(void)didChooseToolAtIndex:(NSUInteger)index {
    if ([[Acount shareManager] isSignInWithNavigationController:self.navigationController]) {
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
}
@end
