//
//  HomePageViewModel.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/12.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "HomePageViewModel.h"
#import <SDCycleScrollView.h>
#import "BKHotItemsView.h"
#import "MenuItemView.h"
#import "FeaturedRecommendationsView.h"
#import "HomePageMuduleCell.h"
#import "HomePageEnjoyTableViewCell.h"
#import "ItemTitleView.h"
#import "HomePageEndView.h"
#import "BeautifulDynamicView.h"
#import "FightGroupMallController.h"
#import "BrandViewController.h"
#import "ShareViewController.h"
#import "LightViewController.h"
#import "NewUserController.h"
#import "NearbyController.h"
#import "SonItemController.h"
#import "ItemDetailController.h"
#import "ProductDetailController.h"
#import "MoneyController.h"
#import "LoginController.h"
#import "BeauticianItemPageController.h"

static NSString *const sectionZeroReuseIdentifier = @"sectionZeroReuseIdentifier";
static NSString *const homePageMuduleCellReuseIdentifier = @"HomePageMuduleCell";
static NSString *const homePageEnjoyTableViewCellReuseIdentifier = @"HomePageEnjoyTableViewCell";

@interface HomePageViewModel ()<SDCycleScrollViewDelegate,MenuItemViewDelegate,HomePageMuduleCellDelegate>

@property (nonatomic, strong) SDCycleScrollView *sdCycleBannerView;
@property (nonatomic, strong) BKHotItemsView *hotItemsView;
@property (nonatomic, strong) MenuItemView *threeItemsMenu;
@property (nonatomic, strong) FeaturedRecommendationsView *recommendView;
@property (nonatomic, strong) ItemTitleView *enjoyTitileView;
@property (nonatomic, strong) HomePageEndView *endView;
@property (nonatomic, strong) BeautifulDynamicView *beautyDynamicView;


@end

@implementation HomePageViewModel
-(NSMutableArray*)imageArray{
    if (!_imageArray) {
        _imageArray=[[NSMutableArray alloc]init];
    }
    return _imageArray;
}
-(NSUInteger)numberOfSectionsInHomePageTableView {
    return 14;
}
-(NSUInteger)numberOfRowsInHomePageTableViewAtSection:(NSUInteger)section {
    return 1;
}
-(UITableViewCell *)configureTableView:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath andObject:(id)Cself{
    NSUInteger section = indexPath.section;
    if (section < 5 || section == 8 || section == 13) {
        UITableViewCell *cell = nil;
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionZeroReuseIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (section == 0) {
            /** 滑动图 */
            [cell.contentView addSubview:self.sdCycleBannerView];
            NSMutableArray *images=[[NSMutableArray alloc]init];
            for (NSDictionary *dict in self.imageArray) {
                [images addObject:[NSString stringWithFormat:@"%@%@",mlqqm,dict[@"path"]]];
            }
            _sdCycleBannerView.imageURLStringsGroup=images;
        }else if (section == 1) {
            /** 品牌甄选 */
            [cell.contentView addSubview:self.threeItemsMenu];
            [self.threeItemsMenu mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }else if (section == 2) {
            /** 热门项目 */
            [cell.contentView addSubview:self.hotItemsView];
            [self.hotItemsView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }else if (section == 3) {
            /** 美丽动态 */
            [cell.contentView addSubview:self.beautyDynamicView];
            [self.beautyDynamicView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }else if (section == 4){
            /** 精选推荐 */
            [cell.contentView addSubview:self.recommendView];
            [self.recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }else if (section == 8){
             /** 感兴趣Line */
            [cell.contentView addSubview:self.enjoyTitileView];
            [self.enjoyTitileView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }else if (section == 13){
            /** 小尾巴 */
            [cell.contentView addSubview:self.endView];
            [self.endView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }
        return cell;

    }else if (section == 5 || section == 6 || section == 7) {
        /** 每日推荐等 */
        HomePageMuduleCell *cell = [tableView dequeueReusableCellWithIdentifier:homePageMuduleCellReuseIdentifier];
        if (!cell) {
            cell = [[HomePageMuduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homePageMuduleCellReuseIdentifier andSection:section];
        }
        [cell setCellDelegate:self];
        return cell;
    }else if (section == 9 || section == 10 || section == 11 || section == 12) {
        /** 感兴趣的课程等 */
        HomePageEnjoyTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[HomePageEnjoyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homePageEnjoyTableViewCellReuseIdentifier];
        }
        return cell;
    }
    return nil;
}
-(CGFloat)congigureCellheightAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;
    if (section == 0) {
        return Height_Pt(453);
    }else if (section == 1) {
        return Height_Pt(231);
    }else if (section == 2) {
        return Height_Pt(480);
    }else if (section == 3) {
        return Height_Pt(132);
    }else if (section == 4) {
        return Height_Pt(400);
    }else if (section == 5 || section == 6 || section == 7) {
        return Height_Pt(523);
    }else if (section == 8) {
        return Height_Pt(102);
    }else if (section == 9 || section == 10 || section == 11 || section == 12) {
        return Height_Pt(320);
    }else if (section == 13) {
        return Height_Pt(182);
    }
    
    return CGFLOAT_MIN;
}
-(CGFloat)configureHeaderHeightAtSection:(NSUInteger )section {
    return CGFLOAT_MIN;
}
-(CGFloat)configureFooterHeightAtSection:(NSUInteger )section {
    if ( section == 0 || section == 12 || section == 13) {
        return CGFLOAT_MIN;
    }else if (section == 8){
        return Height_Pt(5);
    }
    return Height_Pt(12);
}

-(void)configureCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [cell.contentView addSubview:self.sdCycleBannerView];
    }else if (indexPath.section == 1){
        [cell.contentView addSubview:self.hotItemsView];
    }
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"选中:%@",self.imageArray[index]);
}
-(SDCycleScrollView *)sdCycleBannerView{
    if (!_sdCycleBannerView) {
        _sdCycleBannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Width, Height_Pt(450)) delegate:self placeholderImage:[UIImage new]];
        _sdCycleBannerView.autoScrollTimeInterval = 4.f;
    }
    return _sdCycleBannerView;
}

