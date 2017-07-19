//
//  BeauticianSortMenuView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/10.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeauticianSortMenuView.h"
#import "UIButton+Category.h"
#import "PSSortDropMenu.h"

@interface BeauticianSortMenuView ()<PSSortDropMenuDelegate>

@property (nonatomic, strong) UIButton *sortingBtn;

@property (nonatomic, strong) UIImageView *lineImgView;

@property (nonatomic, strong) UIButton *filterBtn;

@property (nonatomic, strong) PSSortDropMenu *sortMenu;

@property (nonatomic, assign) CGFloat topHeight;

@end

@implementation BeauticianSortMenuView

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
-(void)setupInterface {
    
    _sortingBtn = [self setupCustomBtnWtihImageName:@"paixu_03" title:@"排序"];
    [_sortingBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sortingBtn];
    
    _lineImgView = [[UIImageView alloc] init];
    [_lineImgView setImage:[UIImage imageNamed:@"xian1_03"]];
    [self addSubview:_lineImgView];
    
    _filterBtn = [self setupCustomBtnWtihImageName:@"shaixuan_03" title:@"筛选"];
    [_filterBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_filterBtn];
   
}

-(void)buttonClicked:(UIButton *)button {
    
    button.selected = !button.selected;
    if (button == _sortingBtn) {
        if (button.selected) {
            [self.sortMenu showInView:self.superview];
        }else {
            [self.sortMenu hideView];
            self.sortMenu = nil;
        }

    }
    
}

-(PSSortDropMenu *)sortMenu {
    if (!_sortMenu) {
        CGRect frame = self.superview.frame;
        _topHeight = 64.0 + Height_Pt(122);
        _sortMenu = [[PSSortDropMenu alloc] initWithFrame:CGRectMake(0, _topHeight, frame.size.width, frame.size.height - _topHeight)];
        _sortMenu.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _sortMenu.dataSource = @[@"默认工号排序",@"评分最高",@"人气最高"];
        _sortMenu.top_heeight = _topHeight;
        _sortMenu.delegate = self;
    }
    return _sortMenu;
}

#pragma mark PSSortDropMenuDelegate

-(void)haveDismiss {
    _sortingBtn.selected = NO;
}

-(void)setupConstraints {
    
    [_lineImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(Height_Pt(24));
        make.bottom.equalTo(self).with.offset( - Height_Pt(24));
        make.width.mas_equalTo(Height_Pt(2));
    }];
    
    [_sortingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lineImgView);
        make.right.equalTo(_lineImgView.mas_left);
        make.left.equalTo(self);
    }];
    
    [_filterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lineImgView);
        make.right.equalTo(self);
        make.left.equalTo(_lineImgView.mas_right);
    }];
}

-(UIButton *)setupCustomBtnWtihImageName:(NSString *)imageName title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:GetPT(35)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIImage *image = [UIImage imageOriginalImageName:imageName];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImgViewStyle:ButtonImgViewStyleRight imageSize:image.size space:GetPT(20.f)];
    return button;
}

@end
