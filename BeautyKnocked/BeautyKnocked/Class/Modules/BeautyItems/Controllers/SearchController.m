//
//  SearchController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/21.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "SearchController.h"
#import "SearchCollectionCell.h"
#import "AdminManager.h"
#import "SectionHeaderView.h"

@interface SearchController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UISearchBar * barField;
@property (nonatomic,strong) UICollectionView * collection;
@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation SearchController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundColor:[UIColor colorWithHexString:@"#FCFCFC"]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [_barField setText:_text];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundColor:ThemeColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self loadNavigationbar];
    [self.view addSubview:self.collection];
}
-(NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc]initWithArray:[AdminManager getSearchArray]];
    }
    return _dataArray;
}

-(UICollectionView*)collection{
    if (!_collection) {
        UICollectionViewFlowLayout *Layout=[[UICollectionViewFlowLayout alloc]init];
        [Layout setMinimumLineSpacing:20];
        [Layout setMinimumInteritemSpacing:(Width-280)/4];
        Layout.estimatedItemSize = CGSizeMake(45, 35);
        Layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        Layout.sectionInset=UIEdgeInsetsMake(10, 20, 10, 20);
        
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, Width, Height-64) collectionViewLayout:Layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.backgroundColor = [UIColor clearColor];
        
        [_collection registerClass:[SearchCollectionCell class] forCellWithReuseIdentifier:@"SearchCollectionCell"];
        
        [_collection registerClass:[SectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionReusableView"];
    }
    return _collection;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
        SectionHeaderView * Head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionReusableView" forIndexPath:indexPath];
        Head.title.text=[_dataArray[indexPath.section] objectForKey:@"title"];
        [Head.button setImage:[UIImage imageNamed:@"lishi-shanchu"] forState:UIControlStateNormal];
        [Head.button addTarget:self action:@selector(cleanDataArray:) forControlEvents:UIControlEventTouchUpInside];
        return Head;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake(Width, 30);
    }else{
        return CGSizeMake(0, 0);
    }
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
    [_barField setSearchFieldBackgroundImage:[AdminManager GetImageWithColor:[UIColor groupTableViewBackgroundColor] andHeight:25] forState:UIControlStateNormal];
    [_barField setDelegate:self];
    [NBar addSubview:_barField];
    
    for (id obj in [_barField subviews]) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id obj2 in [obj subviews]) {
                if ([obj2 isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)obj2;
                    [btn setTitle:@"完成" forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
                }
            }
        }
    }
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    if (![[_dataArray[0] objectForKey:@"data"] containsObject:searchBar.text]  && searchBar.text.length>0 &&![[_dataArray[1] objectForKey:@"data"] containsObject:searchBar.text]) {
        [[_dataArray[1] objectForKey:@"data"] addObject:searchBar.text];
        [AdminManager saveSearchArray:_dataArray];
    }
    [_searchDelegate SearchField:searchBar.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (![[_dataArray[0] objectForKey:@"data"] containsObject:searchBar.text]  && searchBar.text.length>0 &&![[_dataArray[1] objectForKey:@"data"] containsObject:searchBar.text]) {
        [[_dataArray[1] objectForKey:@"data"] addObject:searchBar.text];
        [AdminManager saveSearchArray:_dataArray];
    }
    [_searchDelegate SearchField:searchBar.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText length] > 4) {
        [searchBar setText:[searchText substringToIndex:4]];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"关键词请不要超过4个哦." preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
-(void)cleanDataArray:(UIButton*)btn{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"清空全部历史记录." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[_dataArray[1] objectForKey:@"data"] removeAllObjects];
        [AdminManager saveSearchArray:_dataArray];
        [_collection reloadSections:[NSIndexSet indexSetWithIndex:1]];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *array=[[NSArray alloc]initWithArray:[self.dataArray[section] objectForKey:@"data"]];
    return array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchCollectionCell" forIndexPath:indexPath];
    cell.message.text=[_dataArray[indexPath.section] objectForKey:@"data"][indexPath.item];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _barField.text=[_dataArray[indexPath.section] objectForKey:@"data"][indexPath.item];
    [_searchDelegate SearchField:_barField.text];
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
