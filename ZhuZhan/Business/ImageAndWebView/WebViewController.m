//
//  WebViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/3.
//
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate =self;
    NSString *content =[NSString stringWithFormat:
                        @"<html>"
                        "<body style='margin:0;display:table-cell; height:568px' >"
                        "<img src=%@ style='max-width:320px;vertical-align: middle;text-align: center'>"
                        "</img>"
                        "</body>"
                        "</html>"
                        , self.url];
    [self.webView loadHTMLString:content baseURL:nil];
    [self.view addSubview:self.webView];
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
