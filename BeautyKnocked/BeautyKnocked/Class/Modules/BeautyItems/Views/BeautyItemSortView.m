//
//  BeautyItemSortView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/18.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeautyItemSortView.h"
#import "UIButton+Category.h"
#import "PSSortDropMenu.h"
#import "PSRightFilterView.h"
#import "UIImage+Original.h"

@interface BeautyItemSortView ()<PSSortDropMenuDelegate>
@property (nonatomic, strong) UIButton *entireSortBtn;
@property (nonatomic, strong) UIButton *saleSortBtn;
@property (nonatomic, strong) UIButton *filterSortBtn;
@property (nonatomic, strong) PSSortDropMenu *sortMenu;
@property (nonatomic, assign) CGFloat topHeight;
@property (nonatomic, strong) UIView *rightFullView;
@property (nonatomic, strong) PSRightFilterView *filterView;
@property (nonatomic, strong) NSArray * titleArray;
@property BOOL isNope;
@property (nonatomic,strong) UIView * line;
@end

@implementation BeautyItemSortView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self setupInterface];
        [self setupConstraints];
    }
    return self;
}
-(NSArray*)titleArray{
    if (!_titleArray) {
        _titleArray=[[NSArray alloc]initWithObjects:@"综合排序",@"价格从低到高",@"价格从高到低", nil];
    }
    return _titleArray;
}
#pragma mark PSSortDropMenuDelegate
-(void)haveDismiss {
    _entireSortBtn.selected = NO;
}
-(void)didSelectAtRow:(NSInteger)row{
    _saleSortBtn.selected=NO;
    _isNope=_saleSortBtn.isSelected;
    [self selectedAction];
    if (row==0) {
        _entireSortBtn.frame=CGRectMake(Width_Pt(40), 7, 72.5, Height_Pt(60));
    }else{
        _entireSortBtn.frame=CGRectMake(Width_Pt(40), 7, 104.5, Height_Pt(60));
    }
    [_entireSortBtn setTitle:self.titleArray[row] forState:UIControlStateNormal];
    [self.delegate didSelectWithRow:row];
}
#pragma mark Events Handle
-(void)clickedAtIndexButton:(UIButton *)button {
    if (!_isNope) {
        [self selectedAction];
    }else{
        [self DefaultAction];
    }
    if (button == _entireSortBtn) {
        button.selected = !button.selected;
        if (button.isSelected) {
            [self.sortMenu showInView:self.superview];
        }else {
            [self.sortMenu hideView];
        }
    }else{
        if (!button.isSelected) {
            [self.delegate didSelectedButton:button];
        }
        button.selected = YES;
        _entireSortBtn.selected=NO;
        [self DefaultAction];
        _isNope=_saleSortBtn.isSelected;
        _entireSortBtn.frame=CGRectMake(Width_Pt(40), 7, 72.5, Height_Pt(60));
        [self.sortMenu hideView];
        _sortMenu=nil;
    }
}

