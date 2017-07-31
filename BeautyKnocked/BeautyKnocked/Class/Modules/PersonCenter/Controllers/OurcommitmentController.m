//
//  OurcommitmentController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/31.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "OurcommitmentController.h"

@interface OurcommitmentController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *headTitleView;
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation OurcommitmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"承诺书";
    self.view.backgroundColor=[UIColor colorWithHexString:@"#F7F7F7"];
    
    [self initializeViews];
    [self addViews];
    [self addConstraints];
}

-(void)initializeViews {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    //scrollView.contentSize = CGSizeMake(Width, Height_Pt(3000));
    
    _imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"book.jpg"]];
    [_scrollView addSubview:_imgView];
}

-(void)addViews {
    [self.view addSubview:_scrollView];
    
    [_scrollView addSubview:self.headTitleView];
    [_scrollView addSubview:_imgView];
}

-(void)addConstraints {
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.headTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(_scrollView);
        make.height.mas_equalTo(Height_Pt(195));
        make.width.equalTo(_scrollView);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headTitleView.mas_bottom);
        make.left.and.right.and.bottom.equalTo(_scrollView);
        make.height.mas_equalTo(Height_Pt(3000));
        make.width.equalTo(_scrollView);
    }];
}
-(UIView *)headTitleView {
    if (!_headTitleView) {
        _headTitleView = [[UIView alloc] init];
        _headTitleView.backgroundColor = [UIColor clearColor];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:Font_Size(52)];
        titleLabel.text = @"美丽敲敲门消费者承诺书";
        
        UILabel *descrLabel = [[UILabel alloc] init];
        descrLabel.textColor = [UIColor lightGrayColor];
        descrLabel.font = [UIFont systemFontOfSize:Font_Size(39)];
        descrLabel.text = @"2017-05-22 美丽敲敲门";
        
        [_headTitleView addSubview:titleLabel];
        [_headTitleView addSubview:descrLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(_headTitleView).with.offset(Width_Pt(40));
        }];
        
        [descrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_left);
            make.top.equalTo(titleLabel.mas_bottom).with.offset(Height_Pt(30));
            make.bottom.equalTo(_headTitleView).with.offset( - Height_Pt(30));
        }];

    }
    return _headTitleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
