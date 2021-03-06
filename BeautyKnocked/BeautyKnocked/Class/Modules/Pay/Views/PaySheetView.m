//
//  PaySheetView.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/2.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PaySheetView.h"

@interface PaySheetView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UILabel *selectPaymentLabel;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *confirmPayButton;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,copy) NSString * type;
@end

@implementation PaySheetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithHexString:@"#FCFCFC"];
        [self setupUI];
    }
    return self;
}
-(void)setupUI {
    _selectPaymentLabel = [[UILabel alloc]init];
    _selectPaymentLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    _selectPaymentLabel.text = @"请选择支付方式";
    [self addSubview:_selectPaymentLabel];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setImage:[UIImage imageNamed:@"quxiao2"] forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(actionClose) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelButton];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = Height_Pt(180);
    _tableView.bounces=NO;
    [self addSubview:_tableView];
    
    _confirmPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmPayButton setTitle:@"确认支付" forState:UIControlStateNormal];
    _confirmPayButton.titleLabel.font = [UIFont systemFontOfSize:Font_Size(50)];
    [_confirmPayButton makeCornerRadius:5];
    Weakify(self);
    [[_confirmPayButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (!isStringEmpty(Wself.type)) {
            [Master RemovePopViewWithBlock:^{
                [Wself.subType sendNext:Wself.type];
            }];
            
        }
    }];
    [_confirmPayButton setBackgroundColor:[UIColor colorWithHexString:@"#67D75A"]];
    [self addSubview:_confirmPayButton];
    
    [self.selectPaymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(Height_Pt(180));
    }];
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(Height_Pt(42));
        make.right.equalTo(self).offset(-Width_Pt(45));
        make.size.mas_equalTo(CGSizeMake(Width_Pt(60), Height_Pt(60)));
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_selectPaymentLabel.mas_bottom);
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(Height_Pt(180*3));
    }];

    [_confirmPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom).with.offset(Height_Pt(34));
        make.left.equalTo(self).with.offset(Width_Pt(34));
        make.right.equalTo(self).with.offset(-Width_Pt(34));
        make.bottom.equalTo(self).with.offset( - Height_Pt(34));
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCellStyleValue1"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    [cell.imageView setImage:[UIImage imageNamed:self.dataSource[indexPath.row][@"image"]]];
    cell.textLabel.text = self.dataSource[indexPath.row][@"name"];
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weigouxuan"] highlightedImage:[UIImage imageNamed:@"gouxuan"]];
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
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确定要放弃当前支付操作吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"继续支付" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [Master RemovePopViewWithBlock:nil];
    }]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}
@end
