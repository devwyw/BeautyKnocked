//
//  SearchController.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/21.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "SearchController.h"
#import "SearchCollectionCell.h"
#import "SearchReusableView.h"
#import "DocumentsManager.h"

@interface SearchController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UISearchBar * barField;
@property (nonatomic,strong) UICollectionView * collection;
@property (nonatomic,strong) UICollectionView * collections;
@property (nonatomic,strong) NSMutableArray * dataArray;

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
    [self.view addSubview:self.collection];
    [self.view addSubview:self.collections];
}
-(NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc]initWithArray:[DocumentsManager getSearchArray]];
    }
    return _dataArray;
}

-(UICollectionView*)collection{
    if (!_collection) {
        UICollectionViewFlowLayout *Layout=[[UICollectionViewFlowLayout alloc]init];
        [Layout setMinimumLineSpacing:20];
        [Layout setMinimumInteritemSpacing:(Width-280)/5];
        Layout.estimatedItemSize = CGSizeMake(70, 30);
        Layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        Layout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
        [Layout setHeaderReferenceSize:CGSizeMake(Width,30)];
        
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, Width, 200) collectionViewLayout:Layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.backgroundColor = [UIColor clearColor];
        
        [_collection registerClass:[SearchCollectionCell class] forCellWithReuseIdentifier:@"SearchCollectionCell"];
        
        [_collection registerClass:[SearchReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SearchReusableView"];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 199.5, Width, 0.5)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [_collection addSubview:line];
    }
    return _collection;
}
-(UICollectionView*)collections{
    if (!_collections) {
        UICollectionViewFlowLayout *Layout=[[UICollectionViewFlowLayout alloc]init];
        [Layout setMinimumLineSpacing:20];
        [Layout setMinimumInteritemSpacing:(Width-280)/5];
        Layout.estimatedItemSize = CGSizeMake(70, 30);
        Layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        Layout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
        [Layout setHeaderReferenceSize:CGSizeMake(Width,30)];
        
        _collections = [[UICollectionView alloc]initWithFrame:CGRectMake(0,264, Width, Height-264) collectionViewLayout:Layout];
        _collections.delegate = self;
        _collections.dataSource = self;
        _collections.backgroundColor = [UIColor clearColor];
        
        [_collections registerClass:[SearchCollectionCell class] forCellWithReuseIdentifier:@"SearchCollectionCells"];
        
        [_collections registerClass:[SearchReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SearchReusableViews"];
    }
    return _collections;
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
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
                }
            }
        }
    }
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    if (![[_dataArray[1] objectForKey:@"data"] containsObject:searchBar.text]  && searchBar.text.length>0) {
        [[_dataArray[1] objectForKey:@"data"] addObject:searchBar.text];
        [DocumentsManager saveSearchArray:_dataArray];
    }
    [_searchDelegate SearchField:searchBar.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (![[_dataArray[1] objectForKey:@"data"] containsObject:searchBar.text]  && searchBar.text.length>0) {
        [[_dataArray[1] objectForKey:@"data"] addObject:searchBar.text];
        [DocumentsManager saveSearchArray:_dataArray];
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
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (collectionView==_collection) {
        SearchReusableView *HView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SearchReusableView" forIndexPath:indexPath];
        HView.title.text=[self.dataArray[0] objectForKey:@"title"];
        [HView.button setImage:[UIImage imageNamed:@"guanjianci"] forState:UIControlStateNormal];
        return HView;
    }else{
        SearchReusableView *HView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SearchReusableViews" forIndexPath:indexPath];
        HView.title.text=[self.dataArray[1] objectForKey:@"title"];
        [HView.button setImage:[UIImage imageNamed:@"lishi-shanchu"] forState:UIControlStateNormal];
        [HView.button addTarget:self action:@selector(cleanDataArray:) forControlEvents:UIControlEventTouchUpInside];
        return HView;
    }
}
-(void)cleanDataArray:(UIButton*)btn{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"清空全部历史记录." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[_dataArray[1] objectForKey:@"data"] removeAllObjects];
        [DocumentsManager saveSearchArray:_dataArray];
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeZero;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView==_collection) {
        SearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchCollectionCell" forIndexPath:indexPath];
        cell.message.text=[_dataArray[0] objectForKey:@"data"][indexPath.item];
        return cell;
    }else{
        SearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchCollectionCells" forIndexPath:indexPath];
        cell.message.text=[_dataArray[1] objectForKey:@"data"][indexPath.item];
        return cell;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==_collection) {
        NSArray *array=[[NSArray alloc]initWithArray:[self.dataArray[0] objectForKey:@"data"]];
        return array.count;
    }else{
        NSArray *array=[[NSArray alloc]initWithArray:[self.dataArray[1] objectForKey:@"data"]];
        return array.count;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView==_collection) {
        _barField.text=[_dataArray[0] objectForKey:@"data"][indexPath.item];;
        [_searchDelegate SearchField:_barField.text];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        _barField.text=[_dataArray[1] objectForKey:@"data"][indexPath.item];
        [_searchDelegate SearchField:_barField.text];
        [self dismissViewControllerAnimated:YES completion:nil];
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
