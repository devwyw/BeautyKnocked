//
//  SystemMessageCell.m
//  BeautyKnocked
//
//  Created by Mac on 2017/9/13.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "SystemMessageCell.h"

@interface SystemMessageCell ()
@property (nonatomic,strong) UILabel * day;
@property (nonatomic,strong) UIView * white;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic,strong) UILabel * message;
@property (nonatomic,strong) UIView * read;
@end

@implementation SystemMessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=0;
        self.backgroundColor=[UIColor clearColor];
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)setModel:(SystemMessageModel *)model{
    NSTimeInterval interval=[[model.createDate substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy年MM月dd日"];
    _day.text=[dateformatter stringFromDate:date];
    _title.text=model.name;
    _message.text=model.content;
    _read.hidden=[model.status integerValue]==1 ? YES:NO;
}
-(void)initializeViews {
    _day=[[UILabel alloc]init];
    _day.backgroundColor=[UIColor colorWithHexString:@"#bfbfbf"];
    [_day makeCornerRadius:3];
    _day.textColor=[UIColor whiteColor];
    _day.textAlignment=NSTextAlignmentCenter;
    _day.font=[UIFont systemFontOfSize:Font_Size(35)];
    [self.contentView addSubview:_day];
    
    _white=[Master getLineView:[UIColor whiteColor]];
    _white.layer.cornerRadius = 8;
    [_white makeShadowOffset:CGSizeMake(0, 0)];
    [self.contentView addSubview:_white];
    
    _read=[Master getLineView:[UIColor redColor]];
    [_read makeCornerRadius:Width_Pt(20)];
    [_white addSubview:_read];
    
    _title=[[UILabel alloc]init];
    _title.font=[UIFont systemFontOfSize:Font_Size(50)];
    [_white addSubview:_title];
    
    _image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"youhuiquan"]];
    [_white addSubview:_image];
    
    _message=[[UILabel alloc]init];
    _message.numberOfLines=0;
    _message.font=[UIFont systemFontOfSize:Font_Size(40)];
    [_white addSubview:_message];
}
-(void)addConstraints {
    [_day mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Height_Pt(80));
        make.centerX.equalTo(self.contentView);
        make.size.sizeOffset(CGSizeMake(Width_Pt(330), Height_Pt(70)));
    }];
    
    [_white mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_day.mas_bottom).offset(Height_Pt(40));
        make.left.equalTo(self.contentView).offset(Width_Pt(50));
        make.right.equalTo(self.contentView).offset(-Width_Pt(50));
        make.bottom.equalTo(self.contentView).offset(-Height_Pt(10));
    }];
    
    [_read mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(Width_Pt(40), Height_Pt(40)));
        make.top.equalTo(_white).offset(Height_Pt(30));
        make.right.equalTo(_white).offset(-Width_Pt(30));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_white).offset(Height_Pt(55));
        make.left.equalTo(_white).offset(Width_Pt(43));
    }];
    
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_title);
        make.top.equalTo(_title.mas_bottom).offset(Height_Pt(45));
        make.size.sizeOffset(CGSizeMake(Width_Pt(200), Height_Pt(200)));
        make.bottom.equalTo(_white).offset(-Height_Pt(55));
    }];
    
    [_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).offset(Height_Pt(55));
        make.left.equalTo(_image.mas_right).offset(Width_Pt(45));
        make.right.equalTo(_white.mas_right).offset(-Width_Pt(43));
        make.bottom.equalTo(_image);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
