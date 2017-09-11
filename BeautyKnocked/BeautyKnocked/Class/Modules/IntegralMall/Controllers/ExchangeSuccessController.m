//
//  ExchangeSuccessController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/6/8.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "ExchangeSuccessController.h"
#import "SuccessFooterView.h"
#import "ExchangeRecordingController.h"
#import "IntegralMallController.h"

static NSString *const reuseIdentifier = @"ExchangeSuccess";

@interface ExchangeSuccessController ()<SuccessFooterViewDelegate>
@property (nonatomic, strong) UIImageView *successImgView;
@property (nonatomic, strong) SuccessFooterView *successFooter;
@end

@implementation ExchangeSuccessController

-(instancetype)initWithStyle:(UITableViewStyle)style{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.scrollEnabled = NO;
    self.title=@"兑换成功";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 3;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = nil;
     if (!cell) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
     }
     
     if (indexPath.section == 0) {
         [cell.contentView addSubview:self.successImgView];
         [self.successImgView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.edges.equalTo(cell.contentView);
         }];
     }else {
         NSArray *titles = @[@"兑换订单编号",@"优惠券金额",@"兑换积分"];
         NSArray *texts = @[@"42215645656",@"¥60",@"400积分"];
         
         cell.textLabel.text = titles[indexPath.row];
         cell.detailTextLabel.text = texts[indexPath.row];
         
         cell.detailTextLabel.textColor = indexPath.row > 0 ? [UIColor redColor] : [UIColor lightGrayColor];
         cell.textLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
         cell.detailTextLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
     }
     return cell;
 }

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        SuccessFooterView *footer = [[SuccessFooterView alloc] init];
        footer.delegate = self;
        return footer;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return Height_Pt(504);
    }
    return Height_Pt(160);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return Height_Pt(24);
    }
    return Height_Pt(400);
}

-(UIImageView *)successImgView {
    if (!_successImgView) {
        _successImgView = [[UIImageView alloc] init];
        [_successImgView setImage:[UIImage imageNamed:@"duihuanbeijing"]];
    }
    return _successImgView;
}

#pragma mark SuccessFooterViewDelegate
-(void)successFooterViewClicked:(NSUInteger)index {
    if (index == 1) {
        NSArray *temArray = self.navigationController.viewControllers;
        for (UIViewController *temVC in temArray){
            if ([temVC isKindOfClass:[IntegralMallController class]])
            {
                [self.navigationController popToViewController:temVC animated:YES];
            }
        }
    }else if (index == 2) {
        ExchangeRecordingController *recordingController = [[ExchangeRecordingController alloc] init];
        [self.navigationController pushViewController:recordingController animated:YES];
    }
}

@end
