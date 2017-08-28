//
//  NewsCenterCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/1.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "NewsCenterCell.h"

@interface NewsCenterCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *signLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descrLabel;

@end

@implementation NewsCenterCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}

-(void)initializeViews {
    
    _imgView = [[UIImageView alloc] init];
    
    _signLabel = [[UILabel alloc] init];
    _signLabel.font = [UIFont systemFontOfSize:Font_Size(35)];
    _signLabel.textColor = [UIColor whiteColor];
    _signLabel.backgroundColor = [UIColor orangeColor];
    [_signLabel makeCornerRadius:4];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(48)];
    
    _descrLabel = [[UILabel alloc] init];
    _descrLabel.textColor = [UIColor lightGrayColor];
    _descrLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_signLabel];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_descrLabel];
}

-(void)addConstraints {
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(Width_Pt(25));
        make.width.mas_equalTo(Width_Pt(110));
        make.height.mas_equalTo(Height_Pt(98));
    }];
    
    [_signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Width_Pt(50));
        make.left.equalTo(_imgView.mas_right).with.offset(Width_Pt(55));
        make.height.mas_equalTo(Height_Pt(55));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_signLabel);
        make.left.equalTo(_signLabel.mas_right).with.offset(2);
    }];
    
    [_descrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_signLabel.mas_left);
        make.top.equalTo(_signLabel.mas_bottom).with.offset(Height_Pt(25));
        make.right.equalTo(self.contentView).with.offset( - Width_Pt(80));
    }];    
    
}

-(void)setSignText:(NSString *)signText {
    _signLabel.text=signText;
}

-(void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}
-(void)setDescrText:(NSString *)descrText {
    _descrLabel.text = descrText;
}

-(void)setImageName:(NSString *)imageName {
    _imgView.image = [UIImage imageNamed:imageName];
}

@end
