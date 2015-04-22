//
//  PDFViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/22.
//
//

#import "PDFViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
@interface PDFViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation PDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,25,22)];
    [button setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.title = self.name;
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate =self;
    self.webView.scrollView.bounces=NO;
    self.webView.scalesPageToFit = YES;
    
    NSString *urlstr = [NSString stringWithFormat:@"%s/api/contract/download?contractId=%@&fileType=%@",serverAddress,self.ID,self.type];
    NSLog(@"%@",urlstr);
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlstr, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]",  kCFStringEncodingUTF8 ));
    NSString* htmlPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"source.bundle/web/viewer.html"];
    NSString *new = [NSString stringWithFormat:@"%@?file=%@",htmlPath,encodedString];
    NSURL* url = [NSURL URLWithString:new];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}
@end
