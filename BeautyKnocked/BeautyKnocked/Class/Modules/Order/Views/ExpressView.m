//
//  ExpressView.m
//  BeautyKnocked
//
//  Created by Mac on 2017/9/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ExpressView.h"

@interface ExpressView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UILabel *selectPaymentLabel;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *confirmPayButton;
@property (nonatomic,copy) NSString * type;
@end

@implementation ExpressView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        _selectPaymentLabel = [[UILabel alloc]init];
        _selectPaymentLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
        _selectPaymentLabel.text = @"配送方式";
        [self addSubview:_selectPaymentLabel];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = Height_Pt(150);
        _tableView.bounces=NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [self addSubview:_tableView];
        
        
        _confirmPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmPayButton setTitle:@"我知道了" forState:UIControlStateNormal];
        _confirmPayButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
        [_confirmPayButton setBackgroundColor:ThemeColor];
        [[_confirmPayButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (!isStringEmpty(_type)) {
                [Master RemovePopViewWithBlock:^{
                    [_subType sendNext:_type];
                }];
            }
        }];
        [self addSubview:_confirmPayButton];
        
        [_selectPaymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.centerX.equalTo(self);
            make.height.mas_equalTo(Height_Pt(150));
        }];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_selectPaymentLabel.mas_bottom);
            make.left.and.right.equalTo(self);
        }];
        
        [_confirmPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tableView.mas_bottom);
            make.left.bottom.right.equalTo(self);
            make.height.offset(Height_Pt(150));
        }];
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weigouxuan2"] highlightedImage:[UIImage imageNamed:@"gouxuanh"]];
    cell.backgroundColor=[UIColor clearColor];
    if (indexPath.row==0) {
        cell.textLabel.text = @"默认邮费到付";
    }else{
        cell.textLabel.text = @"美容师护理时携带";
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _type=[NSString stringWithFormat:@"%ld",indexPath.row];
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    for (UITableViewCell *cell in tableView.visibleCells) {
        UIImageView *accessoryImgView = (UIImageView *)cell.accessoryView;
        accessoryImgView.highlighted = [cell isEqual:selectedCell] ? YES : NO;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.5;
}

@end
