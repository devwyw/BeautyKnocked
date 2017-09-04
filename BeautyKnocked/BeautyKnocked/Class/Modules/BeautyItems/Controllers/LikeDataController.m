//
//  LikeDataController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/9/4.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "LikeDataController.h"
#import <PYSearchViewController.h>
#import "UIImage+Original.h"
#import "LikeModel.h"
#import "ItemDetailController.h"
#import "ProductDetailController.h"

@interface LikeDataController ()<PYSearchViewControllerDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UISearchBar * searchBar;
@property (nonatomic,strong) UITableView * tableview;
@end

@implementation LikeDataController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.BarAlpha = @"1";
    [_searchBar setHidden:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_searchBar setHidden:YES];
}
-(NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(60, 5, Width-100, 34)];
    [_searchBar setSearchFieldBackgroundImage:[UIImage GetImageWithColor:[UIColor colorWithHexString:@"#D2AE55"] andAlpha:1 andHeight:25] forState:UIControlStateNormal];
    _searchBar.text=_data;
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
    // Do any additional setup after loading the view.
    
    _tableview=[[UITableView alloc]init];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.rowHeight=Height_Pt(120);
    _tableview.backgroundColor=[UIColor clearColor];
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField{
    [textField resignFirstResponder];
    Weakify(self);
    NSArray *hotSeaches = @[@"美白", @"补水", @"背部", @"清洁", @"化妆水", @"精油", @"按摩", @"养肤系列", @"长效系列", @"水光疗养"];
    PYSearchViewController *controller = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"关键词" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        _searchBar.text=searchText;
        [searchViewController dismissViewControllerAnimated:YES completion:^{
            if (!isStringEmpty(searchText)) {
                [Master HttpPostRequestByParams:@{@"name":searchText} url:mlqqm serviceCode:mhss Success:^(id json) {
                    [_dataArray removeAllObjects];
                    _dataArray=[[NSMutableArray alloc]initWithArray:json[@"info"]];
                    [_tableview reloadData];
                } Failure:nil andNavigation:Wself.navigationController];
            }
        }];
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
    NewNavigation.StatusDefaultBar=@"1";
    [self presentViewController:NewNavigation animated:YES completion:nil];
    return NO;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LikeModel *model=[LikeModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text=model.name;
    cell.textLabel.font=[UIFont systemFontOfSize:Font_Size(45)];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LikeModel *model=[LikeModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    switch ([model.commType integerValue]) {
        case 1:
        {
            ItemDetailController *itemDetailController = [[ItemDetailController alloc] init];
            itemDetailController.alpha=@"0";
            itemDetailController.hidesBottomBarWhenPushed = YES;
            itemDetailController.detailID=model.id;
            [self.navigationController pushViewController:itemDetailController animated:YES];
        }
            break;
        case 2:
        {
            ItemDetailController *itemDetailController = [[ItemDetailController alloc] init];
            itemDetailController.alpha=@"0";
            itemDetailController.hidesBottomBarWhenPushed = YES;
            itemDetailController.detailID=model.id;
            itemDetailController.projectId=@"1";
            [self.navigationController pushViewController:itemDetailController animated:YES];
        }
            break;
        default:
        {
            ProductDetailController *productDetailController = [[ProductDetailController alloc] init];
            productDetailController.alpha=@"0";
            productDetailController.hidesBottomBarWhenPushed = YES;
            productDetailController.productID=model.id;
            [self.navigationController pushViewController:productDetailController animated:YES];
        }
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
