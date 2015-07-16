//
//  PointRuleViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/13.
//
//

#import "PointRuleViewController.h"

@interface PointRuleViewController ()
@property (nonatomic, strong)UIWebView* webView1;
@property (nonatomic, strong)UIWebView* webView2;
@end

@implementation PointRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initStageChooseViewWithStages:@[@"获得途径",@"注意事项"] numbers:nil underLineIsWhole:YES normalColor:AllLightGrayColor highlightColor:BlueColor];
    [self.view insertSubview:self.webView1 atIndex:0];
}

- (void)stageBtnClickedWithNumber:(NSInteger)stageNumber{
    
}

- (UIWebView *)webView1{
    if (!_webView1) {
        _webView1 = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.stageChooseView.frame), kScreenWidth, kScreenHeight-CGRectGetMaxY(self.stageChooseView.frame))];
        
        NSURL* url = [NSURL URLWithString:@"http://121.40.127.189:8090/wechat/integralAccess.html"];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        [_webView1 loadRequest:request];
    }
    return _webView1;
}

- (UIWebView *)webView2{
    if (!_webView2) {
        _webView2 = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.stageChooseView.frame), kScreenWidth, kScreenHeight-CGRectGetMaxY(self.stageChooseView.frame))];
        
        NSURL* url = [NSURL URLWithString:@"http://121.40.127.189:8090/wechat/integralNote.html"];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        [_webView2 loadRequest:request];
    }
    return _webView2;
}

/**
 *  导航栏设置
 */
- (void)initNavi{
    self.title = @"积分规则";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}
@end
