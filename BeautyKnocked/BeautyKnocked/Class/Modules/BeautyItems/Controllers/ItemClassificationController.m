//
//  ItemClassificationController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/18.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ItemClassificationController.h"
#import "ItemListBaseController.h"
#import "WMPanGestureRecognizer.h"
#import <SDCycleScrollView.h>
#import "UIButton+Category.h"
#import <PYSearchViewController.h>
#import "UIImage+Original.h"

@interface ItemClassificationController () <UIGestureRecognizerDelegate,SDCycleScrollViewDelegate,UITextFieldDelegate,PYSearchViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) WMPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, strong) SDCycleScrollView *classBannerView;
@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic, strong) UIButton * item;

@property (nonatomic, assign) CGFloat viewTop;
@end
static CGFloat const kWMHeaderViewHeight = 124;
static CGFloat const kNavigationBarHeight = 64;

@implementation ItemClassificationController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (NSMutableArray *)itemArray {//@[@"推荐",@"特惠",@"特价",@"美甲",@"美容",@"美发",@"商城",@"套餐"]
    if (!_itemArray) {
        _itemArray = [[NSMutableArray alloc]init];
    }
    return _itemArray;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"1.0";
    [_item setHidden:NO];
    [_searchBar setHidden:_item.isHidden];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_item setHidden:YES];
    [_searchBar setHidden:_item.isHidden];
}
-(void)setHeaderView{
    /** 顶部控件 */
    _item = [[UIButton alloc]initWithFrame:CGRectMake(15, 2, 60, 40)];
    [_item setTitle:@"南昌" forState:UIControlStateNormal];
    [_item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_item setImage:[UIImage imageNamed:@"shouyelocation"] forState:UIControlStateNormal];
    [_item setImgViewStyle:ButtonImgViewStyleRight imageSize:[UIImage imageNamed:@"shouyelocation"].size space:5];
    [[_item rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [Master showSVProgressHUD:@"目前只提供南昌地区的服务" withType:ShowSVProgressTypeInfo withShowBlock:nil];
    }];
    [self.navigationController.navigationBar addSubview:_item];

    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(85, 5, Width-100, 34)];
    [_searchBar setSearchFieldBackgroundImage:[UIImage GetImageWithColor:[UIColor colorWithHexString:@"#D2AE55"] andAlpha:1 andHeight:25] forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:_searchBar];
    UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
    searchField.textColor = [UIColor whiteColor];
    [searchField makeCornerRadius:3];
    [searchField setTextAlignment:NSTextAlignmentCenter];
    [searchField setClearButtonMode:UITextFieldViewModeNever];
    [searchField setDelegate:self];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fenlei-sousou"]];
    iconView.frame = CGRectMake(0, 0, 13 , 13);
    searchField.leftView = iconView;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField{
    [textField resignFirstResponder];
    /** 搜索栏 */
    NSArray *hotSeaches = @[@"美白", @"补水", @"背部", @"清洁", @"化妆水", @"精油", @"按摩", @"养肤系列", @"长效系列", @"水光疗养"];
    PYSearchViewController *controller = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"关键词" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        [searchViewController dismissViewControllerAnimated:YES completion:nil];
        _searchBar.text=searchText;
    }];
    {
        /** 配置 */
        controller.delegate=self;
        controller.searchBar.text=_searchBar.text;
        controller.hotSearchTitle=@"关键词搜索";
        controller.searchHistoryHeader.text=@"历史搜索记录";
        controller.view.backgroundColor=[UIColor colorWithHexString:@"#F0F0F0"];
        controller.searchBarBackgroundColor=controller.view.backgroundColor;
        controller.searchBar.tintColor = [UIColor lightGrayColor];
        controller.cancelButton.tintColor=[UIColor blackColor];
        controller.hotSearchStyle = PYHotSearchStyleDefault;
        controller.searchHistoryStyle = PYSearchHistoryStyleNormalTag;
    }
    
    UINavigationController *NewNavigation=[[UINavigationController alloc]initWithRootViewController:controller];
    [NewNavigation.navigationBar setBackgroundImage:[UIImage GetImageWithColor:[UIColor colorWithHexString:@"#FCFCFC"] andAlpha:1 andHeight:64] forBarMetrics:UIBarMetricsDefault];
    NewNavigation.navigationBar.shadowImage=[UIImage new];
    NewNavigation.hidesBottomBarWhenPushed = YES;
    NewNavigation.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    [self presentViewController:NewNavigation animated:YES completion:nil];
    return NO;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleSizeNormal = Font_Size(38);
        self.titleSizeSelected = Font_Size(40);
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuHeight = Height_Pt(100);
        self.viewTop = kNavigationBarHeight + kWMHeaderViewHeight;
        self.menuBGColor = [UIColor whiteColor];
        self.titleColorSelected = [UIColor colorWithHexString:@"#ECBD4E"];
        self.titleColorNormal = [UIColor blackColor];
        self.menuViewBottomSpace=0.6;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeaderView];
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F2F2F2"];
    // Do any additional setup after loading the view.
    self.panGesture = [[WMPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOnView:)];
    [self.view addGestureRecognizer:self.panGesture];
    [self.view addSubview:self.classBannerView];
    [self setViewTop:kNavigationBarHeight];
    [self loadHttpData];
}
- (void)panOnView:(WMPanGestureRecognizer *)recognizer {
    CGPoint currentPoint = [recognizer locationInView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.lastPoint = currentPoint;
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat targetPoint = velocity.y < 0 ? kNavigationBarHeight : kNavigationBarHeight + kWMHeaderViewHeight;
        NSTimeInterval duration = fabs((targetPoint - self.viewTop) / velocity.y);
        
        if (fabs(velocity.y) * 1.0 > fabs(targetPoint - self.viewTop)) {
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                // code in here I do it by cover headerView
                // if you want change it,you can code here
                self.viewTop = targetPoint;
            } completion:nil];
            return;
        }
    }
    CGFloat yChange = currentPoint.y - self.lastPoint.y;
    self.viewTop += yChange;
    self.lastPoint = currentPoint;
}

