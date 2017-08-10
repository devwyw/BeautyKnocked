//
//  FightGroupMallViewModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/9.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "FightGroupMallViewModel.h"
#import "FightGroupTitleView.h"
#import "FightGroupRulesView.h"
#import "EquippedProductsView.h"
#import "EvaluationHeaderView.h"
#import "EvaluationFooterView.h"
#import "EvaluationCell.h"
#import "EvaluationTableViewController.h"
#import "FightGroupSectionTitle.h"
#import "FightingGroupCell.h"
#import "FightGroupRulesController.h"
#import "CommentController.h"

static NSString *const cellReuseIdentifier = @"UITableViewCellStyleDefault";
static NSString *const fightingGroupCellReuseIdentifier = @"FightingGroupCell";
static NSString *const evaluationCellReuseIdentifier = @"EvaluationCell";
@interface FightGroupMallViewModel ()

@property (nonatomic, strong) FightGroupTitleView *titleView;
@property (nonatomic, strong) FightGroupRulesView *rulesView;
@property (nonatomic, strong) EquippedProductsView *descripView;
@property (nonatomic, strong) EvaluationHeaderView *evaluationHeader;
@property (nonatomic, strong) EvaluationFooterView *evaluationFooter;
@property (nonatomic, strong) FightGroupSectionTitle *sectionOneTitleView;
@property (nonatomic,strong) CommentController * pageController;

@end

@implementation FightGroupMallViewModel

-(void)ddcs_registerClass:(UITableView *)tableView {
    [tableView registerClass:[FightingGroupCell class] forCellReuseIdentifier:fightingGroupCellReuseIdentifier];
    [tableView registerClass:[EvaluationCell class] forCellReuseIdentifier:evaluationCellReuseIdentifier];
}

-(NSInteger)ddcs_numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

-(NSInteger)ddcs_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 4) {
        return 4;
    }else if (section == 2) {
        return 2;
    }
    
    return 1;
}

-(UITableViewCell *)ddcs_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    
    if (section == 0) {
        [cell.contentView addSubview:self.titleView];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }else if (section == 1) {
        [cell.contentView addSubview:self.rulesView];
        [self.rulesView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }else if (section == 2) {
        FightingGroupCell *fightGroupCell = [tableView dequeueReusableCellWithIdentifier:fightingGroupCellReuseIdentifier forIndexPath:indexPath];
        fightGroupCell.nickName = @"不爱你了188";
        fightGroupCell.needPeople = @"还差4人成团";
        fightGroupCell.telNumber = @"152****5626";
        fightGroupCell.overtime = @"剩余 00:28:45 结束";
        
        return fightGroupCell;
    }else if (section == 3) {
        [cell.contentView addSubview:self.descripView];
        [self.descripView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }else if (section == 4) {
        if (row == 0) {
            [cell.contentView addSubview:self.evaluationHeader];
            [self.evaluationHeader mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }else if (row == 3) {
            [cell.contentView addSubview:self.evaluationFooter];
            [self.evaluationFooter mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }else {
            EvaluationCell *evaluationCell =  [tableView dequeueReusableCellWithIdentifier:evaluationCellReuseIdentifier forIndexPath:indexPath];
            
            NSArray *names = @[@"美容师-李荣萍",@"美容师-吴思雨",@"美容师-平平",@"",@"美容师-楚留香"];
            NSArray *images = @[@"touxiang_03",@"touxiang_03",@"touxiang_03"];
            evaluationCell.images = images;
            evaluationCell.beauticianName =  names[indexPath.row];
            return evaluationCell;
        }

    }
    
    return cell;
}
-(UIView *)ddcs_tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 2) {
        return self.sectionOneTitleView;
    }
    return nil;
}
-(CGFloat)ddcs_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return Height_Pt(120);
    }else if (section == 3) {
        
    }
    return Height_Pt(20);
}
-(CGFloat)ddcs_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(FightGroupSectionTitle *)sectionOneTitleView {
    if (!_sectionOneTitleView) {
        _sectionOneTitleView = [[FightGroupSectionTitle alloc] init];
        //_sectionOneTitleView.frame = CGRectMake(0, 0, Width, Height_Pt(120));
        _sectionOneTitleView.title = @"以下小伙伴正在开团,您可以直接参与";
    }
    return _sectionOneTitleView;
}
-(FightGroupTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[FightGroupTitleView alloc] init];
    }
    return _titleView;
}
-(FightGroupRulesView *)rulesView {
    if (!_rulesView) {
        _rulesView = [[FightGroupRulesView alloc] init];
        [_rulesView.checkRulesSignal subscribeNext:^(id  _Nullable x) {
            [self.navigationController pushViewController:[[FightGroupRulesController alloc] init] animated:YES];
        }];
    }
    return _rulesView;
}
-(EquippedProductsView *)descripView {
    if (!_descripView) {
        _descripView = [[EquippedProductsView alloc] init];
    }
    return _descripView;
}

-(EvaluationHeaderView *)evaluationHeader {
    if (!_evaluationHeader) {
        _evaluationHeader = [[EvaluationHeaderView alloc] init];
        Weakify(self);
        [_evaluationHeader.checkAllEvaluationSignal subscribeNext:^(id  _Nullable x) {
            [Wself.navigationController pushViewController:Wself.pageController animated:YES];
        }];
    }
    return _evaluationHeader;
}
-(EvaluationFooterView *)evaluationFooter {
    if (!_evaluationFooter) {
        _evaluationFooter = [[EvaluationFooterView alloc] init];
        Weakify(self);
        [_evaluationFooter.checkAllEvaluationSignal subscribeNext:^(id  _Nullable x) {
            [Wself.navigationController pushViewController:Wself.pageController animated:YES];
        }];
    }
    return _evaluationFooter;
}
-(CommentController *)pageController{
    if (!_pageController) {
        NSArray *viewControllerClasses = @[[EvaluationTableViewController class],[EvaluationTableViewController class]];
        NSArray *titles = @[@"全部评论",@"晒图"];
        _pageController = [[CommentController alloc]initWithViewControllerClasses:viewControllerClasses andTheirTitles:titles];
    }
    return _pageController;
}


@end