-(MenuItemView *)threeItemsMenu {
    if (!_threeItemsMenu) {
        _threeItemsMenu = [[MenuItemView alloc] initWithFrame:CGRectMake(0, 0, Width, Height_Pt(231))];
        [_threeItemsMenu setMtag:0];
        _threeItemsMenu.imgeViewSize =  CGSizeMake(Width_Pt(120), Height_Pt(120));
        _threeItemsMenu.topDistance = Height_Pt(32);
        _threeItemsMenu.middleDistance = Height_Pt(20);
        _threeItemsMenu.bottomDistance = Height_Pt(20);
        _threeItemsMenu.titleFont = [UIFont systemFontOfSize:Font_Size(42)];
        
        _threeItemsMenu.itemSize = CGSizeMake((Width - Width_Pt(150) * 4) / 3, Width_Pt(231));
        _threeItemsMenu.cellEdgeInsets = UIEdgeInsetsMake(0, Width_Pt(150), 0, Width_Pt(150));
        _threeItemsMenu.interitemSpacing = Width_Pt(150);
        _threeItemsMenu.dataArray = @[@{@"image":@"pinpaizhenxuan_03",@"title":@"品牌甄选"},
                                      @{@"image":@"fenxiangyouli_03",@"title":@"分享有礼"},
                                      @{@"image":@"pintuan_03",@"title":@"优惠拼团"}];
        _threeItemsMenu.delegate =self;
    }
    return _threeItemsMenu;
}

