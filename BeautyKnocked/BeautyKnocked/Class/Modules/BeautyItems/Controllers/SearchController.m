//
//  SearchController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/21.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "SearchController.h"

@interface SearchController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UISearchBar * barField;
@property (nonatomic,strong) UICollectionView * collection;

@end

@implementation SearchController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundColor:[UIColor colorWithHexString:@"#FCFCFC"]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [_barField setText:_text];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundColor:ThemeColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self loadNavigationbar];
    // Do any additional setup after loading the view.
}
-(void)loadNavigationbar{
    UINavigationBar *NBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, Width, 64)];
    [NBar setTranslucent:YES];
    [NBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [NBar setShadowImage:[UIImage new]];
    [self.view addSubview:NBar];
    
    _barField = [[UISearchBar alloc]initWithFrame:CGRectMake(10, 25, Width-20, 34)];
    [_barField setPlaceholder:@"关键词"];
    [_barField setTintColor:[UIColor grayColor]];
    [_barField setShowsCancelButton:YES animated:YES];
    [_barField setSearchFieldBackgroundImage:[DocumentsManager GetImageWithColor:[UIColor groupTableViewBackgroundColor] andHeight:25] forState:UIControlStateNormal];
    [_barField setDelegate:self];
    [NBar addSubview:_barField];
    
    for (id obj in [_barField subviews]) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id obj2 in [obj subviews]) {
                if ([obj2 isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)obj2;
                    [btn setTitle:@"完成" forState:UIControlStateNormal];
                }
            }
        }
    }
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [_searchDelegate SearchField:searchBar.text];
    [self dismissViewControllerAnimated:YES completion:nil];
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
