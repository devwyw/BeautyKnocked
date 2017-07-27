//
//  ItemDetailViewModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ItemDetailViewModel.h"
#import "ItemTitlePriceView.h"
#import "RulesMenuView.h"
#import "ServiceItemContentView.h"
#import "EquippedProductsView.h"
#import "EvaluationHeaderView.h"
#import "EvaluationFooterView.h"
#import "EvaluationCell.h"
#import "EvaluationTableViewController.h"
#import "CommentController.h"

static NSString *const evaluationCellReuseIdentifier = @"EvaluationCell";
static NSString *const cellReuseIdentifier = @"ItemDetailUITableViewCell";

@interface ItemDetailViewModel ()

@property (nonatomic, strong) ItemTitlePriceView *titleView;
@property (nonatomic, strong) RulesMenuView *rulesView;
@property (nonatomic, strong) ServiceItemContentView *serviceView;
@property (nonatomic, strong) EquippedProductsView *equipedView;
@property (nonatomic, strong) EquippedProductsView *descripView;
@property (nonatomic, strong) EvaluationHeaderView *evaluationHeader;
@property (nonatomic, strong) EvaluationFooterView *evaluationFooter;
@property (nonatomic, strong) CommentController * pageController;

@end

@implementation ItemDetailViewModel

-(void)configRegisterTableView:(UITableView *)tableView {
    [tableView registerClass:[EvaluationCell class] forCellReuseIdentifier:evaluationCellReuseIdentifier];
}

-(NSUInteger)numberOfSectionInForTableView:(UITableView *)tableView {
    return 5;
}
-(NSUInteger)numberOfRowsAtSection:(NSUInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 4) {
        return 4;
    }
    return 1;
}
-(UITableViewCell *)configureTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    
    if (section ==0) {
        if (row == 0) {
            [cell.contentView addSubview:self.titleView];
            [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }else if (row == 1) {
            [cell.contentView addSubview:self.rulesView];
            
            [self.rulesView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }
    }else if (section == 1) {
        [cell.contentView addSubview:self.serviceView];
        [self.serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }else if (section == 2) {
        [cell.contentView addSubview:self.equipedView];
        [self.equipedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
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



-(ItemTitlePriceView *)titleView {
    if (!_titleView) {
        _titleView = [[ItemTitlePriceView alloc] init];
    }
    return _titleView;
}
-(RulesMenuView *)rulesView {
    if (!_rulesView) {
        _rulesView = [[RulesMenuView alloc] init];
    }
    return _rulesView;
}
-(ServiceItemContentView *)serviceView {
    if (!_serviceView) {
        _serviceView = [[ServiceItemContentView alloc] init];
    }
    return _serviceView;
}
-(EquippedProductsView *)equipedView {
    if (!_equipedView) {
        _equipedView = [[EquippedProductsView alloc] init];
    }
    return _equipedView;
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
        @weakify(self);
        [_evaluationHeader.checkAllEvaluationSignal subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.navigationController pushViewController:self.pageController animated:YES];
        }];
    }
    return _evaluationHeader;
}
-(EvaluationFooterView *)evaluationFooter {
    if (!_evaluationFooter) {
        _evaluationFooter = [[EvaluationFooterView alloc] init];
        @weakify(self);
        [_evaluationFooter.checkAllEvaluationSignal subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.navigationController pushViewController:self.pageController animated:YES];
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
