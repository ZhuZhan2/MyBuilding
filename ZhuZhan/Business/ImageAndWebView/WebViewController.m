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
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,25,22)];
    [button setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate =self;
    NSString *content =[NSString stringWithFormat:
                        @"<html>"
                        "<body style=' margin:0; width:%fpx; height:%fpx; display:table-cell; text-align:center; vertical-align:middle;'>"
                        "<img src=%@ style='max-width:320px;'>"
                        "</img>"
                        "</body>"
                        "</html>"
                        ,self.view.frame.size.width,self.view.frame.size.height-64 ,self.url];
    [self.webView loadHTMLString:content baseURL:nil];
    [self.view addSubview:self.webView];
    
    NSLog(@"范俊url==%@",self.url);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
