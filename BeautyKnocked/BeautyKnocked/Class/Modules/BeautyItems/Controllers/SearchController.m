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
    
    UICollectionViewFlowLayout *Layout=[[UICollectionViewFlowLayout alloc]init];
    [Layout setMinimumLineSpacing:20];
    [Layout setMinimumInteritemSpacing:(Width-320)/10];
    Layout.estimatedItemSize = CGSizeMake(60, 30);
    Layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    Layout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    [Layout setHeaderReferenceSize:CGSizeMake(Width,50)];
    
    _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, Width, Height-64) collectionViewLayout:Layout];
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.backgroundColor = [UIColor clearColor];
    [_collection registerClass:[SearchReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Headers"];
    [_collection registerClass:[SearchCollectionCell class] forCellWithReuseIdentifier:@"SearchCell"];
    [self.view addSubview:_collection];
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
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchDelegate SearchField:searchBar.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText length] > 4) {
        [searchBar setText:[searchText substringToIndex:4]];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"关键词请不要超过4个哦." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SearchReusableView * Head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Headers" forIndexPath:indexPath];
        [Head.title setText:@"哈哈哈哈"];
        return Head;
    }
    return nil;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeZero;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchCell" forIndexPath:indexPath];
    cell.message.text=@"哈哈哈啊";
    [cell layoutIfNeeded];
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 30;
        case 1:
            return 30;
        default:
            return 0;
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
