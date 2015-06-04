//
//  SearchMaterialViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/5.
//
//

#import "SearchMaterialViewController.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "LoginSqlite.h"
#import "MarketApi.h"
#import "PublishRequirementViewController.h"
@interface SearchMaterialViewController ()

@end

@implementation SearchMaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 50, 22)];
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)rightBtnClick{
    PublishRequirementViewController* vc = [[PublishRequirementViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
