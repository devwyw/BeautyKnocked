//
//  ItemClassificationController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/18.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ItemClassificationController.h"
#import "WMPanGestureRecognizer.h"
#import "ItemListBaseController.h"
#import <SDCycleScrollView.h>

@interface ItemClassificationController () <UIGestureRecognizerDelegate,SDCycleScrollViewDelegate>
@property (nonatomic, strong) NSArray *itemCategories;
@property (nonatomic, strong) WMPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, strong) SDCycleScrollView *classBannerView;

@end

@implementation ItemClassificationController

- (NSArray *)musicCategories {
    if (!_itemCategories) {
        _itemCategories = @[@"推荐",@"特惠",@"美容", @"美甲", @"美发", @"套餐", @"商城", @"养生"];
    }
    return _itemCategories;
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
        self.titleColorSelected = [UIColor brownColor];
        self.titleColorNormal = [UIColor grayColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.panGesture = [[WMPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOnView:)];
    [self.view addGestureRecognizer:self.panGesture];

    [self.view addSubview:self.classBannerView];
    //[self.view sendSubviewToBack:self.classBannerView];
}

- (void)panOnView:(WMPanGestureRecognizer *)recognizer {
    NSLog(@"pannnnnning received..");
    
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
