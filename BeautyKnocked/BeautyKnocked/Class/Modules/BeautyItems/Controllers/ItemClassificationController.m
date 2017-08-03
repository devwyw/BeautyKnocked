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
#import <SVProgressHUD.h>
#import <SDCycleScrollView.h>
#import "UIButton+Category.h"
#import <PYSearchViewController.h>
#import "CarItem.h"

@interface ItemClassificationController () <UIGestureRecognizerDelegate,SDCycleScrollViewDelegate,UITextFieldDelegate,PYSearchViewControllerDelegate>

@property (nonatomic, strong) NSArray *itemCategories;
@property (nonatomic, strong) WMPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, strong) SDCycleScrollView *classBannerView;
@property (nonatomic, strong) CarItem * carItem;
@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic,   strong) UIButton * item;

@end

@implementation ItemClassificationController

- (NSArray *)musicCategories {
    if (!_itemCategories) {
        _itemCategories = @[@"推荐",@"特惠",@"美容", @"美甲", @"美发", @"套餐", @"商城", @"养生"];
    }
    return _itemCategories;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.navBarBgAlpha = @"1.0";
    _carItem.count=100;
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
        [SVProgressHUD showInfoWithStatus:@"目前只提供南昌地区的服务"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD dismissWithDelay:1.85];
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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    return NO;
}
- (instancetype)init {
    if (self = [super init]) {
        self.titleSizeNormal = Font_Size(38);
        self.titleSizeSelected = Font_Size(40);
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.musicCategories.count;
        self.menuHeight = Height_Pt(100);
        self.viewTop = kNavigationBarHeight + kWMHeaderViewHeight;
        self.menuBGColor = [UIColor whiteColor];
        self.titleColorSelected = [UIColor colorWithHexString:@"#ECBD4E"];
        self.titleColorNormal = [UIColor blackColor];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeaderView];
    // Do any additional setup after loading the view.
    
    self.panGesture = [[WMPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOnView:)];
    [self.view addGestureRecognizer:self.panGesture];
    [self.view addSubview:self.classBannerView];
    [self setViewTop:kNavigationBarHeight];
    
    /** 购物车Item */
    {
        _carItem=[[CarItem alloc]initWithOriginY:Height-111];
        [_carItem.pushCar subscribeNext:^(id  _Nullable x) {
            NSLog(@"购物车");
        }];
        [self.view addSubview:_carItem];
    }
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
            NSLog(@"velocity: %lf", velocity.y);
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
    return self.itemCategories.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    ItemListBaseController *vc = [[ItemListBaseController alloc] init];
    return vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.musicCategories[index];
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


@end
