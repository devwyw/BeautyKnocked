//
//  BeauticianRegisterViewModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/31.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeauticianRegisterViewModel.h"
#import "BeauticianRegisterSexView.h"
#import "BeauticianRegisterInputCell.h"
#import "BeauticianRegisterExpertiseView.h"

@interface BeauticianRegisterViewModel ()

@property (nonatomic, strong) BeauticianRegisterSexView *sexView;
@property (nonatomic, strong) BeauticianRegisterExpertiseView *expertiseView;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *placeholders;

@end

static NSString *inputCellReuseIdentifier = @"BeauticianRegisterInputCell";
static NSString *defaultCellReuseIdentifier = @"defaultBeauticianRegisterCell";

@implementation BeauticianRegisterViewModel

-(NSUInteger)numberOfRowsAtSection:(NSUInteger)section {
    return 11;
}

-(UITableViewCell *)configureTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1 || indexPath.row == 6 || indexPath.row == 10) {
        UITableViewCell *cell = nil;
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCellReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 1) {
            [cell.contentView addSubview:self.sexView];
            [self.sexView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }else if (indexPath.row == 6) {
            [cell.contentView addSubview:self.expertiseView];
            [self.expertiseView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }else {
            [cell.contentView addSubview:self.submitButton];
            [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView).with.insets(UIEdgeInsetsMake(Height_Pt(59), Width_Pt(50), 0, Width_Pt(50)));
            }];
        }
        
        return cell;
        
    }else {
        BeauticianRegisterInputCell *cell = [tableView dequeueReusableCellWithIdentifier:inputCellReuseIdentifier forIndexPath:indexPath];
        cell.title = self.titles[indexPath.row];
        cell.placeholder = self.placeholders[indexPath.row];
        
        return cell;
    }
    return nil;
}

-(CGFloat)configTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 6) {
        return Height_Pt(355);
    }else if (indexPath.row == 10) {
        return Height_Pt(209);
    }
    return Height_Pt(115);
}

-(void)configureRegisterTableView:(UITableView *)tableView {
    [tableView registerClass:[BeauticianRegisterInputCell class] forCellReuseIdentifier:inputCellReuseIdentifier];
}

-(BeauticianRegisterSexView *)sexView {
    if (!_sexView) {
        _sexView = [[BeauticianRegisterSexView alloc] init];
    }
    return _sexView;
}

-(BeauticianRegisterExpertiseView *)expertiseView {
    if (!_expertiseView) {
        _expertiseView = [[BeauticianRegisterExpertiseView alloc] init];
    }
    return _expertiseView;
}

-(UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle: self.titles[10] forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(55)];
        [_submitButton setBackgroundImage:[UIImage imageNamed:@"tijiaokuang"] forState:UIControlStateNormal];
    }
    return _submitButton;
}

-(NSArray *)titles {
    if (!_titles) {
        _titles = @[@"姓名",@"性别",@"手机",@"身份证号码",@"紧急联系人",@"联系人电话",@"您的专长",@"工作经验",@"目前收入",@"推荐美容师",@"提交申请"];
    }
    return _titles;
}

-(NSArray *)placeholders {
    if (!_placeholders) {
        _placeholders = @[@"请输入您的姓名",@"性别",@"请输入您的手机号码",@"请输入您的身份证号码",@"请输入联系人姓名",@"请输入联系人电话",@"您的专长",@"请输入相关工作经验年限",@"请输入目前月收入",@"请输入美容师工号或姓名",@"提交申请"];
    }
    return _placeholders;
}

@end
