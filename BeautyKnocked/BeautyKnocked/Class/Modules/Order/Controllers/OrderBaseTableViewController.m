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
#import "LocationController.h"
#import <MJRefresh.h>

static NSString *const orderTableViewCellIdentifier = @"OrderTableViewCell";

@interface OrderBaseTableViewController ()
@property (nonatomic,strong) NSMutableArray * listArray;
@property (nonatomic,strong) UIView * nilView;
@end

@implementation OrderBaseTableViewController

-(instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}
-(NSMutableArray*)listArray{
    if (!_listArray) {
        _listArray=[[NSMutableArray alloc]init];
    }
    return _listArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F7F7F7"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator=NO;
    [self.tableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:orderTableViewCellIdentifier];
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHttpData)];
    [self.tableView.mj_header beginRefreshing];
    
    _nilView=[[UIView alloc]init];
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
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderTableViewCellIdentifier forIndexPath:indexPath];
    cell.model=[OrderListModel mj_objectWithKeyValues:self.listArray[indexPath.row]];
    Weakify(self);
    [[cell.subLeft takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
        [Wself pushWithAction:YES WithModel:cell.model];
    }];
    
    [[cell.subRight takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(id  _Nullable x) {
        [Wself pushWithAction:NO WithModel:cell.model];
    }];
    return cell;
}
-(void)pushWithAction:(BOOL)action WithModel:(OrderListModel*)model{
    switch ([model.status integerValue]) {
        case 1:
            if ([model.commType integerValue]==1) {
                /** 待服务 */
                if (action) {
                    //技师定位
                    LocationController *controller=[[LocationController alloc]init];
                    controller.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:controller animated:YES];
                }else{
                    //联系技师
                }
            }
            break;
        case 2:
            if ([model.commType integerValue]==1) {
                /** 服务中 */
                if (action) {
                    //追加订单
                    [self pushOrderMessage:model];
                }else{
                    //确认订单
                    NSLog(@"");
                    
                }
            }else{
                /** 已发货 */
                if (action) {
                    //查看物流
                    WuLiuController *controller=[[WuLiuController alloc]init];
                    controller.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:controller animated:YES];
                }else{
                    //确认收货
                }
            }
            break;
        case 3:
            /** 待评价 */
            if (action) {
                //删除订单
                
            }else{
                //订单评价
                OrderPJController *controller=[[OrderPJController alloc]init];
                controller.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:controller animated:YES];
            }
            break;
        case 4:
            /** 交易完成 */
            if (action) {
                NSLog(@"查看评价");
            }else{
                NSLog(@"再次购买");
            }
            break;
        default:
            break;
    }
}
-(void)pushOrderMessage:(OrderListModel*)model{
    if ([model.commType integerValue]==1) {
        OrderMessageViewController *controller=[[OrderMessageViewController alloc]init];
        controller.model=model;
        controller.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushOrderMessage:[OrderListModel mj_objectWithKeyValues:self.listArray[indexPath.row]]];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderListModel *model=[OrderListModel mj_objectWithKeyValues:self.listArray[indexPath.row]];
    if ([model.status integerValue]==0) {
        return Height_Pt(222)+Height_Pt(305)*model.list.count;
    }else if([model.status integerValue]==1){
        if ([model.status integerValue]==1 &&[model.commType integerValue]!=1) {
            return Height_Pt(222)+Height_Pt(305)*model.list.count;
        }
    }
    return Height_Pt(320)+Height_Pt(305)*model.list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return Height_Pt(40);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(void)loadHttpData{
    Weakify(self);
    if ([[Acount shareManager] isSignInWithNavigationController:self.navigationController]) {
        [Master HttpPostRequestByParams:@{@"clientId":[Acount shareManager].id,@"status":[NSString stringWithFormat:@"%ld",_index]} url:mlqqm serviceCode:ddlb Success:^(id json) {
            [_listArray removeAllObjects];
            _listArray=[[NSMutableArray alloc]initWithArray:json[@"info"]];
            if (_listArray.count>0) {
                _nilView.hidden=YES;
            }
            [Wself.tableView.mj_header endRefreshing];
            [Wself.tableView reloadData];
        } Failure:nil andNavigation:self.navigationController];
    }else{
        [Wself.tableView.mj_header endRefreshing];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
