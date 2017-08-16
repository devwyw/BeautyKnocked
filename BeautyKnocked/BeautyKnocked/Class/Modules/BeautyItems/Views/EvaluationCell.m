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
#import "CommentModel.h"
#import "ComListModel.h"

static NSString *reuseIdentifier = @"EvaluationImageCell";
@interface EvaluationCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) UILabel *telLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) StarView * starRatingView;
@property (nonatomic, strong) UILabel *textContentLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *beauticianLabel;
@property (nonatomic, strong) UIImageView * backimage;
@property (nonatomic, strong) UILabel *customerServiceReply;
@property (nonatomic, strong) NSArray *imageList;
@end
@implementation EvaluationCell

-(NSArray *)imageList {
    if (!_imageList) {
        _imageList = [NSArray array];
    }
    return _imageList;
}
+(UIImage*)imageWithimage:(UIImage*)image{
    image=[image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    return image;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)setModel:(CommentModel *)model{
    [_headImgView setImage:[UIImage imageNamed:@"touxiang_03"]];
    _telLabel.text = [model.account stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    _dateLabel.text = @"2017-05-15";
    _starRatingView.starCount=[model.score integerValue];
    _textContentLabel.text = model.content;
    _beauticianLabel.text = model.beauticianName;
    self.imageList = [model.imagesPaht componentsSeparatedByString:@","];//评论图片
    
    for (ComListModel *list in model.replys) {
        if (isStringEmpty(_customerServiceReply.text)) {
            _customerServiceReply.text = [NSString stringWithFormat:@"%@: %@",list.account,list.content];
        }else{
            _customerServiceReply.text = [NSString stringWithFormat:@"%@\n%@: %@",_customerServiceReply.text,list.account,list.content];
        }
    }
    
    CGFloat collectionViewheight = self.imageList.count ? Height_Pt(200):0.0;
    CGFloat beauticianHeight = _beauticianLabel.text.length > 0  ? Height_Pt(36) : 0.0f;
    CGFloat beauticianTopHeight = beauticianHeight > 0 ? Height_Pt(20) : 0.f;
    CGSize size = [_customerServiceReply.text boundingRectWithSize:CGSizeMake(Width-Width_Pt(170)-10, 150) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:Font_Size(35)]} context:nil].size;
    CGFloat ReplyHeight = _customerServiceReply.text.length > 0 ? size.height+15 : 0.f;
    
    [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(collectionViewheight);
    }];
    [_beauticianLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_collectionView.mas_bottom).with.offset(beauticianTopHeight);
        make.height.mas_equalTo(beauticianHeight);
    }];
    [_backimage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(ReplyHeight);
    }];
    [_collectionView reloadData];
}
#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EvaluationImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageName = self.imageList[indexPath.item];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(Width_Pt(200), Height_Pt(200));
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
    _telLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.font = [UIFont systemFontOfSize:Font_Size(35)];
    _dateLabel.textColor = [UIColor lightGrayColor];
    
    _starRatingView = [StarView evaluationViewWithChooseStarBlock:nil];
    _starRatingView.spacing = 0.1;
    _starRatingView.tapEnabled = NO;
    
    _textContentLabel = [[UILabel alloc] init];
    _textContentLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
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
    _beauticianLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    UIImage *image=[UIImage imageNamed:@"huifukuang"];
    image=[EvaluationCell imageWithimage:image];
    _backimage=[[UIImageView alloc]initWithImage:image];
    [self.contentView addSubview:_backimage];
    
    _customerServiceReply = [[UILabel alloc] init];
    _customerServiceReply.font = [UIFont systemFontOfSize:Font_Size(35)];
    _customerServiceReply.numberOfLines = 0;
    [_backimage addSubview:_customerServiceReply];
    
    [self.contentView addSubview:_headImgView];
    [self.contentView addSubview:_telLabel];
    [self.contentView addSubview:_dateLabel];
    [self.contentView addSubview:_starRatingView];
    [self.contentView addSubview:_textContentLabel];
    [self.contentView addSubview:_collectionView];
    [self.contentView addSubview:_beauticianLabel];
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
        make.top.equalTo(_headImgView.mas_bottom).with.offset(2.5);
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
        make.height.mas_equalTo(Height_Pt(200));
    }];

    [_beauticianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_telLabel.mas_left);
        make.top.equalTo(_collectionView.mas_bottom).with.offset(Height_Pt(20));
        make.height.mas_equalTo(Height_Pt(36));
    }];
    
    [_backimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_beauticianLabel.mas_bottom).with.offset(5);
        make.left.equalTo(_telLabel.mas_left);
        make.right.equalTo(_textContentLabel.mas_right);
        make.bottom.equalTo(self.contentView).with.offset( - Height_Pt(20));
        make.height.mas_equalTo(0);
    }];
    [_customerServiceReply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_backimage).mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
}

@end
