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
#import <SDImageCache.h>
#import <SVProgressHUD.h>

@interface SetupViewModel ()
@property (nonatomic,strong) UIButton *loginOutButton;
@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,assign) BOOL isStart;
@end

@implementation SetupViewModel

-(instancetype)init {
    self = [super init];
    if (self) {
        _dataSource = @[@"接收通知",@"美容师报名",@"关于美丽敲敲门",@"清理缓存"];
    }
    return self;
}
-(void)getUserNotificationSwitchWithTableView:(UITableView*)tableview{
    if (SystemVersion>=10.0) {
        UNUserNotificationCenter *entity = [UNUserNotificationCenter currentNotificationCenter];
        [entity getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus==UNNotificationSettingEnabled) {
                _isStart=YES;
            }else{
                _isStart=NO;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            });
        }];
    }else if(SystemVersion>=8.0){
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types!=UIUserNotificationTypeNone) {
            _isStart=YES;
        }else{
            _isStart=NO;
        }
         [tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}
-(NSUInteger)numberOfRowsAtSection:(NSUInteger)section {
    return _dataSource.count;
}
-(UITableViewCell *)configureTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    if (indexPath.row==0) {
        Weakify(self);
        UISwitch *notificationSwitchs= [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, Width_Pt(160), Height_Pt(80))];
        notificationSwitchs.onTintColor = ThemeColor;
        notificationSwitchs.on=_isStart;
        [[notificationSwitchs rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UISwitch * _Nullable message) {
            [Master pushSystemSettingWithUrl:@"App-Prefs:root=www.paisen.com.BeautyKnocked"];
            [Wself.navigationController popViewControllerAnimated:YES];
        }];
        cell.accessoryView = notificationSwitchs;
    }else if(indexPath.row<3){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.row==3){
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width_Pt(180), Height_Pt(40))];
        label.textColor=[UIColor darkGrayColor];
        label.textAlignment=NSTextAlignmentRight;
        label.font=[UIFont systemFontOfSize:Font_Size(40)];
        float cacheSize = [[SDImageCache sharedImageCache] getSize];
        label.text=cacheSize/(1024*1024) >= 1 ? [NSString stringWithFormat:@"%.1fMB",cacheSize/(1024*1024)] : [NSString stringWithFormat:@"%.1fKB",cacheSize/1024];
        cell.accessoryView = label;
    }
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
    }else if (indexPath.row==3){
        [SVProgressHUD show];
        [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            [SVProgressHUD dismissWithDelay:3 completion:^{
                [Master showSVProgressHUD:@"清理完成~" withType:ShowSVProgressTypeSuccess withShowBlock:^{
                    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }];
            }];
            
        }];
    }
}
-(UIView*)configTableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(214))];
    [view addSubview:self.loginOutButton];
    [self.loginOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view).with.insets(UIEdgeInsetsMake(Height_Pt(66), Width_Pt(50), 0, Width_Pt(50)));
    }];
    return view;
}
-(UIButton *)loginOutButton {
    if (!_loginOutButton) {
        _loginOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginOutButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
        [_loginOutButton setBackgroundImage:[UIImage imageNamed:@"tijiaokuang"] forState:UIControlStateNormal];
        Weakify(self);
        [[_loginOutButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            Acount *user=[Acount shareManager];
            if ([user isSignInWithNavigationController:Wself.navigationController]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确定要退出登录吗?" message:@"(退出后不会删除历史数据,下次登录仍可使用本账号)" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                [cancelAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
                [alertController addAction:cancelAction];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [Master HttpPostRequestByParams:@{@"id":user.id} url:mlqqm serviceCode:tcdl Success:^(id json) {
                        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                        } seq:[user.id integerValue]];
                        [user SignOutAcount];
                        [Master showSVProgressHUD:@"退出成功" withType:ShowSVProgressTypeSuccess withShowBlock:^{
                            [Wself.navigationController popViewControllerAnimated:YES];
                        }];
                    } Failure:nil andNavigation:Wself.navigationController];
                }]];
                [Wself.navigationController presentViewController:alertController animated:YES completion:nil];
            }
        }];
    }
    return _loginOutButton;
}
@end
