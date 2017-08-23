//
//  OrderTableViewCell.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/19.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "OrderItemTableViewCell.h"
#import "UIButton+Category.h"

static NSString *const orderItemTableViewCellIdentifier = @"OrderItemTableViewCell";
@interface OrderTableViewCell ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIView *marginLine;
@property (nonatomic, strong) UIButton *beauticianBtn;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation OrderTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupInterface];
        [self setupConstraints];
    }
    return self;
}

-(void)setupInterface {
    _leftView = [[UIView alloc] init];
    [_leftView setBackgroundColor:[UIColor colorWithHexString:@"#E1BF6E"]];
    [self.contentView addSubview:_leftView];
    
    _beauticianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_beauticianBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _beauticianBtn.titleLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    [_beauticianBtn setTitle:@"1号技师 陈梦琳" forState:UIControlStateNormal];
    [_beauticianBtn setImage:[UIImage imageNamed:@"dingdan-gengduo"] forState:UIControlStateNormal];
    [_beauticianBtn setImgViewStyle:ButtonImgViewStyleRight imageSize:[UIImage imageNamed:@"dingdan-gengduo"].size space:10];
    [_beauticianBtn addTarget:self action:@selector(beauticianBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_beauticianBtn];
    
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    [self.contentView addSubview:_statusLabel];
    
    _topLine = [[UIView alloc] init];
    _topLine.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    [self.contentView addSubview:_topLine];
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = NO;
        [tableView setBackgroundColor:[UIColor whiteColor]];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[OrderItemTableViewCell class] forCellReuseIdentifier:orderItemTableViewCellIdentifier];
        self.tableView = tableView;
        self.tableView;
    });
    [self.contentView addSubview:self.tableView];
    
    _bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    [self.contentView addSubview:_bottomLine];
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_leftButton setTitle:@"技师定位" forState:UIControlStateNormal];
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(38)];
    [self.contentView addSubview:_leftButton];
    
    _marginLine = [[UIView alloc] init];
    _marginLine.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    [self.contentView addSubview:_marginLine];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightButton setTitle:@"联系技师" forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(38)];
    [self.contentView addSubview:_rightButton];
}

-(void)setupConstraints {
    
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(Height_Pt(36));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(10), Height_Pt(30)));
    }];
    
    [_beauticianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftView);
        make.left.equalTo(_leftView.mas_right).with.offset(Width_Pt(24));
        //make.width.mas_equalTo(Width_Pt(302));
        make.height.mas_equalTo(Height_Pt(45));
    }];
    
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset( - Width_Pt(43));
        make.centerY.equalTo(_leftView);
    }];
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_beauticianBtn.mas_bottom).with.offset(Height_Pt(30));
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5f);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLine.mas_bottom).with.offset(Height_Pt(10));
        make.left.and.right.equalTo(self.contentView);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom);
        make.left.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomLine.mas_bottom);
        make.left.and.bottom.equalTo(self.contentView);
        make.width.equalTo(_rightButton.mas_width);
        make.height.mas_equalTo(Height_Pt(99));
    }];
    
    [_marginLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomLine.mas_bottom).with.offset(4);
        make.bottom.equalTo(self.contentView).with.offset(-4);
        make.left.equalTo(_leftButton.mas_right);
        make.width.mas_equalTo(1);
    }];
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_marginLine.mas_right);
        make.centerY.equalTo(_leftButton);
        make.height.equalTo(_leftButton.mas_height);
        make.right.equalTo(self.contentView);
    }];
    
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderItemTableViewCellIdentifier forIndexPath:indexPath];
    
    return cell;
}
-(void)beauticianBtn:(UIButton*)btn{
    [_cellDelegate cellPush];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_cellDelegate cellPush];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Height_Pt(298);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return Height_Pt(10);
}
-(RACSignal*)leftPush{
    return [_leftButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}
-(RACSignal*)rightPush{
    return [_rightButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}
@end
