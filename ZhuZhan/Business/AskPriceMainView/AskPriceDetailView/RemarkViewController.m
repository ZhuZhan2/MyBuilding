//
//  RemarkViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/23.
//
//

#import "RemarkViewController.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "YLLabel.h"
@interface RemarkViewController ()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *cutLine;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation RemarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,25,22)];
    [button setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.title=@"询价详情";
    
    [self.scrollView addSubview:self.titleLabel];
    [self.scrollView addSubview:self.cutLine];
    [self.scrollView addSubview:self.contentLabel];
    [self.view addSubview:self.scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _scrollView.pagingEnabled=YES;
    }
    return _scrollView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 15, 180, 16)];
        _titleLabel.text = @"询价说明";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        _cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 41, 320, 1)];
        _cutLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _cutLine;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
        _contentLabel.numberOfLines = 0;
        CGSize size =CGSizeMake(300,1000);
        CGSize actualsize =[self.remarkStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        _contentLabel.text = self.remarkStr;
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.frame =CGRectMake(10,51, 300, actualsize.height);
        self.scrollView.contentSize = CGSizeMake(320, actualsize.height+51);
    }
    return _contentLabel;
}
@end
