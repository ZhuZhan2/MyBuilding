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
@interface WebViewController ()<UIWebViewDelegate,UIDocumentInteractionControllerDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)NSURL *path;
@property(nonatomic,strong)UIDocumentInteractionController *documentInteractionController;
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
    self.webView.scalesPageToFit = YES;
    
//    if([self.type isEqualToString:@"pdf"]){
//        NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)self.url, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]",  kCFStringEncodingUTF8 ));
//        NSString* htmlPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"source.bundle/web/viewer.html"];
//        NSString *new = [NSString stringWithFormat:@"%@?file=%@",htmlPath,encodedString];
//        NSURL* url = [NSURL URLWithString:new];
//        NSURLRequest* request = [NSURLRequest requestWithURL:url];
//        [self.webView loadRequest:request];
//    }else{
//        NSURL* url = [NSURL URLWithString:self.url];
//        NSURLRequest* request = [NSURLRequest requestWithURL:url];
//        [self.webView loadRequest:request];
//    }
    
    if([[self.type substringToIndex:2] isEqualToString:@"xl"]||[[self.type substringToIndex:2] isEqualToString:@"do"]){
        //[self down];
        NSURL* url = [NSURL URLWithString:self.url];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }else if ([self.type isEqualToString:@"pdf"]){
        //[self downPDF];
        NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)self.url, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]",  kCFStringEncodingUTF8 ));
        NSString* htmlPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"source.bundle/web/viewer.html"];
        NSString *new = [NSString stringWithFormat:@"%@?file=%@",htmlPath,encodedString];
        NSURL* url = [NSURL URLWithString:new];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }else{
        NSString *content =[NSString stringWithFormat:
                            @"<html>"
                            "<meta content='width=device-width,initial-scale=1.0,minimum-scale=.5,maximum-scale=3' name='viewport'>"
                            "<body style=' margin:0; width:%fpx; height:%fpx; display:table-cell; text-align:center; vertical-align:middle;'>"
                            "<img src=%@ style='max-width:320px;'>"
                            "</body>"
                            "</html>"
                             ,self.view.frame.size.width,self.view.frame.size.height-64,self.url];
        [self.webView loadHTMLString:content baseURL:nil];
    }
    [self.view addSubview:self.webView];
}

-(void)back{
//    if([self.type isEqualToString:@"pdf"]){
//        NSFileManager *fileManage = [NSFileManager defaultManager];
//        [fileManage removeItemAtURL:self.path error:nil];
//    }
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

-(void)downPDF{
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            return [documentsDirectoryURL URLByAppendingPathComponent:self.name];
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            self.path = filePath;
            [self openPDF:filePath];
        }];
        [downloadTask resume];
}

-(void)openPDF:(NSURL *)url{
    if (url) {
        // Initialize Document Interaction Controller
        self.documentInteractionController = [UIDocumentInteractionController
                                              interactionControllerWithURL:url];
        // Configure Document Interaction Controller
        [self.documentInteractionController setDelegate:self];
        // Preview PDF
        [self.documentInteractionController presentPreviewAnimated:YES];
    }
}

- (UIViewController *) documentInteractionControllerViewControllerForPreview:
(UIDocumentInteractionController *) controller {
    return self;
}
@end
