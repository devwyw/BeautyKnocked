//
//  PJBeautViewCell.m
//  BeautyKnocked
//
//  Created by 王毅安 on 17/7/27.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PJBeautViewCell.h"
#import "StarView.h"

@interface PJBeautViewCell ()

@property (nonatomic,strong) UIView * whiteView;
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UIView * line;
@property (nonatomic,strong) StarView * starBar;

@end

@implementation PJBeautViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self setMyViews];
        [self setMyFrames];
    }
    return self;
}

-(void)setMyViews{
    _whiteView=[[UIView alloc]init];
    _whiteView.backgroundColor=[UIColor whiteColor];
    _whiteView.layer.cornerRadius=5;
    _whiteView.layer.masksToBounds=YES;
    [self.contentView addSubview:_whiteView];
    
    _image=[[UIImageView alloc]init];
    [self.contentView addSubview:_image];
    
    _title=[[UILabel alloc]init];
    _title.font=[UIFont systemFontOfSize:Font_Size(38)];
    [self.contentView addSubview:_title];
    
    _line=[[UIView alloc]init];
    _line.backgroundColor=[UIColor colorWithHexString:@"#EBEBEB"];
    [self.contentView addSubview:_line];
    
    //__weak __typeof(self)weakSelf = self;
    _starBar = [StarView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
        // 做评星后点处理
    }];
    _starBar.spacing = 0.1;
    _starBar.tapEnabled = YES;
    [self.contentView addSubview:_starBar];
}
-(void)setMyFrames{
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).mas_equalTo(UIEdgeInsetsMake(8, 10, 8, 10));
    }];
    
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_whiteView).offset(Height_Pt(42));
        make.left.equalTo(_whiteView).offset(Width_Pt(60));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_image);
        make.left.equalTo(_image.mas_right).offset(Width_Pt(66));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_image.mas_bottom).offset(Height_Pt(42));
        make.size.mas_equalTo(CGSizeMake(Width-20,1));
        make.centerX.equalTo(_whiteView);
    }];
    
    [_starBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(Height_Pt(55));
        make.centerX.equalTo(_whiteView);
        make.size.mas_equalTo(CGSizeMake([UIImage imageNamed:@"huixing"].size.width*5, [UIImage imageNamed:@"huixing"].size.height));
        make.bottom.equalTo(_whiteView.mas_bottom).offset(-Height_Pt(78));
    }];
}
-(void)setImageName:(NSString *)imageName{
    _image.image=[UIImage imageNamed:imageName];
}
-(void)setTitleStr:(NSString *)titleStr{
    _title.text=titleStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
