//
//  IntroduceUsController.m
//  BeautyKnocked
//
//  Created by zhongweiping on 2017/5/31.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "IntroduceUsController.h"
#import <WebKit/WebKit.h>
@interface IntroduceUsController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;


@end

@implementation IntroduceUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"介绍我们";
    self.edgesForExtendedLayout=UIRectEdgeNone;
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseuRL = [NSURL fileURLWithPath:path];
    NSString *htmlpath = [[NSBundle mainBundle] pathForResource:@"introduce" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlpath encoding:NSUTF8StringEncoding error:nil];
    
    [self.webView loadHTMLString:htmlString baseURL:baseuRL];
    
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    // fontSize
    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '220%'" completionHandler:nil];
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
