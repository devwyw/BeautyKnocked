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
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) BeauticianPageHeaderView *headerView;
@property (nonatomic, assign) CGFloat viewTop;
@end
static CGFloat const kNavigationBarHeight = 64.f;
@implementation BeauticianItemPageController

- (NSMutableArray *)itemArray {//@[@"推荐",@"特惠",@"特价",@"美甲",@"美容",@"美发",@"商城",@"套餐"]
    if (!_itemArray) {
        _itemArray = [[NSMutableArray alloc]init];
    }
    return _itemArray;
}
- (instancetype)init {
    if (self = [super init]) {
        self.titleSizeNormal = Font_Size(38);
        self.titleSizeSelected = Font_Size(40);
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuHeight = Height_Pt(100);
        self.viewTop = kNavigationBarHeight + K_HeaderViewHeight;
        self.menuBGColor = [UIColor whiteColor];
        self.titleColorSelected = [UIColor colorWithHexString:@"#ECBD4E"];
        self.titleColorNormal = [UIColor blackColor];
        self.menuViewBottomSpace=0.6;
    }
    return self;
}
-(void)setModel:(BeauticianModel *)model{
    _model=model;
    self.headerView.model=model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"技师详情";
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F2F2F2"];
    [self addConstraints];
    [self loadHttpData];
}
-(void)addConstraints {
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(kNavigationBarHeight);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(K_HeaderViewHeight);
    }];
    
    self.viewFrame = CGRectMake(0, _viewTop, Width, Height - _viewTop);
}
#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.itemArray.count;
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    BeauticianItemController *vc = [[BeauticianItemController alloc] init];
    vc.model=[TitleClassModel mj_objectWithKeyValues:self.itemArray[index]];
    vc.Bid=_model.id;
    return vc;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.itemArray[index][@"name"];
}
-(CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index{
    return Width / self.itemArray.count;
}
-(BeauticianPageHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BeauticianPageHeaderView alloc] init];
    }
    return _headerView;
}
-(void)loadHttpData{
    Weakify(self);
    [Master HttpPostRequestByParams:nil url:mlqqm serviceCode:bqlb Success:^(id json) {
        _itemArray=[[NSMutableArray alloc]initWithArray:json[@"info"]];
        [Wself reloadData];
    } Failure:nil andNavigation:self.navigationController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
