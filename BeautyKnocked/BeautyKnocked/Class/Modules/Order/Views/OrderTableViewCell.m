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

@property (nonatomic,strong) UIView * white;
@property (nonatomic,strong) UIView * leftView;
@property (nonatomic,strong) UILabel * statusLabel;
@property (nonatomic,strong) UIView * topLine;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIView * bottomLine;
@property (nonatomic,strong) UIView * marginLine;
@property (nonatomic,strong) UILabel * beauticianTitle;
@property (nonatomic,strong) UIImageView * beauticianImage;
@property (nonatomic,strong) UIButton * leftButton;
@property (nonatomic,strong) UIButton * rightButton;
@property (nonatomic,strong) UILabel * allCount;
@end

@implementation OrderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        [self setupInterface];
        [self setupConstraints];
    }
    return self;
}
-(void)setModel:(OrderListModel *)model{
    _model=model;
    
    NSString *use=@"无折扣";
    NSString *commType=[model.commType integerValue]==1 ? @"个服务":@"件产品";
    for (NSDictionary *dict in model.list) {
        if ([dict[@"isUse"] integerValue]==1) {
            use=@"已使用折扣";
            break;
        }
    }
    NSString *all=[NSString stringWithFormat:@"共%ld%@   合计：¥%@（%@）",model.list.count,commType,model.money,use];
    NSRange redRang=[all rangeOfString:[NSString stringWithFormat:@"¥%@",model.money]];
    NSMutableAttributedString *attributed=[[NSMutableAttributedString alloc]initWithString:all];
    [attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Font_Size(35)] range:NSMakeRange(0, all.length)];
    [attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:Font_Size(40)] range:redRang];
    [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#d73533"] range:redRang];
    _allCount.attributedText=attributed;
    
    if ([model.beauticianId integerValue]==0) {
        _beauticianTitle.text=@"随机技师";
    }else{
        _beauticianTitle.text=[NSString stringWithFormat:@"%@号 %@",model.beauticianId,model.beauticianName];
    }
    
    NSString *status=nil;
    NSString *left=nil;
    NSString *right=nil;
    bool isChange=NO;
    BOOL isZero=NO;
    switch ([model.status integerValue]) {
        case 0:
        {
            status=@"未支付";
            isZero=YES;
        }
            break;
        case 1:
            if ([model.commType integerValue]==1) {
                status=@"待服务";
                left=@"技师定位";
                right=@"联系技师";
                isChange=YES;
            }else{
                status=@"待发货";
                isZero=YES;
            }
            break;
        case 2:
            if ([model.commType integerValue]==1) {
                status=@"服务中";
                left=@"追加订单";
                right=@"确认订单";
            }else{
                status=@"已发货";
                left=@"查看物流";
                right=@"确认收货";
            }
            isChange=YES;
            break;
        case 3:
            status=@"待评价";
            left=@"删除订单";
            right=@"去评价";
            isChange=YES;
            break;
        default:
            status=@"交易完成";
            left=@"查看评价";
            right=@"再次购买";
            break;
    }
    _statusLabel.text=status;
    
    [_leftButton setTitle:left forState:UIControlStateNormal];
    [_rightButton setTitle:right forState:UIControlStateNormal];
    if (isChange) {
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"haungkuang"] forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [_rightButton setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (isZero) {
        NSArray *array=@[_leftButton,_rightButton];
        [array mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
        }];
        [_marginLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bottomLine.mas_bottom);
            make.bottom.equalTo(_white);
        }];
        _leftButton.hidden=YES;
        _rightButton.hidden=YES;
    }else{
        NSArray *array=@[_leftButton,_rightButton];
        [array mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(Height_Pt(99));
        }];
        [_marginLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bottomLine.mas_bottom).offset(4);
            make.bottom.equalTo(_white).offset(-4);
        }];
        _leftButton.hidden=NO;
        _rightButton.hidden=NO;
    }
    [_tableView reloadData];
}
-(void)setupInterface {
    _white=[Master getLineView:[UIColor whiteColor]];
    [self.contentView addSubview:_white];
    
    _leftView = [[UIView alloc] init];
    [_leftView setBackgroundColor:ThemeColor];
    [_white addSubview:_leftView];
    
    _beauticianTitle = [[UILabel alloc]init];
    _beauticianTitle.font = [UIFont systemFontOfSize:Font_Size(40)];
    [_white addSubview:_beauticianTitle];
    _beauticianImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dingdan-gengduo"]];
    _beauticianImage.contentMode=UIViewContentModeScaleAspectFit;
    [_white addSubview:_beauticianImage];
    
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.font = [UIFont systemFontOfSize:Font_Size(40)];
    _statusLabel.textColor=ThemeColor;
    [_white addSubview:_statusLabel];
    
    _topLine = [[UIView alloc] init];
    _topLine.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    [_white addSubview:_topLine];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.userInteractionEnabled=NO;
    [_tableView setBackgroundColor:[UIColor clearColor]];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.showsHorizontalScrollIndicator=NO;
    [_tableView registerClass:[OrderItemTableViewCell class] forCellReuseIdentifier:orderItemTableViewCellIdentifier];
    [_white addSubview:_tableView];
    
    _allCount=[[UILabel alloc]init];
    [_white addSubview:_allCount];
    
    _bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    [_white addSubview:_bottomLine];
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(38)];
    [_white addSubview:_leftButton];
    
    _marginLine = [[UIView alloc] init];
    _marginLine.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    [_white addSubview:_marginLine];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(38)];
    [_white addSubview:_rightButton];
}
-(void)setupConstraints {
    [_white mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
    
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_white);
        make.top.equalTo(_white).with.offset(Height_Pt(36));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(10), Height_Pt(30)));
    }];
    
    [_beauticianTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftView);
        make.left.equalTo(_leftView.mas_right).offset(Width_Pt(25));
        make.height.mas_equalTo(Height_Pt(45));
    }];
    [_beauticianImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_beauticianTitle);
        make.left.equalTo(_beauticianTitle.mas_right).offset(Width_Pt(10));
        make.size.sizeOffset(CGSizeMake(Width_Pt(30), Height_Pt(30)));
    }];
    
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_white).with.offset( - Width_Pt(45));
        make.centerY.equalTo(_leftView);
    }];
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_beauticianTitle.mas_bottom).with.offset(Height_Pt(30));
        make.left.and.right.equalTo(_white);
        make.height.mas_equalTo(0.5f);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLine.mas_bottom).with.offset(Height_Pt(10));
        make.left.and.right.equalTo(_white);
    }];
    
    [_allCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom).offset(Height_Pt(25));
        make.right.equalTo(_white.mas_right).offset(-Width_Pt(15));
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_allCount.mas_bottom).offset(Height_Pt(25));
        make.left.and.right.equalTo(_white);
        make.height.mas_equalTo(0.5);
    }];
    
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomLine.mas_bottom);
        make.left.and.bottom.equalTo(_white);
        make.width.equalTo(_rightButton.mas_width);
        make.height.mas_equalTo(Height_Pt(99));
    }];
    
    [_marginLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomLine.mas_bottom).offset(4);
        make.bottom.equalTo(_white).with.offset(-4);
        make.left.equalTo(_leftButton.mas_right);
        make.width.mas_equalTo(1);
    }];
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_marginLine.mas_right);
        make.centerY.equalTo(_leftButton);
        make.height.equalTo(_leftButton.mas_height);
        make.right.equalTo(_white);
    }];
}
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!isObjectEmpty(_model)) {
        return _model.list.count;
    }else{
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderItemTableViewCellIdentifier forIndexPath:indexPath];
    cell.isProduct=[_model.commType integerValue]==3 ? YES:NO;
    cell.time=_model.pactServiceTime;
    cell.addRess=_model.serviceAddress;
    cell.model=[OrderInfoListModel mj_objectWithKeyValues:_model.list[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Height_Pt(298);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return Height_Pt(5);
}
-(RACSignal*)subLeft{
    return [_leftButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}
-(RACSignal*)subRight{
    return [_rightButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
@end
