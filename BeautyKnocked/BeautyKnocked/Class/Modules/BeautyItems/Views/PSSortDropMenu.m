//
//  PSSortDropMenu.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/24.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "PSSortDropMenu.h"

@interface PSSortDropMenu ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PSSortDropMenu

- (id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
        [self setupContent];
    }
    return self;
}

- (void)setupContent {
    
    //alpha 0.0  白色   alpha 1 ：黑色   alpha 0～1 ：遮罩颜色，逐渐
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    
    self.tableView = ({
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = Height_Pt(90);
        tableView.scrollEnabled = NO;
        tableView.backgroundColor = [UIColor whiteColor];
        
        self.tableView = tableView;
        self.tableView;
    });
    self.tableView.frame = CGRectMake(0, _top_heeight, Width, 0);
    
}

-(void)setTop_heeight:(CGFloat)top_heeight {
    _top_heeight = top_heeight;
}

-(void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"entirySortIdentifier"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:Font_Size(45)];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // delete all accessoryView
    for (UITableViewCell *cell in tableView.visibleCells) {
        cell.accessoryView = nil;
        [cell.textLabel setTextColor:[UIColor blackColor]];
    }
    // did selected cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // add accessoryView
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width_Pt(44), Height_Pt(30))];
    [imgView setImage:[UIImage imageNamed:@"paixuxialaxuanzhong"]];
    cell.accessoryView = imgView;
    [cell.textLabel setTextColor:[UIColor colorWithHexString:@"#E0C070"]];
    
    [self disMissView];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}


#pragma mark show
- (void)showInView:(UIView *)view {
    if (!view) {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:self.tableView];
    
    
    [UIView animateWithDuration:0.2f animations:^{
        
        self.alpha = 0.3;
        
        [self.tableView setFrame:CGRectMake(0, _top_heeight, Width, Height_Pt(90) * 3)];
//        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(Height_Pt(90) * 3);
//        }];
        
    } completion:nil];
    
    
}

#pragma mark dismiss
- (void)disMissView {
    
    [UIView animateWithDuration:0.2f
                     animations:^{
                         
                         self.alpha = 0.0;
                         
                         [self.tableView setFrame:CGRectMake(0, _top_heeight, Width, 0)];
//                         [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//                             make.height.mas_equalTo(0);
//                         }];
                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                         [self.tableView removeFromSuperview];
                         
                         if ([self.delegate respondsToSelector:@selector(haveDismiss)]) {
                             [self.delegate haveDismiss];
                         }

                     }];

}

-(void)hideView {
    [self disMissView];
}


@end
