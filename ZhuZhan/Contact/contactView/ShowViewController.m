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
#import "IsFocusedApi.h"
#import "LoginModel.h"
#import "AddressBookApi.h"
@interface ShowViewController ()
@property(nonatomic,strong)UIActivityIndicatorView* indicatorView;
@property(nonatomic,strong)UIView* bgVIew;
@property(nonatomic,strong)NSString *name;
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
    
    UIImageView  *tempImageView= [[UIImageView alloc] init];
    tempImageView.frame = CGRectMake(0, 0, 280, 300);
    [self.view addSubview:tempImageView];
    
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:tempImageView.frame];
    bgImage.backgroundColor = [UIColor blackColor];
    bgImage.alpha = 0.3;
    [tempImageView insertSubview:bgImage atIndex:0];
    
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.frame = CGRectMake(107.5, 50, 65, 65);
    icon.layer.cornerRadius = 32.5;//设置那个圆角的有多圆
    icon.layer.masksToBounds = YES;
    icon.userInteractionEnabled = YES;
    [tempImageView addSubview:icon];
    
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(0, 115, 280, 40)];
    userName.textAlignment = NSTextAlignmentCenter;
    userName.font = [UIFont boldSystemFontOfSize:18];
    userName.textColor = [UIColor whiteColor];
    [tempImageView addSubview:userName];
    
    UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, 155, 280, 30)];
    message.textAlignment = NSTextAlignmentCenter;
    message.font = [UIFont boldSystemFontOfSize:14];
    message.textColor = [UIColor whiteColor];
    [tempImageView addSubview:message];
    
    UIButton *visitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if([[LoginSqlite getdata:@"userType"] isEqualToString:@"Personal"]){
        visitBtn.frame =CGRectMake(15, 220, 60, 28);
    }else{
        visitBtn.frame =CGRectMake(70, 220, 60, 28);
    }
    visitBtn.backgroundColor = [UIColor blackColor];
    [visitBtn setTitle:@"访问" forState:UIControlStateNormal];
    visitBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    visitBtn.layer.cornerRadius = 5;//设置那个圆角的有多圆
    visitBtn.layer.masksToBounds = YES;//设为NO去试试。设置YES是保证添加的图片覆盖视图的效果
    [visitBtn addTarget:self action:@selector(beginToVisitDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:visitBtn];
    visitBtn.alpha = 0.8;
    
    concernBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if([[LoginSqlite getdata:@"userType"] isEqualToString:@"Personal"]){
        concernBtn.frame = CGRectMake(95, 220, 75, 28);
    }else{
        concernBtn.frame =CGRectMake(160, 220, 60, 28);
    }
    concernBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    concernBtn.backgroundColor = [UIColor blackColor];
    concernBtn.layer.cornerRadius = 5;//设置那个圆角的有多圆
    concernBtn.layer.masksToBounds = YES;//设为NO去试试。设置YES是保证添加的图片覆盖视图的效果
    [concernBtn addTarget:self action:@selector(gotoConcern) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:concernBtn];
    concernBtn.alpha = 0.8;
    
    addFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addFriendBtn.frame = CGRectMake(190, 220, 75, 28);
    addFriendBtn.backgroundColor = [UIColor blackColor];
    [addFriendBtn setTitle:@"添加好友" forState:UIControlStateNormal];
    addFriendBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    addFriendBtn.layer.cornerRadius = 5;//设置那个圆角的有多圆
    addFriendBtn.layer.masksToBounds = YES;//设为NO去试试。设置YES是保证添加的图片覆盖视图的效果
    [addFriendBtn addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
    addFriendBtn.alpha = 0.8;
    
    gotoMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    gotoMessageBtn.frame = CGRectMake(190, 220, 75, 28);
    gotoMessageBtn.backgroundColor = [UIColor blackColor];
    [gotoMessageBtn setTitle:@"发送消息" forState:UIControlStateNormal];
    gotoMessageBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    gotoMessageBtn.layer.cornerRadius = 5;//设置那个圆角的有多圆
    gotoMessageBtn.layer.masksToBounds = YES;//设为NO去试试。设置YES是保证添加的图片覆盖视图的效果
    [gotoMessageBtn addTarget:self action:@selector(gotoMessageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    gotoMessageBtn.alpha = 0.8;
    
    
    [self loadIndicatorView];
    [LoginModel GetUserInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            ContactModel *model = posts[0];
            contactId = model.userId;
            [tempImageView sd_setImageWithURL:[NSURL URLWithString:model.personalBackground] placeholderImage:[GetImagePath getImagePath:@"默认主图01"]];
            [icon sd_setImageWithURL:[NSURL URLWithString:model.userImage] placeholderImage:[GetImagePath getImagePath:@"人脉_超大2"]];
            userName.text = model.userName;
            self.name = model.userName;
            message.text = [NSString stringWithFormat:@"%@项目，%@动态",model.projectNum,model.dynamicNum];
            if([model.isFocus isEqualToString:@"1"]){
                [concernBtn setTitle:@"取消关注" forState:UIControlStateNormal];
                isFoucsed = 1;
            }else{
                [concernBtn setTitle:@"添加关注" forState:UIControlStateNormal];
                isFoucsed = 0;
            }
            
            if([[LoginSqlite getdata:@"userType"] isEqualToString:@"Personal"]){
                if([model.isFriend isEqualToString:@"0"]){
                    [self.view addSubview:addFriendBtn];
                }else{
                    [self.view addSubview:gotoMessageBtn];
                }
            }
            [self endIndicatorView];
        }else{
            [LoginAgain AddLoginView:NO];
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
    if(![[LoginSqlite getdata:@"token"] isEqualToString:@""]){
        concernBtn.enabled = NO;
        if(isFoucsed == 0){
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:self.createdBy forKey:@"targetId"];
            [dic setObject:@"01" forKey:@"targetCategory"];
            [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    [concernBtn setTitle:@"取消关注" forState:UIControlStateNormal];
                    isFoucsed = 1;
                    concernBtn.enabled = YES;
                }else{
                    if([ErrorCode errorCode:error] == 403){
                        [LoginAgain AddLoginView:NO];
                    }else{
                        [ErrorCode alert];
                    }
                }
            } dic:dic noNetWork:^{
                [ErrorCode alert];
            }];
        }else{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:self.createdBy forKey:@"targetId"];
            [dic setObject:@"01" forKey:@"targetCategory"];
            [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
                if (!error) {
                    [concernBtn setTitle:@"添加关注" forState:UIControlStateNormal];
                    isFoucsed = 0;
                    concernBtn.enabled = YES;
                }else{
                    if([ErrorCode errorCode:error] == 403){
                        [LoginAgain AddLoginView:NO];
                    }else{
                        [ErrorCode alert];
                    }
                }
            } dic:dic noNetWork:^{
                [ErrorCode alert];
            }];
        }
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.delegate = self;
        loginVC.needDelayCancel = YES;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }
}

