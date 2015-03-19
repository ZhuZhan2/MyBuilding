//
//  CompanyTotalViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14/10/23.
//
//

#import "CompanyTotalViewController.h"
#import "CompanyViewController.h"
#import "MoreCompanyViewController.h"
#import "CompanyApi.h"
#import "CompanyModel.h"
#import "ErrorView.h"
#import "LoadingView.h"
#import "LoginSqlite.h"
@interface CompanyTotalViewController ()
@property(nonatomic,strong)CompanyViewController* companyVC;
@property(nonatomic,strong)MoreCompanyViewController* moreCompanyVC;
@property(nonatomic,strong)LoadingView *loadingView;
@end

@implementation CompanyTotalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view];
    [self firstNetWork];
}

-(void)firstNetWork{
    if(![[LoginSqlite getdata:@"token"] isEqualToString:@""]){
        if ([[LoginSqlite getdata:@"userType"] isEqualToString:@"Company"]) {
            [CompanyApi GetCompanyDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
                if (!error) {
                    self.companyVC=[[CompanyViewController alloc]init];
                    self.companyVC.model = posts[0];
                    self.companyVC.needNoticeView=NO;
                    self.companyVC.navigationItem.hidesBackButton=YES;
                    [self.navigationController pushViewController:self.companyVC animated:NO];
                }else{
                    [LoginAgain AddLoginView:NO];
                }
                [self removeMyLoadingView];
            } companyId:[LoginSqlite getdata:@"userId"] noNetWork:^{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64-49) superView:self.view reloadBlock:^{
                    [self firstNetWork];
                }];
            }];
        }else{
            [CompanyApi HasCompanyWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    NSLog(@"===>%@",posts[0][@"exists"]);
                    if([[NSString stringWithFormat:@"%@",posts[0][@"exists"]] isEqualToString:@"0"]){
                        self.moreCompanyVC=[[MoreCompanyViewController alloc]init];
                        self.moreCompanyVC.navigationItem.hidesBackButton=YES;
                        [self.navigationController pushViewController:self.moreCompanyVC animated:NO];
                    }else{
                        [CompanyApi GetCompanyDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
                            if(!error){
                                self.companyVC=[[CompanyViewController alloc]init];
                                self.companyVC.model = posts[0];
                                self.companyVC.needNoticeView=YES;
                                self.companyVC.navigationItem.hidesBackButton=YES;
                                [self.navigationController pushViewController:self.companyVC animated:NO];
                            }else{
                                [LoginAgain AddLoginView:NO];
                            }
                            [self removeMyLoadingView];
                        } companyId:posts[0][@"companyId"] noNetWork:^{
                            [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64-49) superView:self.view reloadBlock:^{
                                [self firstNetWork];
                            }];
                        }];
                    }
                }
            } noNetWork:^{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64-49) superView:self.view reloadBlock:^{
                    [self firstNetWork];
                }];
            }];
        }
    }else{
        self.moreCompanyVC=[[MoreCompanyViewController alloc]init];
        self.moreCompanyVC.navigationItem.hidesBackButton=YES;
        [self.navigationController pushViewController:self.moreCompanyVC animated:NO];
    }
}

-(void)removeMyLoadingView{
    [LoadingView removeLoadingView:self.loadingView];
    self.loadingView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
