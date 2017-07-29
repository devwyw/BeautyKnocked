//
//  EvaluationCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "EvaluationCell.h"
#import "EvaluationImageCell.h"
#import "StarView.h"

static NSString *reuseIdentifier = @"EvaluationImageCell";
@interface EvaluationCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UILabel *telLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) StarView * starRatingView;
@property (nonatomic, strong) UILabel *textContentLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *beauticianLabel;
@property (nonatomic, strong) UILabel *customerServiceReply;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation EvaluationCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}

#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EvaluationImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.imageName = self.dataSource[indexPath.item];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(Width_Pt(200), Height_Pt(168));
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return Width_Pt(40);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return Height_Pt(40);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)initializeViews {
    
    _headImgView = [[UIImageView alloc] init];
    
    _telLabel = [[UILabel alloc] init];
    _telLabel.font = [UIFont systemFontOfSize:Font_Size(36)];
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.font = [UIFont systemFontOfSize:Font_Size(36)];
    _dateLabel.textColor = [UIColor lightGrayColor];
    
    _starRatingView = [StarView evaluationViewWithChooseStarBlock:nil];
    _starRatingView.starCount=5;
    _starRatingView.spacing = 0.1;
    _starRatingView.tapEnabled = NO;
    
    
    _textContentLabel = [[UILabel alloc] init];
    _textContentLabel.font = [UIFont systemFontOfSize:Font_Size(39)];
    _textContentLabel.numberOfLines = 0;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc]  initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollEnabled = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[EvaluationImageCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    _beauticianLabel = [[UILabel alloc] init];
    _beauticianLabel.textColor = [UIColor lightGrayColor];
    _beauticianLabel.font = [UIFont systemFontOfSize:Font_Size(36)];
    
    _customerServiceReply = [[UILabel alloc] init];
    _customerServiceReply.font = [UIFont systemFontOfSize:Font_Size(34)];
    _customerServiceReply.numberOfLines = 0;
    //UIImage *replyImage = [UIImage imageNamed:@"huifukuang"];
    [_customerServiceReply setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    [self.contentView addSubview:_headImgView];
    [self.contentView addSubview:_telLabel];
    [self.contentView addSubview:_dateLabel];
    [self.contentView addSubview:_starRatingView];
    [self.contentView addSubview:_textContentLabel];
    [self.contentView addSubview:_collectionView];
    [self.contentView addSubview:_beauticianLabel];
    [self.contentView addSubview:_customerServiceReply];
    
    // debug code
    _telLabel.text = @"156****5626";
    [_headImgView setImage:[UIImage imageNamed:@"touxiang_03"]];
    _dateLabel.text = @"2017-05-15";
    _textContentLabel.text = @"回复数款福克斯的空间里水电费看看说大富科技接口生成女婿看了家是否登录卡萨;的脸孔; 拉的卡卡拉收到了卡拉斯科; 佛山东方考虑到索拉卡";
    //_beauticianLabel.text = @"美容师-李荣萍";
    _customerServiceReply.text = @"客服回复:亲,您的满意是平台前进的最大动力.";
    
}

-(void)addConstraints {
    
    [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(Width_Pt(62));
        make.top.equalTo(self.contentView).with.offset(Height_Pt(20));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(94), Height_Pt(94)));
    }];
    
    [_telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headImgView);
        make.left.equalTo(_headImgView.mas_right).with.offset(Width_Pt(23));
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headImgView);
        make.right.equalTo(self.contentView).with.offset( - Width_Pt(59));
    }];
    
    [_starRatingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImgView.mas_bottom).with.offset(3);
        make.left.equalTo(_telLabel.mas_left);
        make.width.mas_equalTo(Width_Pt(255));
        make.height.mas_equalTo(Height_Pt(50));
    }];
    
    [_textContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_telLabel.mas_left);
        make.top.equalTo(_starRatingView.mas_bottom).with.offset(Height_Pt(20));
        make.right.equalTo(self.contentView).with.offset( - Width_Pt(105));
        make.bottom.equalTo(_collectionView.mas_top).with.offset( - Height_Pt(30));
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_telLabel.mas_left);
        make.right.equalTo(_textContentLabel.mas_right);
        make.height.mas_equalTo(Height_Pt(170));
    }];

    [_beauticianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_telLabel.mas_left);
        make.top.equalTo(_collectionView.mas_bottom).with.offset(Height_Pt(20));
        make.height.mas_equalTo(Height_Pt(36));
    }];
    
    [_customerServiceReply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_beauticianLabel.mas_bottom).with.offset(Height_Pt(25));
        make.left.equalTo(_telLabel.mas_left);
        make.right.equalTo(self.contentView).with.offset( - Width_Pt(105));
        make.bottom.equalTo(self.contentView).with.offset( - Height_Pt(20));
    }];
    
}


-(void)setBeauticianName:(NSString *)beauticianName {
    _beauticianLabel.text = beauticianName;
    
    CGFloat beauticianHeight = beauticianName.length > 0  ? Height_Pt(36) : 0.0f;
    CGFloat beauticianTopHeight = beauticianHeight > 0 ? Height_Pt(20) : 0.f;
    
    [_beauticianLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_collectionView.mas_bottom).with.offset(beauticianTopHeight);
        make.height.mas_equalTo(beauticianHeight);
    }];
}

-(void)setImages:(NSArray *)images {
    CGFloat collectionViewheight = images.count ? Height_Pt(170):0.0;
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:images];
    
    [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(collectionViewheight);
    }];
}

@end
