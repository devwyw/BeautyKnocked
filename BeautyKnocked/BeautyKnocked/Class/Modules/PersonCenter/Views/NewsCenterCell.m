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
@property (nonatomic, strong) UIImageView *signView;
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
    
    _signView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guanfnag"]];

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    
    _descrLabel = [[UILabel alloc] init];
    _descrLabel.textColor = [UIColor lightGrayColor];
    _descrLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_signView];
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
    
    [_signView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Height_Pt(50));
        make.left.equalTo(_imgView.mas_right).with.offset(Width_Pt(55));
        make.size.sizeOffset(CGSizeZero);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(Height_Pt(50));
        make.left.equalTo(_signView.mas_right).with.offset(2);
    }];
    
    [_descrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_signView);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(Height_Pt(25));
        make.right.equalTo(self.contentView).with.offset( - Width_Pt(80));
    }];
}
-(void)setModel:(NewsCenterModel *)model{
    if ([model.imgName isEqualToString:@"xitongxiaoxi"]) {
        [_signView mas_updateConstraints:^(MASConstraintMaker *make) {
           make.size.sizeOffset(CGSizeMake(Width_Pt(90), Height_Pt(55)));
        }];
    }else{
        [_signView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset(CGSizeZero);
        }];
    }
    _titleLabel.text = model.title;
    _descrLabel.text = model.descr;
    _imgView.image = [UIImage imageNamed:model.imgName];
}
@end
