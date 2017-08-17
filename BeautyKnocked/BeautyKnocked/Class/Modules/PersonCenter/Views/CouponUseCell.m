//
//  CouponUseCell.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/17.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "CouponUseCell.h"

@interface CouponUseCell ()
@property (nonatomic,strong) UILabel * questionLabel;
@property (nonatomic,strong) UILabel * answerLabel;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * messageLabel;
@end

@implementation CouponUseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)setTitles:(NSString *)titles{
    _titleLabel.text=titles;
}
-(void)setMessages:(NSString *)messages{
    /** 计算富文本尺寸 */
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:messages];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = Height_Pt(30);
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Font_Size(40)] range:NSMakeRange(0, text.length)];
    
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width-Width_Pt(155), Height_Pt(210))];
    tempLabel.attributedText = text;
    tempLabel.numberOfLines = 0;
    [tempLabel sizeToFit];
    CGSize size = tempLabel.frame.size;
    
    _messageLabel.attributedText=text;
    [_messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height);
    }];
}
-(void)initializeViews {
    _questionLabel=[[UILabel alloc]init];
    _questionLabel.text=@"Q:";
    _questionLabel.font=[UIFont systemFontOfSize:Font_Size(40)];
    [self.contentView addSubview:_questionLabel];
    
    _titleLabel=[[UILabel alloc]init];
    _titleLabel.font=[UIFont systemFontOfSize:Font_Size(40)];
    [self.contentView addSubview:_titleLabel];
    
    _answerLabel=[[UILabel alloc]init];
    _answerLabel.text=@"A:";
    _answerLabel.textColor=[UIColor darkGrayColor];
    _answerLabel.font=[UIFont systemFontOfSize:Font_Size(40)];
    [self.contentView addSubview:_answerLabel];
    
    _messageLabel=[[UILabel alloc]init];
    _messageLabel.numberOfLines = 0;
    _messageLabel.font=[UIFont systemFontOfSize:Font_Size(40)];
    _messageLabel.textColor=[UIColor darkGrayColor];
    [self.contentView addSubview:_messageLabel];
}
-(void)addConstraints {
    [_questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Height_Pt(60));
        make.left.equalTo(self.contentView).offset(Width_Pt(50));
        make.width.mas_equalTo(Width_Pt(65));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_questionLabel);
        make.left.equalTo(_questionLabel.mas_right);
    }];
    
    [_answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_questionLabel.mas_bottom).offset(Height_Pt(30));
        make.left.equalTo(_questionLabel);
        make.width.mas_equalTo(Width_Pt(65));
    }];
    
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_answerLabel);
        make.left.equalTo(_answerLabel.mas_right);
        make.bottom.equalTo(self.contentView).offset(-Height_Pt(20));
        make.right.equalTo(self.contentView).offset(-Width_Pt(40));
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
