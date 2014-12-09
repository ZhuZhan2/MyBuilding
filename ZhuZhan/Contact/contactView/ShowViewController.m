//
//  PanViewController.m
//  ZhuZhan
//
//  Created by Jack on 14-8-28.
//
//

#import "ShowViewController.h"
#import "CommentApi.h"
#import "CompanyApi.h"
#import "ProjectStage.h"
#import "LoginSqlite.h"
#import "ContactModel.h"
#import "EGOImageView.h"
@interface ShowViewController ()
@property(nonatomic,strong)UIActivityIndicatorView* indicatorView;
@property(nonatomic,strong)UIView* bgVIew;
@end

@implementation ShowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    EGOImageView  *tempImageView= [[EGOImageView alloc] initWithPlaceholderImage:[GetImagePath getImagePath:@"bg001"]];
    tempImageView.frame = CGRectMake(0, 0, 280, 300);
    tempImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[LoginSqlite getdata:@"backgroundImage"]]];
    [self.view addSubview:tempImageView];
    
    
    EGOImageView *icon = [[EGOImageView alloc] initWithPlaceholderImage:[GetImagePath getImagePath:@"人脉_29a"]];
    icon.frame = CGRectMake(107.5, 50, 65, 65);
    icon.layer.cornerRadius = 32.5;//设置那个圆角的有多圆
    icon.layer.masksToBounds = YES;
    icon.userInteractionEnabled = YES;
    [tempImageView addSubview:icon];
    
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(0, 115, 280, 40)];
    userName.textAlignment = NSTextAlignmentCenter;
    userName.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:18];
    userName.textColor = [UIColor whiteColor];
    [tempImageView addSubview:userName];
    
    UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, 155, 280, 30)];
    message.textAlignment = NSTextAlignmentCenter;
    message.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    message.textColor = [UIColor whiteColor];
    [tempImageView addSubview:message];
    
    UIButton *visitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    visitBtn.frame =CGRectMake(70, 220, 60, 28);
    visitBtn.backgroundColor = [UIColor blackColor];
    [visitBtn setTitle:@"访问" forState:UIControlStateNormal];
    visitBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    visitBtn.layer.cornerRadius = 5;//设置那个圆角的有多圆
    visitBtn.layer.masksToBounds = YES;//设为NO去试试。设置YES是保证添加的图片覆盖视图的效果
    [visitBtn addTarget:self action:@selector(beginToVisitDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:visitBtn];
    visitBtn.alpha = 0.8;
    
    concernBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    concernBtn.frame = CGRectMake(150, 220, 75, 28);
    concernBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    concernBtn.backgroundColor = [UIColor blackColor];
    concernBtn.layer.cornerRadius = 5;//设置那个圆角的有多圆
    concernBtn.layer.masksToBounds = YES;//设为NO去试试。设置YES是保证添加的图片覆盖视图的效果
    [concernBtn addTarget:self action:@selector(gotoConcern) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:concernBtn];
    concernBtn.alpha = 0.8;
    
    [self loadIndicatorView];
    
    [CommentApi UserBriefInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            if(posts.count !=0){
                contactId = posts[0][@"userId"];
                icon.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,[ProjectStage ProjectStrStage:posts[0][@"userImage"]]]];
                userName.text = [ProjectStage ProjectStrStage:posts[0][@"userName"]];
                message.text = [NSString stringWithFormat:@"%@项目，%@动态",[ProjectStage ProjectStrStage:posts[0][@"projectsCount"]],[ProjectStage ProjectStrStage:posts[0][@"activesCount"]]];
                if([[ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",posts[0][@"isFocused"]]] isEqualToString:@"1"]){
                    [concernBtn setTitle:@"取消关注" forState:UIControlStateNormal];
                    isFoucsed = 1;
                }else{
                    [concernBtn setTitle:@"添加关注" forState:UIControlStateNormal];
                    isFoucsed = 0;
                }
                [self endIndicatorView];
            }
        }
    } userId:self.createdBy noNetWork:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadIndicatorView{
    self.bgVIew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 300)];
    self.bgVIew.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgVIew];
    self.indicatorView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicatorView.color=[UIColor blackColor];
    self.indicatorView.center=CGPointMake(140, self.bgVIew.frame.size.height*.5);
    [self.bgVIew addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
}

-(void)endIndicatorView{
    [self.indicatorView stopAnimating];
    [self.indicatorView removeFromSuperview];
    self.indicatorView=nil;
    [self.bgVIew removeFromSuperview];
    self.bgVIew = nil;
}

-(void)beginToVisitDetail{
    if([self.delegate respondsToSelector:@selector(gotoContactDetailView:)]){
        [self.delegate gotoContactDetailView:contactId];
    }
}

- (void)gotoConcern{
    if(![[LoginSqlite getdata:@"deviceToken"] isEqualToString:@""]){
        concernBtn.enabled = NO;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(isFoucsed == 0){
            [dic setValue:[LoginSqlite getdata:@"userId"] forKey:@"UserId"];
            [dic setValue:self.createdBy forKey:@"FocusId"];
            [dic setValue:@"Personal" forKey:@"FocusType"];
            [dic setValue:@"Personal" forKey:@"UserType"];
            [ContactModel AddfocusWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    [concernBtn setTitle:@"取消关注" forState:UIControlStateNormal];
                    isFoucsed = 1;
                    concernBtn.enabled = YES;
                }
            } dic:dic noNetWork:nil];
        }else{
            [dic setValue:[LoginSqlite getdata:@"userId"] forKey:@"UserId"];
            [dic setValue:self.createdBy forKey:@"FocusId"];
            [CompanyApi DeleteFocusWithBlock:^(NSMutableArray *posts, NSError *error) {
                if (!error) {
                    [concernBtn setTitle:@"添加关注" forState:UIControlStateNormal];
                    isFoucsed = 0;
                    concernBtn.enabled = YES;
                }
            } dic:dic noNetWork:nil];
        }
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.delegate = self;
        loginVC.needDelayCancel = YES;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{
    NSLog(@"已登录");
    [CommentApi UserBriefInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            if(posts.count !=0){
                if([[ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",posts[0][@"isFocused"]]] isEqualToString:@"1"]){
                    [concernBtn setTitle:@"取消关注" forState:UIControlStateNormal];
                    isFoucsed = 1;
                }else{
                    [concernBtn setTitle:@"添加关注" forState:UIControlStateNormal];
                    isFoucsed = 0;
                }
            }
            
            if(block){
                block();
            }
        }
    } userId:self.createdBy noNetWork:nil];
}

-(void)loginComplete{

}
@end
