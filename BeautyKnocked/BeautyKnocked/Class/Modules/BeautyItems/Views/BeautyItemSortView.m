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


@end

@implementation BeautyItemSortView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInterface];
        [self setupConstraints];
    }
    return self;
}

-(void)didSelectAtRow:(NSUInteger)row{
    
}
#pragma mark PSSortDropMenuDelegate

-(void)haveDismiss {
    _entireSortBtn.selected = NO;
}



-(void)filterButtonClicked {
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
#pragma mark Events Handle

-(void)clickedAtIndexButton:(UIButton *)button {
    
    button.selected = !button.selected;
    
    if (button == _entireSortBtn) {
        if (button.selected) {
            [self.sortMenu showInView:self.superview];
        }else {
            [self.sortMenu hideView];
            self.sortMenu = nil;
        }
        
    }
}

#pragma mark Initialize
-(void)setupInterface {
    
    _entireSortBtn = [self setupCustomBtnWtihImageName:@"paixu-weixuanze" selectedImageName:@"paixuheshang" title:@"综合排序"];
    [_entireSortBtn setTitleColor:[UIColor colorWithHexString:@"#E0C070"] forState:UIControlStateSelected];
    [_entireSortBtn addTarget:self action:@selector(clickedAtIndexButton:) forControlEvents:UIControlEventTouchUpInside];
    _entireSortBtn.tag = 500;
    [self addSubview:_entireSortBtn];
    
    
    _saleSortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saleSortBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [_saleSortBtn setTitle:@"销量优先" forState:UIControlStateNormal];
    [_saleSortBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_saleSortBtn addTarget:self action:@selector(clickedAtIndexButton:) forControlEvents:UIControlEventTouchUpInside];
    [_saleSortBtn setTitleColor:[UIColor colorWithHexString:@"#E0C070"] forState:UIControlStateSelected];
    [self addSubview:_saleSortBtn];
    
    _filterSortBtn = [self setupCustomBtnWtihImageName:@"shaixuan-weixuanze" selectedImageName:@"shaixuan-xuanzhong" title:@"筛选"];
    [_filterSortBtn addTarget:self action:@selector(filterButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_filterSortBtn];
    
    
}

-(PSSortDropMenu *)sortMenu {
    if (!_sortMenu) {
        CGRect frame = self.superview.frame;
        _topHeight = Height_Pt(100);
        _sortMenu = [[PSSortDropMenu alloc] initWithFrame:CGRectMake(0, _topHeight, frame.size.width, frame.size.height - _topHeight - 49)];
        _sortMenu.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _sortMenu.dataSource = @[@"综合排序",@"价格从高到低",@"价格从低到高"];
        _sortMenu.top_heeight = _topHeight;
        _sortMenu.delegate = self;
    }
    return _sortMenu;
}

-(void)setupConstraints {
    
    [_entireSortBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(Width_Pt(40));
        //make.width.mas_equalTo(Width_Pt(196));
        make.height.mas_equalTo(Height_Pt(60));
    }];
    
    [_saleSortBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        //make.width.mas_equalTo(Width_Pt(150));
        make.height.equalTo(_entireSortBtn);
    }];
    
    [_filterSortBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.equalTo(_entireSortBtn);
        //make.width.mas_equalTo(Width_Pt(128));
        make.right.equalTo(self).with.offset( - Width_Pt(40));
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


@end
