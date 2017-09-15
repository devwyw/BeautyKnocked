//
//  BlankShopCarView.m
//  BeautyKnocked
//
//  Created by Mac on 2017/9/14.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "BlankShopCarView.h"
#import "HomePageItemCollectionViewCell.h"

@interface BlankShopCarView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) NSArray * dataArray;
@end

@implementation BlankShopCarView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(NSArray*)dataArray{
    if (!_dataArray) {
        _dataArray=[[NSArray alloc]init];
    }
    return _dataArray;
}
-(void)setData:(NSArray *)data{
    _dataArray=[[NSArray alloc]initWithArray:data];
    [_collectionView reloadData];
}
-(void)initializeViews {
    _image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tishigouwuche"]];
    [self addSubview:_image];
    
    _title=[[UILabel alloc]init];
    _title.text=@"您的购物车还没有任何宝贝~";
    _title.font=[UIFont systemFontOfSize:Font_Size(40)];
    [self addSubview:_title];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((Width-Width_Pt(180))/3, Height_Pt(440));
    layout.minimumInteritemSpacing = Width_Pt(45);
    layout.minimumLineSpacing = Height_Pt(40);
    
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.scrollEnabled=NO;
    _collectionView.backgroundColor=[UIColor clearColor];
    _collectionView.contentInset=UIEdgeInsetsMake(Height_Pt(40), Width_Pt(45), Height_Pt(40), Width_Pt(45));
    [_collectionView registerClass:[HomePageItemCollectionViewCell class] forCellWithReuseIdentifier:@"HomePageItemCollectionViewCell"];
    [self addSubview:_collectionView];
}
-(void)addConstraints {
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(Height_Pt(110));
        make.centerX.equalTo(self);
        make.size.sizeOffset(CGSizeMake(Width_Pt(260), Height_Pt(260)));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_image.mas_bottom).offset(Height_Pt(60));
        make.centerX.equalTo(self);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).offset(Height_Pt(110));
        make.left.bottom.right.equalTo(self);
    }];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomePageItemCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageItemCollectionViewCell" forIndexPath:indexPath];
    cell.model=[ItemClassModel mj_objectWithKeyValues:self.dataArray[indexPath.item]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [_subModel sendNext:_dataArray[indexPath.item]];
}

@end