-(void)addFriend{
    if(![[LoginSqlite getdata:@"token"] isEqualToString:@""]){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:self.createdBy forKey:@"userId"];
        [AddressBookApi PostSendFriendRequestWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"发送成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                [addFriendBtn setTitle:@"已发送" forState:UIControlStateNormal];
                addFriendBtn.enabled = NO;
            }else{
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorCode alert];
                }
            }
        } dic:dic noNetWork:^{
            [ErrorCode alert];
        }];
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.delegate = self;
        loginVC.needDelayCancel = YES;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }
}

-(void)gotoMessageBtnAction{
    if([self.delegate respondsToSelector:@selector(gotoChatView:name:)]){
        [self.delegate gotoChatView:contactId name:self.name];
    }
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{
    NSLog(@"已登录");
    [LoginModel GetUserInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            ContactModel *model = posts[0];
            if([model.isFocus isEqualToString:@"1"]){
                [concernBtn setTitle:@"取消关注" forState:UIControlStateNormal];
                isFoucsed = 1;
            }else{
                [concernBtn setTitle:@"添加关注" forState:UIControlStateNormal];
                isFoucsed = 0;
            }
            
            if(block){
                block();
            }
        }else{
            [LoginAgain AddLoginView:NO];
        }
    } userId:self.createdBy noNetWork:nil];
}

-(void)loginComplete{

}
@end
