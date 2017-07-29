//
//  PJItemViewCell.m
//  BeautyKnocked
//
//  Created by Mac on 2017/7/28.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PJItemViewCell.h"
#import "RatingBar.h"

@interface PJItemViewCell ()

@property (nonatomic,strong) UIView * whiteView;
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UIView * line;
@property (nonatomic,strong) RatingBar * starBar;

@property (nonatomic,strong) UILabel * topTitle;
@property (nonatomic,strong) UILabel * bottomTitle;
@property (nonatomic,strong) UILabel * imageTitle;

@end


@implementation PJItemViewCell

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
    
    _starBar=[[RatingBar alloc]init];
    [_starBar setImageDeselected:@"huixing" halfSelected:@"huixing" fullSelected:@"liangxing" andDelegate:nil];
    [self.contentView addSubview:_starBar];
    
    _textview=[[UITextView alloc]init];
    _textview.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    _textview.layer.borderColor=[UIColor colorWithHexString:@"#E0E0E0"].CGColor;
    _textview.layer.borderWidth=0.5;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeText:) name:UITextViewTextDidChangeNotification object:nil];
    [self.contentView addSubview:_textview];
    
    _topTitle=[[UILabel alloc]initWithFrame:CGRectMake(5, 3, (Width-20-Width_Pt(120))-10, Font_Size(35)*3)];
    _topTitle.font=[UIFont systemFontOfSize:Font_Size(35)];
    _topTitle.text=@"亲，产品使用是否满意，快来写出你的使用心得吧~";
    _topTitle.numberOfLines=0;
    _topTitle.textColor=[UIColor lightGrayColor];
    [_textview addSubview:_topTitle];
    
    _bottomTitle=[[UILabel alloc]initWithFrame:CGRectMake((Width-20-Width_Pt(120))/2-5, Height_Pt(400)-(Font_Size(35)*1.5), (Width-20-Width_Pt(120))/2, Font_Size(35)*1.5)];
    _bottomTitle.font=[UIFont systemFontOfSize:Font_Size(35)];
    _bottomTitle.textAlignment=NSTextAlignmentRight;
    _bottomTitle.text=@"请至少输入2个字";
    _bottomTitle.textColor=[UIColor lightGrayColor];
    [_textview addSubview:_bottomTitle];
    
    _addImage=[[UIButton alloc]init];
    [_addImage setImage:[UIImage imageNamed:@"zhaopian"] forState:UIControlStateNormal];
    _addImage.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    _addImage.layer.borderColor=[UIColor colorWithHexString:@"#E0E0E0"].CGColor;
    _addImage.layer.borderWidth=0.25;
    [self.contentView addSubview:_addImage];
    
    _imageTitle=[[UILabel alloc]init];
    _imageTitle.text=@"上传图片";
    _imageTitle.font=[UIFont systemFontOfSize:Font_Size(35)];
    _imageTitle.textColor=[UIColor colorWithHexString:@"#666666"];
    [self.contentView addSubview:_imageTitle];
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
        make.size.mas_equalTo(CGSizeMake([UIImage imageNamed:@"huixing"].size.width*5, Height_Pt(100)));
    }];
    
    [_textview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_starBar.mas_bottom).offset(Height_Pt(40));
        make.centerX.equalTo(_whiteView);
        make.size.mas_equalTo(CGSizeMake(Width-Width_Pt(120)-20, Height_Pt(400)));
    }];
    
    [_addImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textview.mas_bottom).offset(Height_Pt(45));
        make.left.equalTo(_image);
        make.bottom.equalTo(_whiteView.mas_bottom).offset(-Height_Pt(35));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(240), Height_Pt(240)));
    }];
    [_imageTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_addImage.mas_right).offset(Width_Pt(42));
        make.bottom.equalTo(_addImage.mas_bottom);
    }];
}
-(void)ChangeText:(NSNotification *)not{
    if (_textview.text.length==0) {
        _topTitle.hidden=NO;
        _bottomTitle.hidden=NO;
    }else{
        _topTitle.hidden=YES;
        _bottomTitle.hidden=YES;
    }
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