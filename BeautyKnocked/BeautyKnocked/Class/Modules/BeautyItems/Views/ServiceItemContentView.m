//
//  ServiceItemContentView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ServiceItemContentView.h"
#import "ServiceContentCollectionViewCell.h"

static NSString *const reuseIdentifier = @"ServiceContentCollectionViewCell";
@interface ServiceItemContentView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation ServiceItemContentView

-(instancetype)initWithFrame:(CGRect)frame{
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
-(void)setReloadData:(NSString *)reloadData{
    _titleLabel.text = [NSString stringWithFormat:@"服务内容(%ld)",self.dataArray.count];
    if (![reloadData isEqualToString:@"hidden"]) {
        _timeLabel.text = [NSString stringWithFormat:@"约%@分钟",reloadData];
    }
    [_collectionView reloadData];
}
#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ServiceContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.serialNumber = indexPath.item+1;
    cell.model=self.dataArray[indexPath.item];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(Width_Pt(256), Height_Pt(348));
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return Width_Pt(40);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return Height_Pt(40);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(Height_Pt(20), Width_Pt(62), 0, 0);
}
-(void)initializeViews {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor lightGrayColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc]  initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[ServiceContentCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    _timeLabel.textColor = [UIColor lightGrayColor];
    
    [self addSubview:_titleLabel];
    [self addSubview:_line];
    [self addSubview:_collectionView];
    [self addSubview:_timeLabel];
}

-(void)addConstraints {
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(Width_Pt(62));
        make.top.equalTo(self).with.offset(Height_Pt(30));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(30));
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(self).with.offset( - Width_Pt(59));
        make.height.mas_equalTo(0.5);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom);
        make.left.and.right.and.bottom.equalTo(self);
        make.height.mas_equalTo(Height_Pt(370));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLabel);
        make.right.equalTo(self).with.offset( - Width_Pt(59));
    }];
}

@end