// MARK: ChangeViewFrame (Animatable)
- (void)setViewTop:(CGFloat)viewTop {
    _viewTop = viewTop;
    if (_viewTop <= kNavigationBarHeight) {
        _viewTop = kNavigationBarHeight;
    }
    if (_viewTop > kWMHeaderViewHeight + kNavigationBarHeight) {
        _viewTop = kWMHeaderViewHeight + kNavigationBarHeight;
    }
    self.viewFrame = CGRectMake(0, _viewTop, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - _viewTop);
    self.classBannerView.frame = CGRectMake(0, _viewTop - kWMHeaderViewHeight, [UIScreen mainScreen].bounds.size.width,  kWMHeaderViewHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.itemArray.count;
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    ItemListBaseController *controller = [[ItemListBaseController alloc] init];
    controller.model=[TitleClassModel mj_objectWithKeyValues:self.itemArray[index]];
    return controller;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.itemArray[index][@"name"];
}
-(CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index{
    return [UIScreen mainScreen].bounds.size.width / self.itemArray.count;
}
-(SDCycleScrollView *)classBannerView {
    if (!_classBannerView) {
        CGRect rect = CGRectMake(0, kNavigationBarHeight, [UIScreen mainScreen].bounds.size.width,  kWMHeaderViewHeight);
        _classBannerView = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:self placeholderImage:nil];
        _classBannerView.autoScrollTimeInterval = 4.f;
        _classBannerView.localizationImageNamesGroup = @[@"banner1.jpg",@"banner1.jpg",@"banner1.jpg"];
    }
    return _classBannerView;
}
-(void)loadHttpData{
    [Master HttpPostRequestByParams:nil url:mlqqm serviceCode:bqlb Success:^(id json) {
        for (NSDictionary *dict in json[@"info"]) {
            [self.itemArray addObject:dict];
        }
        [self reloadData];
        } Failure:nil andNavigation:self.navigationController];
}

@end
