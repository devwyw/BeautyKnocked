//
//  SetupViewModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/28.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "SetupViewModel.h"
#import "AboutUsTableViewController.h"
#import "BeauticianRegistrationController.h"
#import "AppDelegate+JPush.h"

static NSString *const setupCellReuseIdentifier = @"SetupUITableViewCell";

@interface SetupViewModel ()
@property (nonatomic, strong) UIButton *loginOutButton;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UISwitch * userNotificationSwitch;
@end

@implementation SetupViewModel

-(instancetype)init {
    self = [super init];
    if (self) {
        _dataSource = @[@"接收通知",@"美容师报名",@"关于美丽敲敲门",@"清理缓存"];
    }
    return self;
}
-(void)getUserNotificationSwitch{
    self.userNotificationSwitch.on = NO;
    Weakify(self);
    if (SystemVersion>=10.0) {
        UNUserNotificationCenter *entity = [UNUserNotificationCenter currentNotificationCenter];
        [entity getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus==UNNotificationSettingEnabled) {
                Wself.userNotificationSwitch.on = YES;
            }
        }];
    }else if(SystemVersion>=8.0){
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types!=UIUserNotificationTypeNone) {
            self.userNotificationSwitch.on = YES;
        }
    }
}
-(NSUInteger)numberOfRowsAtSection:(NSUInteger)section {
    return _dataSource.count + 1;
}

-(UITableViewCell *)configureTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:setupCellReuseIdentifier];
    }
    [self configureCell:cell indexPath:indexPath];
    
    return cell;
}

-(CGFloat)configTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        return Height_Pt(214);
    }
    return Height_Pt(160);
}

-(void)configTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        BeauticianRegistrationController *beauticianRegistrationVC = [[BeauticianRegistrationController alloc] init];
        [self.navigationController pushViewController:beauticianRegistrationVC animated:YES];
    }else if (indexPath.row == 2) {
        AboutUsTableViewController *aboutVC = [[AboutUsTableViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
}

-(void)configureCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row < 4) {
        if (indexPath.row==0) {
            cell.accessoryView = self.userNotificationSwitch;
        }else if(indexPath.row<3){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    }else {
        [cell.contentView addSubview:self.loginOutButton];
        [self.loginOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).with.insets(UIEdgeInsetsMake(Height_Pt(66), Width_Pt(49), 0, Width_Pt(49)));
        }];
    }
}
-(UISwitch *)userNotificationSwitch{
    if (!_userNotificationSwitch) {
        _userNotificationSwitch= [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, Width_Pt(160), Height_Pt(80))];
        _userNotificationSwitch.onTintColor = ThemeColor;
        Weakify(self);
        [[_userNotificationSwitch rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UISwitch * _Nullable message) {
            [Master pushSystemSettingWithUrl:@"App-Prefs:root=www.paisen.com.BeautyKnocked"];
            [Wself.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _userNotificationSwitch;
}
-(UIButton *)loginOutButton {
    if (!_loginOutButton) {
        _loginOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginOutButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
        [_loginOutButton setBackgroundImage:[UIImage imageNamed:@"tijiaokuang"] forState:UIControlStateNormal];
        Weakify(self);
        [[_loginOutButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            if ([[Acount shareManager] isSignInWithNavigationController:Wself.navigationController]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确定要退出登录吗?" message:@"(退出后不会删除历史数据,下次登录仍可使用本账号)" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                [cancelAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
                [alertController addAction:cancelAction];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    Acount *user=[Acount shareManager];
                    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                        NSLog(@"极光推送:%@",iAlias);
                    } seq:[user.id integerValue]];
                    [user SignOutAcount];
                    [Master showSVProgressHUD:@"退出成功" withType:ShowSVProgressTypeSuccess withShowBlock:^{
                        [Wself.navigationController popViewControllerAnimated:YES];
                    }];
                }]];
                [Wself.navigationController presentViewController:alertController animated:YES completion:nil];
            }
        }];
    }
    return _loginOutButton;
}
@end
