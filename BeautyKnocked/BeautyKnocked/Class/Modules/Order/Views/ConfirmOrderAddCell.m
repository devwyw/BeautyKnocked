//
//  ConfirmOrderAddCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/16.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ConfirmOrderAddCell.h"
#import "UIButton+Category.h"

@interface ConfirmOrderAddCell ()

@property (nonatomic, strong) UIButton *addButton;

@end

@implementation ConfirmOrderAddCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setTitle:(NSString *)title {
    [_addButton setTitle:title forState:UIControlStateNormal];
    if ([title isEqualToString:@"立即支付"]) {
        [_addButton setImage:[UIImage new] forState:UIControlStateNormal];
        [_addButton setImgViewStyle:ButtonImgViewStyleLeft imageSize:CGSizeZero space:0];
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addButton setBackgroundColor:[UIColor colorWithHexString:@"#E1BF6E"]];
    }else{
        [_addButton setTitleColor:[UIColor colorWithHexString:@"#E1BF6E"] forState:UIControlStateNormal];
        [_addButton setBackgroundColor:[UIColor clearColor]];
        [_addButton setImage:[UIImage imageNamed:@"jiahao1"] forState:UIControlStateNormal];
        [_addButton setImgViewStyle:ButtonImgViewStyleLeft imageSize:[UIImage imageNamed:@"jiahao1"].size space:8];
    }
}
-(void)setColorStr:(NSString *)colorStr{
    [_addButton setBackgroundColor:[UIColor colorWithHexString:colorStr]];
    [_addButton setImage:[UIImage new] forState:UIControlStateNormal];
    [_addButton setImgViewStyle:ButtonImgViewStyleLeft imageSize:CGSizeMake(CGFLOAT_MIN, CGFLOAT_MIN) space:0];
    [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
        [_addButton makeCornerRadius:5];
        [_addButton makeBorderWidth:0.5 withColor:[UIColor colorWithHexString:@"#D7AE4D"]];
        [self.contentView addSubview:_addButton];
        [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(Width_Pt(280), Height_Pt(80)));
        }];
        
    }
    return self;
}
-(RACSignal*)addMore{
    return [_addButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}
@end
