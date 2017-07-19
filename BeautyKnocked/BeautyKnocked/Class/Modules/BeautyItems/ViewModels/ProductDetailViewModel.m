//
//  ProductDetailViewModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ProductDetailViewModel.h"
#import "ProductTitlePriceView.h"
#import "ProductIntroduceView.h"
#import "EquippedProductsView.h"
#import "EvaluationCell.h"
#import "EvaluationHeaderView.h"
#import "EvaluationFooterView.h"
#import "EvaluationCell.h"
#import "EvaluationTableViewController.h"


static NSString *const evaluationCellReuseIdentifier = @"EvaluationCell";
static NSString *const cellReuseIdentifier = @"ItemDetailUITableViewCell";
@interface ProductDetailViewModel ()

@property (nonatomic, strong) ProductTitlePriceView *titleView;
@property (nonatomic, strong) ProductIntroduceView *introduceView;
@property (nonatomic, strong) EquippedProductsView *decriptionView;
@property (nonatomic, strong) EvaluationHeaderView *evaluationHeader;
@property (nonatomic, strong) EvaluationFooterView *evaluationFooter;

@end

@implementation ProductDetailViewModel

-(void)configRegisterTableView:(UITableView *)tableView {
    [tableView registerClass:[EvaluationCell class] forCellReuseIdentifier:evaluationCellReuseIdentifier];
}

-(NSUInteger)numberOfSectionInForTableView:(UITableView *)tableView {
    return 4;
}
-(NSUInteger)numberOfRowsAtSection:(NSUInteger)section {
    if (section == 3) {
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
    
    if (section == 0) {
        [cell.contentView addSubview:self.titleView];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }else if (section == 1) {
        [cell.contentView addSubview:self.introduceView];
        [self.introduceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }else if (section == 2) {
        [cell.contentView addSubview:self.decriptionView];
        [self.decriptionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }else if (section == 3) {
        
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


-(ProductTitlePriceView *)titleView {
    if (!_titleView) {
        _titleView = [[ProductTitlePriceView alloc] init];
    }
    return _titleView;
}
-(ProductIntroduceView *)introduceView {
    if (!_introduceView) {
        _introduceView = [[ProductIntroduceView alloc] init];
    }
    return _introduceView;
}
-(EquippedProductsView *)decriptionView {
    if (!_decriptionView) {
        _decriptionView = [[EquippedProductsView alloc] init];
    }
    return _decriptionView;
}
-(EvaluationHeaderView *)evaluationHeader {
    if (!_evaluationHeader) {
        _evaluationHeader = [[EvaluationHeaderView alloc] init];
        @weakify(self);
        [_evaluationHeader.checkAllEvaluationSignal subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            WMPageController *pageController = [self configPageController];
            [self.navigationController pushViewController:pageController animated:YES];
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
            WMPageController *pageController = [self configPageController];
            [self.navigationController pushViewController:pageController animated:YES];
        }];
    }
    return _evaluationFooter;
}

-(WMPageController *)configPageController {
    
    NSArray *viewControllerClasses = @[[EvaluationTableViewController class],[EvaluationTableViewController class]];
    NSArray *titles = @[@"全部评论",@"晒图"];
    WMPageController *pageController = [[WMPageController alloc] initWithViewControllerClasses:viewControllerClasses andTheirTitles:titles];
    pageController.title = @"用户评论";
    pageController.menuViewStyle = WMMenuViewStyleLine;
    pageController.titleSizeSelected = 14;
    pageController.titleSizeNormal = 14;
    //pageController.progressWidth = Width / 2;
    // you can post values
    pageController.values = @[@22, @"Mark"].mutableCopy;
    pageController.keys = @[@"age",@"name"].mutableCopy;
    return pageController;
}

@end
