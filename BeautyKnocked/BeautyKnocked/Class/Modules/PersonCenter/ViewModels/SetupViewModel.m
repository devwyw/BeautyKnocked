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

static NSString *const setupCellReuseIdentifier = @"SetupUITableViewCell";

@interface SetupViewModel ()
@property (nonatomic, strong) UIButton *loginOutButton;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation SetupViewModel

-(instancetype)init {
    self = [super init];
    if (self) {
        _dataSource = @[@"接收通知",@"美容师报名",@"关于美丽敲敲门",@"清理缓存"];
    }
    return self;
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
        cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
        
        if (indexPath.row < 3) {
            [self accessoryViewCell:cell indexPath:indexPath];
        }
        
    }else {
        [cell.contentView addSubview:self.loginOutButton];
        [self.loginOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).with.insets(UIEdgeInsetsMake(Height_Pt(66), Width_Pt(49), 0, Width_Pt(49)));
        }];
    }
}

-(void)accessoryViewCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1 || indexPath.row == 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else {
        cell.accessoryView = [self createSwitch];
    }
    
}

-(UISwitch *)createSwitch {
    UISwitch *swtch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, Width_Pt(160), Height_Pt(80))];
    swtch.on = YES;
    swtch.onTintColor = [UIColor orangeColor];
    [[swtch rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(__kindof UISwitch * _Nullable message) {
        [self configurePushMessageByStatus:message.on];
    }];
    
    return swtch;
}

-(UIButton *)loginOutButton {
    if (!_loginOutButton) {
        _loginOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginOutButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
        [_loginOutButton setBackgroundImage:[UIImage imageNamed:@"tijiaokuang"] forState:UIControlStateNormal];
        [_loginOutButton addTarget:self action:@selector(loginOutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginOutButton;
}

-(void)configurePushMessageByStatus:(BOOL)status {
    
    if (status) {
        NSLog(@"接收通知");
    } else {
        NSLog(@"关闭通知");
    }
}

-(void)loginOutButtonClicked {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确定要退出登录吗?" message:@"(退出后不会删除历史数据,下次登录仍可使用本账号)" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [cancelAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}


@end
