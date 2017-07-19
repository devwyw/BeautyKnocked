//
//  HomePageMuduleCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "HomePageMuduleCell.h"
#import "HomePageItemCollectionViewCell.h"
#import "UIButton+Category.h"

static NSString *const reuseIdentifier = @"HomePageItemCollectionViewCell";

@interface HomePageMuduleCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger section;

@end

@implementation HomePageMuduleCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andSection:(NSInteger)section{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _section=section;
        [self setupInterface];
        [self setupConstraints];
    }
    return self;
}

-(void)setupInterface {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    switch (_section) {
        case 5:
            _titleLabel.text = @"每日推荐";
            break;
        case 6:
            _titleLabel.text = @"美丽特惠";
            break;
        case 7:
            _titleLabel.text = @"特价商品";
            break;
        default:
            break;
    }
    [self.contentView addSubview:_titleLabel];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_line];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [_moreBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [_moreBtn setTag:_section];
    [_moreBtn addTarget:self action:@selector(moreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moreBtn];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[HomePageItemCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.contentView addSubview:_collectionView];
    
}
//更多
-(void)moreBtn:(UIButton*)button{
    [_cellDelegate more:button];
}
-(void)setupConstraints {
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Height_Pt(15));
        make.left.equalTo(self.contentView).with.offset(Width_Pt(25));
        make.height.mas_equalTo(Height_Pt(45));
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLabel);
        make.right.equalTo(self.contentView).with.offset(- Width_Pt(25));
        make.width.mas_equalTo(Width_Pt(120));
        make.height.mas_equalTo(Height_Pt(45));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_moreBtn.mas_left).with.offset( - Width_Pt(28));
        make.centerY.equalTo(_moreBtn);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(Height_Pt(45));
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(20));
        make.left.and.right.equalTo(self.contentView);
        //make.height.mas_equalTo(Height_Pt(447));
        make.bottom.equalTo(self.contentView);
    }];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (_section) {
        case 5:
            return 5;
        case 6:
            return 6;
        case 7:
            return 7;
        default:
            return 0;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomePageItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //[self configureCell:cell indexPath:indexPath];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((Width - Width_Pt(52)*2 -Width_Pt(42) * 2) / 3, Height_Pt(442));
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return Width_Pt(52);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return Height_Pt(52);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, Width_Pt(42), 0, Width_Pt(42));
}


@end