#pragma mark MenuItemViewDelegate
-(void)menuItemViewTitleSelect:(NSUInteger)index andMtag:(NSInteger)tag{
    if (tag==0) {
        switch (index) {
            case 0:
            {/** 品牌甄选 */
                BrandViewController *controller = [[BrandViewController alloc] init];
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
            case 1:
            {
                /** 分享有礼 */
                ShareViewController *controller = [[ShareViewController alloc] init];
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
            case 2:
            {
                /** 优惠拼团 */
                FightGroupMallController *controller = [[FightGroupMallController alloc] init];
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
            default:
                break;
        }
    }else{
        switch (index) {
            case 0:
            case 1:
            case 2:
            {
                /** 上门服务 */
                SonItemController *controller=[[SonItemController alloc]init];
                controller.index=index+3;
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
            case 3:
            {
                /** 光电中心 */
                LightViewController *controller=[[LightViewController alloc]init];
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
            case 4:
            {
                /** 套餐 */
                SonItemController *controller=[[SonItemController alloc]init];
                controller.index=7;
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
            case 5:
            {
                /** 商城 */
                SonItemController *controller=[[SonItemController alloc]init];
                controller.index=6;
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
            case 6:
            {
                /** 会员充值 */
                if ([[Acount shareManager] isSignInWithNavigationController:self.navigationController]) {
                    MoneyController *controller=[[MoneyController alloc]init];
                    controller.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:controller animated:YES];
                }
            }
                break;
            case 7:
            {
                /** 附近技师 */
                NearbyController *controller=[[NearbyController alloc]init];
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
            default:
                break;
        }
    }
}
#pragma mark ##### 每日推荐等#####
-(void)didSection:(NSInteger)section withSelectedItem:(NSString*)itemID{
    if (section==7) {
        ProductDetailController *productDetailController = [[ProductDetailController alloc] init];
        productDetailController.alpha=@"0";
        productDetailController.hidesBottomBarWhenPushed = YES;
        productDetailController.productID=itemID;
        [self.navigationController pushViewController:productDetailController animated:YES];
    }else {
        ItemDetailController *itemDetailController = [[ItemDetailController alloc] init];
        itemDetailController.alpha=@"0";
        itemDetailController.hidesBottomBarWhenPushed = YES;
        itemDetailController.detailID=itemID;
        [self.navigationController pushViewController:itemDetailController animated:YES];
    }
}
-(void)more:(UIButton *)button{
    [Master setTabBarItem:1 withNavigationController:self.navigationController];
}
-(HomePageEndView *)endView {
    if (!_endView) {
        _endView = [[HomePageEndView alloc] init];
    }
    return _endView;
}
-(BKHotItemsView *)hotItemsView {
    if (!_hotItemsView) {
        _hotItemsView = [[BKHotItemsView alloc] initWithFrame:CGRectZero andFself:self];
    }
    return _hotItemsView;
}
-(void)setBeauticianmodel:(BeauticianModel *)beauticianmodel{
    _beauticianmodel=beauticianmodel;
    _recommendView.model=beauticianmodel;
}
-(FeaturedRecommendationsView *)recommendView {
    if (!_recommendView) {
        _recommendView = [[FeaturedRecommendationsView alloc]init];
        _recommendView.model=_beauticianmodel;
        _recommendView.subTag=[RACSubject subject];
        [_recommendView.subTag subscribeNext:^(id  _Nullable x) {
            switch ([x integerValue]) {
                case 0:
                {
                    /** 推荐技师 */
                    BeauticianItemPageController *beauticianPageController = [[BeauticianItemPageController alloc] init];
                    [beauticianPageController setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:beauticianPageController animated:YES];
                }
                    break;
                case 1:
                {
                    /** 新人领券 */
                    if ([[Acount shareManager] isSignInWithNavigationController:self.navigationController]) {
                        NewUserController *controller=[[NewUserController alloc]init];
                        controller.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:controller animated:YES];
                    }
                }
                    break;
                case 2:
                {
                    /** 产品商城 */
                    SonItemController *controller=[[SonItemController alloc]init];
                    controller.index=6;
                    controller.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:controller animated:YES];
                }
                    break;
                default:
                    break;
            }
        }];
    }
    return _recommendView;
}
-(ItemTitleView *)enjoyTitileView {
    if (!_enjoyTitileView) {
        _enjoyTitileView = [[ItemTitleView alloc] init];
        _enjoyTitileView.titleName = @"您可能感兴趣";
        NSString *imageName = @"ganxingqu_03";
        _enjoyTitileView.leftImageName = imageName;
        _enjoyTitileView.rightImageName = imageName;
        _enjoyTitileView.titleFont = [UIFont systemFontOfSize:Font_Size(40)];
    }
    return _enjoyTitileView;
}

-(BeautifulDynamicView *)beautyDynamicView {
    if (!_beautyDynamicView) {
        _beautyDynamicView = [[BeautifulDynamicView alloc] init];
    }
    return _beautyDynamicView;
}

@end
