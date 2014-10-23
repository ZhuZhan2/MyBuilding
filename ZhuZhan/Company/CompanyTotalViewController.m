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
@interface CompanyTotalViewController ()
@property(nonatomic,strong)CompanyViewController* companyVC;
@property(nonatomic,strong)MoreCompanyViewController* moreCompanyVC;
@end

@implementation CompanyTotalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CompanyApi GetMyCompanyWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            if([posts[0] isKindOfClass:[CompanyModel class]]){
                self.companyVC=[[CompanyViewController alloc]init];
                self.companyVC.model = posts[0];
                self.companyVC.navigationItem.hidesBackButton=YES;
                [self.navigationController pushViewController:self.companyVC animated:NO];
            }else{
                NSLog(@"没有公司");
            }
        }
    }];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