#pragma mark Initialize
-(void)setupInterface {
    _entireSortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _entireSortBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    _entireSortBtn.frame=CGRectMake(Width_Pt(40), 7, 72.5, Height_Pt(60));
    [_entireSortBtn setImgViewStyle:ButtonImgViewStyleRight imageSize:[UIImage imageNamed:@"paixuzhankai"].size space:5];
    [_entireSortBtn addTarget:self action:@selector(clickedAtIndexButton:) forControlEvents:UIControlEventTouchUpInside];
    _entireSortBtn.tag = 500;
    [_entireSortBtn setTitle:@"综合排序" forState:UIControlStateNormal];
    [self selectedAction];
    [self addSubview:_entireSortBtn];
    
    _saleSortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saleSortBtn.tag = 501;
    _saleSortBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [_saleSortBtn setTitle:@"销量优先" forState:UIControlStateNormal];
    [_saleSortBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_saleSortBtn addTarget:self action:@selector(clickedAtIndexButton:) forControlEvents:UIControlEventTouchUpInside];
    [_saleSortBtn setTitleColor:[UIColor colorWithHexString:@"#E0C070"] forState:UIControlStateSelected];
    [self addSubview:_saleSortBtn];
    
    _filterSortBtn = [self setupCustomBtnWtihImageName:@"shaixuan-weixuanze" selectedImageName:@"shaixuan-xuanzhong" title:@"筛选"];
    [[_filterSortBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [Master showSVProgressHUD:@"筛选功能暂未开放~" withType:ShowSVProgressTypeInfo withShowBlock:nil];
    }];
    [self addSubview:_filterSortBtn];
    
    _line=[[UIView alloc]init];
    _line.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    [self addSubview:_line];
}
-(void)filterButtonClicked {
    //筛选
    _rightFullView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
    _rightFullView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
    [[UIApplication sharedApplication].keyWindow addSubview:_rightFullView];
    
    _filterView = [[PSRightFilterView alloc] initWithFrame:CGRectMake(Width, 0, Width, Height)];
    _filterView.backgroundColor = [UIColor whiteColor];
    _filterView.dataSource = @[@[@"傲氏养生",@"金牌臀疗",@"明星水光",@"无痛脱毛",@"光电疗养",@"组合套餐"],@[@"补水滋润",@"招牌全身",@"明星产品",@"美目明亮",@"露肉必备",@"祛斑紧皱"]];
    
    __weak typeof(_rightFullView) weakRightFullView = _rightFullView;
    [_filterView setFilterBlock:^{
        [weakRightFullView removeFromSuperview];
    }];
    
    [_rightFullView addSubview:_filterView];
    
    [UIView animateWithDuration:0.3f animations:^{
        _filterView.frame = CGRectMake(Width_Pt(281), 0, Width_Pt(801), Height);
    }];
}
-(PSSortDropMenu *)sortMenu {
    if (!_sortMenu) {
        CGRect frame = self.superview.frame;
        _topHeight = Height_Pt(100);
        _sortMenu = [[PSSortDropMenu alloc] initWithFrame:CGRectMake(0, _topHeight, frame.size.width, frame.size.height - _topHeight)];
        _sortMenu.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _sortMenu.dataSource = self.titleArray;
        _sortMenu.top_heeight = _topHeight;
        _sortMenu.delegate = self;
    }
    return _sortMenu;
}
-(void)setupConstraints {
    [_saleSortBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(_entireSortBtn);
        make.height.equalTo(_entireSortBtn);
    }];
    
    [_filterSortBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_saleSortBtn);
        make.height.equalTo(_saleSortBtn);
        make.right.equalTo(self).with.offset( - Width_Pt(40));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-0.5);
        make.height.mas_equalTo(0.5);
    }];
}
-(UIButton *)setupCustomBtnWtihImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIImage *image = [UIImage imageOriginalImageName:imageName];
    UIImage *selectediImage = [UIImage imageOriginalImageName:selectedImageName];
    [button setImage:selectediImage forState:UIControlStateSelected];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImgViewStyle:ButtonImgViewStyleRight imageSize:image.size space:Width_Pt(15.f)];
    return button;
}
-(void)DefaultAction{
    [_entireSortBtn setTitle:@"综合排序" forState:UIControlStateNormal];
    [_entireSortBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_entireSortBtn setImage:[UIImage imageNamed:@"paixu-weixuanze"] forState:UIControlStateNormal];
    [_entireSortBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_entireSortBtn setImage:[UIImage imageNamed:@"paixu-weixuanze1"] forState:UIControlStateSelected];
}
-(void)selectedAction{
    [_entireSortBtn setTitleColor:[UIColor colorWithHexString:@"#E0C070"] forState:UIControlStateNormal];
    [_entireSortBtn setImage:[UIImage imageNamed:@"paixuzhankai"] forState:UIControlStateNormal];
    [_entireSortBtn setTitleColor:[UIColor colorWithHexString:@"#E0C070"] forState:UIControlStateSelected];
    [_entireSortBtn setImage:[UIImage imageNamed:@"paixuheshang"] forState:UIControlStateSelected];
}
@end
