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
@interface CompanyTotalViewController ()
@property(nonatomic,strong)CompanyViewController* companyVC;
@property(nonatomic,strong)MoreCompanyViewController* moreCompanyVC;
@end

@implementation CompanyTotalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self firstNetWork];
    // Do any additional setup after loading the view.
}

-(void)firstNetWork{
    [CompanyApi GetMyCompanyWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            if([posts[0] isKindOfClass:[CompanyModel class]]){
                self.companyVC=[[CompanyViewController alloc]init];
                self.companyVC.model = posts[0];
                self.companyVC.navigationItem.hidesBackButton=YES;
                [self.navigationController pushViewController:self.companyVC animated:NO];
            }else{
                self.moreCompanyVC=[[MoreCompanyViewController alloc]init];
                self.moreCompanyVC.navigationItem.hidesBackButton=YES;
                [self.navigationController pushViewController:self.moreCompanyVC animated:NO];
            }
        }
    } noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64-49) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
