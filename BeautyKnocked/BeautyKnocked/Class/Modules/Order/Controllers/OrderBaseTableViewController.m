//
//  OrderBaseTableViewController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/20.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "OrderBaseTableViewController.h"
#import "OrderTableViewCell.h"
#import "OrderMessageViewController.h"
#import "WuLiuController.h"
#import "OrderPJController.h"

static NSString *const orderTableViewCellIdentifier = @"OrderTableViewCell";

@interface OrderBaseTableViewController ()<OrderTableViewCellDelegate>

@property (nonatomic,strong) UIView * nilView;

@end

@implementation OrderBaseTableViewController

-(instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F7F7F7"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:orderTableViewCellIdentifier];

        _nilView=[[UIView alloc]init];
        _nilView.hidden=YES;
        [self.view addSubview:_nilView];
        
        UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wudingdan"]];
        [_nilView addSubview:image];
        
        UILabel *title=[[UILabel alloc]init];
        title.text=@"暂无订单，赶紧去逛逛吧~";
        title.font=[UIFont systemFontOfSize:Font_Size(30)];
        title.textColor=[UIColor grayColor];
        [_nilView addSubview:title];
        
        [_nilView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nilView);
            make.centerX.equalTo(_nilView);
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(image.mas_bottom).offset(Height_Pt(45));
            make.centerX.equalTo(_nilView);
            make.left.bottom.right.equalTo(_nilView);
        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    switch (_index) {
        case 0:
        {
            //_nilView.hidden=NO;
        }
            return 15;
        case 1:
            return 4;
        case 2:
            return 5;
        case 3:
            return 6;
        default:
            return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderTableViewCellIdentifier forIndexPath:indexPath];
    cell.cellDelegate=self;
    Weakify(self);
    [[cell.leftPush takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
        OrderPJController *controller=[[OrderPJController alloc]init];
        controller.hidesBottomBarWhenPushed=YES;
        [Wself.navigationController pushViewController:controller animated:YES];
    }];
    [[cell.rightPush takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
        WuLiuController *controller=[[WuLiuController alloc]init];
        controller.hidesBottomBarWhenPushed=YES;
        [Wself.navigationController pushViewController:controller animated:YES];
    }];
    /*
     查看评价 再次购买
     技师定位 联系技师 - 查看物流 确认收货
     追加订单 确认订单
     删除订单 去评价 All
     */
    return cell;
}
-(void)cellPush{
    OrderMessageViewController *controller=[[OrderMessageViewController alloc]init];
    controller.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self cellPush];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Height_Pt(110)*2+Height_Pt(300)*2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

@end
