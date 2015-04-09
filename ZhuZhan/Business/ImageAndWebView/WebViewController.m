//
//  WebViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/3.
//
//

#import "WebViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
@interface WebViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)NSURL *path;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,25,22)];
    [button setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    NSLog(@"%@",self.name);
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate =self;
    self.webView.scrollView.bounces=NO;
    if([self.type isEqualToString:@"docx"]||[self.type isEqualToString:@"xlsx"]){
        self.webView.scalesPageToFit=YES;
        [self down];
    }else{
        NSString *content =[NSString stringWithFormat:
                            @"<html>"
                            "<body style=' margin:0; width:%fpx; height:%fpx; display:table-cell; text-align:center; vertical-align:middle;'>"
                            "<img src=%@ style='max-width:320px;'>"
                            "</img>"
                            "</body>"
                            "</html>"
                            ,self.view.frame.size.width,self.view.frame.size.height-64 ,self.url];
        [self.webView loadHTMLString:content baseURL:nil];
    }
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
//    NSFileManager *fileManage = [NSFileManager defaultManager];
//    [fileManage removeItemAtURL:self.path error:nil];
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


-(void)down{
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
//    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        return [documentsDirectoryURL URLByAppendingPathComponent:self.name];
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        NSURLRequest *request = [NSURLRequest requestWithURL:filePath];
//        self.path = filePath;
//        [self.webView loadRequest:request];
//    }];
//    [downloadTask resume];
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            if([self.type isEqualToString:@"docx"]){
                [self.webView loadData:(NSData *)responseObject MIMEType:@"application/vnd.openxmlformats-officedocument.wordprocessingml.document" textEncodingName:@"UTF-8" baseURL:nil];
            }else if([self.type isEqualToString:@"xlsx"]){
                [self.webView loadData:(NSData *)responseObject MIMEType:@"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" textEncodingName:@"UTF-8" baseURL:nil];
            }else if([self.type isEqualToString:@"xls"]){
                [self.webView loadData:(NSData *)responseObject MIMEType:@"application/vnd.ms-excel	application/x-excel" textEncodingName:@"UTF-8" baseURL:nil];
            }else if ([self.type isEqualToString:@"doc"]){
                [self.webView loadData:(NSData *)responseObject MIMEType:@"application/msword" textEncodingName:@"UTF-8" baseURL:nil];
            }
        }
    }];
    [dataTask resume];

}
@end
