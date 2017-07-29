//
//  AboutUsTableViewController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/28.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "AboutUsTableViewController.h"
#import "IntroduceUsController.h"
#import "OurcommitmentController.h"

static NSString *const value1CellReuseIdentifier = @"value1CellReuseIdentifier";

@interface AboutUsTableViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) NSArray *detailText;

@property (nonatomic, strong) UIView *tableViewHeaderView;


@end

@implementation AboutUsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = @[@"版本号",@"微信公众号",@"美丽敲敲门介绍",@"我们的承诺"];
    self.tableView.tableHeaderView = self.tableViewHeaderView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:value1CellReuseIdentifier];
        [self configureValue1Cell:cell indexPath:indexPath];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Height_Pt(160);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(void)configureValue1Cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        [cell.detailTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell.contentView);
            make.centerY.equalTo(cell.contentView);
        }];
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
        cell.detailTextLabel.text =  self.detailText[indexPath.row];
    }else if (indexPath.row == 2 || indexPath.row == 3) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        [self.navigationController pushViewController:[[IntroduceUsController alloc] init] animated:YES];
    }else if (indexPath.row == 3) {
        [self.navigationController pushViewController:[[OurcommitmentController alloc] init] animated:YES];
    }
}

-(NSArray *)detailText {
    if (!_detailText) {
        
        NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        NSString *weChatPublicNumber = @"mlqqm0791";
        
        _detailText = @[version,weChatPublicNumber];
    }
    return _detailText;
}

-(UIView *)tableViewHeaderView {
    if (!_tableViewHeaderView) {
        _tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, Height_Pt(490))];
        
        UIImageView *iconImgView = [[UIImageView alloc] init];
        iconImgView.image = [UIImage imageNamed:@"guanyu-logo"];
        [_tableViewHeaderView addSubview:iconImgView];
        [iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_tableViewHeaderView);
            make.top.equalTo(_tableViewHeaderView).with.offset(Height_Pt(76));
            make.size.mas_equalTo(CGSizeMake(Width_Pt(293), Height_Pt(364)));
        }];
        
    }
    return _tableViewHeaderView;
}

@end
