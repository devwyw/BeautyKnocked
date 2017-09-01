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
#import "ServiceView.h"

@interface ItemDetailViewModel ()<RulesMenuViewDlegate>

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

-(NSArray*)listArray{
    if (!_listArray) {
        _listArray=[[NSArray alloc]init];
    }
    return _listArray;
}
-(NSUInteger)numberOfSectionInForTableView:(UITableView *)tableView {
    return 5;
}
-(NSUInteger)numberOfRowsAtSection:(NSUInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 4) {
        if (self.listArray.count<4) {
            return 2+self.listArray.count;
        }else{
            return 5;
        }
    }
    return 1;
}
-(void)setModel:(DetailModel *)model{
    _model=model;
    self.titleView.itemName=model.name;
    self.titleView.serviceTime=model.serviceTime;
    self.titleView.firstPrice=model.vipPrice;
    self.titleView.secondPrice=model.price;
    
    self.serviceView.dataArray=[[NSArray alloc]initWithArray:model.images];
    self.serviceView.reloadData=model.serviceTime;
    
    self.equipedView.titleName=@"配备产品";
    self.equipedView.firstTitle=@"产品名称";
    self.equipedView.firstContent=model.equippedProject;
    self.equipedView.secondTitle=@"产品功效";
    self.equipedView.secondContent=model.effect;
    
    self.descripView.titleName=@"项目说明";
    self.descripView.firstTitle=@"适用人群";
    self.descripView.firstContent=model.forPeople;
    self.descripView.secondTitle=@"注意事项";
    self.descripView.secondContent=model.payMatter;
}
-(void)setPmodel:(PackageInfoModel *)Pmodel{
    _Pmodel=Pmodel;
    self.titleView.itemName=Pmodel.name;
    self.titleView.packPrice=Pmodel.price;
    
    self.serviceView.dataArray=[[NSArray alloc]initWithArray:Pmodel.images];
    self.serviceView.reloadData=@"hidden";
    
    self.equipedView.titleName=@"配备产品";
    self.equipedView.firstTitle=@"产品名称";
    self.equipedView.firstContent=Pmodel.equippedProject;
    self.equipedView.secondTitle=@"产品功效";
    self.equipedView.secondContent=Pmodel.effect;
    
    self.descripView.titleName=@"项目说明";
    self.descripView.firstTitle=@"适用人群";
    self.descripView.firstContent=Pmodel.forPeople;
    self.descripView.secondTitle=@"注意事项";
    self.descripView.secondContent=Pmodel.payMatter;
}
-(UITableViewCell *)configureTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
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
-(ItemTitlePriceView *)titleView {
    if (!_titleView) {
        _titleView = [[ItemTitlePriceView alloc] init];
    }
    return _titleView;
}
-(RulesMenuView *)rulesView {
    if (!_rulesView) {
        _rulesView = [[RulesMenuView alloc] init];
        _rulesView.delegate=self;
    }
    return _rulesView;
}
-(void)PushServiceView{
    ServiceView *paysheet=[[ServiceView alloc]initWithFrame:CGRectMake(0, 0, Width, Height_Pt(200*5))];
    [Master PopSheetView:paysheet];
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
