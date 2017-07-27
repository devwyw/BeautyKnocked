//
//  PJBeautViewCell.m
//  BeautyKnocked
//
//  Created by 王毅安 on 17/7/27.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PJBeautViewCell.h"
#import "RatingBar.h"

@interface PJBeautViewCell ()
@property (nonatomic,strong) UIView * whiteView;
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UIView * line;
@property (nonatomic,strong) RatingBar * starBar;

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
//        self.contentView.backgroundColor=[UIColor whiteColor];
//        self.contentView.layer.cornerRadius=5;
//        self.contentView.layer.masksToBounds=YES;
        
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
    
    _image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"meirongshi_03"]];
    [self.contentView addSubview:_image];
    
    _title=[[UILabel alloc]init];
    _title.font=[UIFont systemFontOfSize:Font_Size(38)];
    _title.text=@"01  橙梦露";
    [self.contentView addSubview:_title];
    
    _line=[[UIView alloc]init];
    _line.backgroundColor=[UIColor colorWithHexString:@"#EBEBEB"];
    [self.contentView addSubview:_line];
    
    _starBar=[[RatingBar alloc]init];
    [_starBar setImageDeselected:@"huixing" halfSelected:@"huixing" fullSelected:@"liangxing" andDelegate:nil];
    [self.contentView addSubview:_starBar];
}
-(void)setMyFrames{
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Height_Pt(42)+8);
        make.left.equalTo(self.contentView).offset(Width_Pt(60)+10);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_image);
        make.left.equalTo(_image.mas_right).offset(Width_Pt(66));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_image.mas_bottom).offset(Height_Pt(42));
        make.width.mas_equalTo(Width-20);
        make.height.mas_equalTo(0.5);
    }];
    
    [_starBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(Height_Pt(55));
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake([UIImage imageNamed:@"huixing"].size.width*5, Height_Pt(100)));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-Height_Pt(78)-10);
    }];
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).mas_equalTo(UIEdgeInsetsMake(8, 10, 8, 10));
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

    // Configure the view for the selected state
}

@end
