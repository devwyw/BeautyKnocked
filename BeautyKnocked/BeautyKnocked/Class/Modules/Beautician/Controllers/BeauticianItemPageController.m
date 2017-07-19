//
//  BeauticianItemPageController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BeauticianItemPageController.h"
#import "BeauticianItemController.h"
#import "BeauticianPageHeaderView.h"

#define K_HeaderViewHeight Height_Pt(239)

@interface BeauticianItemPageController ()

@property (nonatomic, strong) NSArray *itemCategories;

@property (nonatomic, strong) BeauticianPageHeaderView *headerView;

@end

@implementation BeauticianItemPageController

- (NSArray *)musicCategories {
    if (!_itemCategories) {
        _itemCategories = @[@"美容", @"美甲", @"美发", @"套餐", @"商城", @"养生"];
    }
    return _itemCategories;
}

- (instancetype)init {
    if (self = [super init]) {
        self.titleSizeNormal = Font_Size(40);
        self.titleSizeSelected = Font_Size(40);
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.musicCategories.count;
        self.menuHeight = Height_Pt(100);
        self.viewTop = kNavigationBarHeight + K_HeaderViewHeight;
        self.menuBGColor = [UIColor whiteColor];
        self.titleColorSelected = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        self.titleColorNormal = [UIColor colorWithRed:0.4 green:0.8 blue:0.1 alpha:1.0];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addViews];
    [self addConstraints];
    
}

-(void)addViews {
    [self.view addSubview:self.headerView];
}

-(void)addConstraints {
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(kNavigationBarHeight);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(K_HeaderViewHeight);
    }];
    
    self.viewFrame = CGRectMake(0, _viewTop, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - _viewTop);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.itemCategories.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    BeauticianItemController *vc = [[BeauticianItemController alloc] init];
    return vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.musicCategories[index];
}

-(BeauticianPageHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BeauticianPageHeaderView alloc] init];
        
    }
    return _headerView;
}


@end
