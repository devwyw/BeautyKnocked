//
//  FootPriceView.m
//  Technician
//
//  Created by Mac on 2017/8/5.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "FootPriceView.h"
#import "UIButton+Category.h"

@interface FootPriceView ()
@property (nonatomic,strong) UIButton * allSelected;
@property (nonatomic,strong) UILabel * allPrice;
@property (nonatomic,strong) UIButton * buy;
@end

@implementation FootPriceView
-(void)setPrice:(NSString *)price{
    _price=price;
    NSString *text = [NSString stringWithFormat:@"总计: ¥ %@",price];
    NSRange redRange = [text rangeOfString:[text substringFromIndex:4]];
    NSMutableAttributedString *muAttStr = [[NSMutableAttributedString alloc] initWithString:text];
    [muAttStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Font_Size(40)] range:NSMakeRange(0, text.length)];
    [muAttStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    _allPrice.attributedText=muAttStr;
}
-(void)setBtnName:(NSString *)btnName{
    if ([btnName integerValue]==0) {
        [_buy setTitle:@"结算" forState:UIControlStateNormal];
    }else{
        [_buy setTitle:[NSString stringWithFormat:@"结算 (%@)",btnName] forState:UIControlStateNormal];
    }
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self makeShadowOffset:CGSizeMake(0, 0)];
        [self initializeViews];
        [self addConstraints];
    }
    return self;
}
-(void)initializeViews {
    _allSelected=[[UIButton alloc]init];
    [_allSelected setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [_allSelected setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [_allSelected setTitle:@"全选" forState:UIControlStateNormal];
    [_allSelected setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_allSelected setImgViewStyle:ButtonImgViewStyleLeft imageSize:[UIImage imageNamed:@"weixuanzhong"].size space:5];
    [self addSubview:_allSelected];
    
    _allPrice=[[UILabel alloc]init];
    [self addSubview:_allPrice];
    
    _buy=[[UIButton alloc]init];
    _buy.titleLabel.font=[UIFont systemFontOfSize:Font_Size(45)];
    _buy.backgroundColor=ThemeColor;
    [self addSubview:_buy];
}
-(void)addConstraints {
    [_allSelected mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(Width_Pt(45));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(160), Height_Pt(60)));
    }];
    [_allPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(_buy.mas_left).offset(-Width_Pt(90));
    }];
    [_buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.mas_equalTo(Width_Pt(320));
    }];
}
-(RACSignal*)allAction{
    return [_allSelected rac_signalForControlEvents:UIControlEventTouchUpInside];
}
-(RACSignal*)allBuy{
    return [_buy rac_signalForControlEvents:UIControlEventTouchUpInside];
}
@end
