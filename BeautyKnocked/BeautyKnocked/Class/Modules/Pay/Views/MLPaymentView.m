//
//  MLPaymentView.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/10.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "MLPaymentView.h"

@interface MLPaymentView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *selectPaymentLabel;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *confirmPayButton;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MLPaymentView

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    
    self.type = MMPopupTypeSheet;
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width, Height_Pt(207+180*4)));
    }];

    self.backView = [UIView new];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    _selectPaymentLabel = [[UILabel alloc] init];
    _selectPaymentLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    _selectPaymentLabel.text = @"请选择支付方式";
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(actionClose) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = Height_Pt(180);
    _tableView.scrollEnabled = NO;    
    
    
    _confirmPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmPayButton setTitle:@"确认支付" forState:UIControlStateNormal];
    _confirmPayButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    [_confirmPayButton setBackgroundColor:[UIColor greenColor]];
    
    [_backView addSubview:_selectPaymentLabel];
    [_backView addSubview:_cancelButton];

    [_backView addSubview:_tableView];

    [_backView addSubview:_confirmPayButton];
    
    
    [self.selectPaymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView);
        make.centerX.equalTo(_backView);
        make.height.mas_equalTo(Height_Pt(180));
    }];
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.equalTo(_backView).with.insets(UIEdgeInsetsMake(5, 0, 0, 8));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(130), Height_Pt(130)));
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_selectPaymentLabel.mas_bottom);
        make.left.and.right.equalTo(_backView);
        make.height.mas_equalTo(Height_Pt(180*3));
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    [_backView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom);
        make.left.and.right.equalTo(_backView);
        make.height.mas_equalTo(0.5);
    }];
    
    
    [_confirmPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom).with.offset(Height_Pt(34));
        make.left.equalTo(_backView).with.offset(Width_Pt(34));
        make.right.equalTo(_backView).with.offset(-Width_Pt(34));
        make.bottom.equalTo(_backView).with.offset( - Height_Pt(34));
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCellStyleValue1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *imageName = self.dataSource[indexPath.row][@"image"];
    NSString *paymentName = self.dataSource[indexPath.row][@"name"];
    [cell.imageView setImage:[UIImage imageNamed:imageName]];
    cell.textLabel.text = paymentName;
    
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weigouxuan"] highlightedImage:[UIImage imageNamed:@"gouxuan"]];
    
    if (indexPath.row == 0) {
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.text = @"本次交易不支持";
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return;
    }
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    for (UITableViewCell *cell in tableView.visibleCells) {
        UIImageView *accessoryImgView = (UIImageView *)cell.accessoryView;
        // set selected image
        accessoryImgView.highlighted = [cell isEqual:selectedCell] ? YES : NO;
    }

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        
        NSArray *array = @[@{@"image":@"yu-e",@"name":@"余额支付"},
                           @{@"image":@"weixin",@"name":@"微信支付"},
                           @{@"image":@"zhifubao",@"name":@"支付宝支付"}];
        
        [_dataSource addObjectsFromArray:array];
    }
    return _dataSource;
}

- (void)actionClose
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确定要放弃当前支付操作吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"继续支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self hide];
    }]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}


@end
