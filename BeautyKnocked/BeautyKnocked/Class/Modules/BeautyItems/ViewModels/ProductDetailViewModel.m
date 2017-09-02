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
#import "EvaluationTableViewController.h"
#import "CommentController.h"

static NSString *const evaluationCellReuseIdentifier = @"EvaluationCell";
static NSString *const cellReuseIdentifier = @"ItemDetailUITableViewCell";
@interface ProductDetailViewModel ()

@property (nonatomic, strong) ProductTitlePriceView *titleView;
@property (nonatomic, strong) ProductIntroduceView *introduceView;
@property (nonatomic, strong) EquippedProductsView *decriptionView;
@property (nonatomic, strong) EvaluationHeaderView *evaluationHeader;
@property (nonatomic, strong) EvaluationFooterView *evaluationFooter;
@property (nonatomic,strong) CommentController * pageController;

@end

@implementation ProductDetailViewModel
-(NSArray*)listArray{
    if (!_listArray) {
        _listArray=[[NSArray alloc]init];
    }
    return _listArray;
}
-(NSUInteger)numberOfSectionInForTableView:(UITableView *)tableView {
    return 4;
}
-(NSUInteger)numberOfRowsAtSection:(NSUInteger)section {
    if (section == 3) {
        if (self.listArray.count<4) {
            return 2+self.listArray.count;
        }else{
            return 5;
        }
    }
    return 1;
}
-(void)setModel:(ProductModel *)model{
    _model=model;
    self.titleView.title=model.name;
    self.titleView.price=model.price;

    self.introduceView.capacitys=model.capacity;
    self.introduceView.address=model.address;
    self.introduceView.dateLength=model.dateLength;
    self.introduceView.effects=model.effect;
    
    self.decriptionView.titleName=@"产品说明";
    self.decriptionView.firstTitle=@"适用人群";
    self.decriptionView.secondTitle=@"使用方法";
    self.decriptionView.firstContent=model.forPeople;
    self.decriptionView.secondContent=model.useMethod;
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
        NSInteger foot=1;
        {
            /** 查看全部评论 */
            if (self.listArray.count<4) {
                foot=foot+self.listArray.count;
            }else{
                foot=foot+3;
            }
        }
        if (row == 0) {
            [cell.contentView addSubview:self.evaluationHeader];
            self.evaluationHeader.listCount=[NSString stringWithFormat:@"%ld",self.listArray.count];
            [self.evaluationHeader mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }else if (row == foot) {
            [cell.contentView addSubview:self.evaluationFooter];
            [self.evaluationFooter mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }else {
            CommentModel *model=[CommentModel mj_objectWithKeyValues:self.listArray[indexPath.row-1]];
            EvaluationCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[EvaluationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EvaluationCell"];
            }
            cell.model=model;
            return cell;
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
        _pageController = [[CommentController alloc]init];
        _pageController.listArray=[[NSArray alloc]initWithArray:self.listArray];
    }
    return _pageController;
}

@end
