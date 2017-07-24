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
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setTitleColor:[UIColor colorWithHexString:@"#E1BF6E"] forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor colorWithHexString:@"#E1BF6E"] forState:UIControlStateHighlighted];
        _addButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"tianjiakuang"] forState:UIControlStateNormal];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"tianjiakuang"] forState:UIControlStateHighlighted];
        UIImage *addImage = [UIImage imageNamed:@"jiahao"];
        [_addButton setImage:addImage forState:UIControlStateNormal];
        [_addButton setImage:addImage forState:UIControlStateHighlighted];
        [_addButton setImgViewStyle:ButtonImgViewStyleLeft imageSize:addImage.size space:8];
        [[_addButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable button) {
            if ([self.delegate respondsToSelector:@selector(wantAddMore:)]) {
                [self.delegate wantAddMore:button.currentTitle];
            }
        }];

        [self.contentView addSubview:_addButton];
        
        [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(Width_Pt(280), Height_Pt(80)));
        }];
        
    }
    return self;
}

@end
