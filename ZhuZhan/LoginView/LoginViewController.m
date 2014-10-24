//
//  LoginViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-17.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "RegistViewController.h"
#import "LoginSqlite.h"
#import "MD5.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
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
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 321, 568)];
    [bgImgView setImage:[GetImagePath getImagePath:@"注册"]];
    [self.view addSubview:bgImgView];
    
    UIImageView *headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(111, 80, 98.5, 98.5)];
    [headerImgView setImage:[GetImagePath getImagePath:@"登录_03"]];
    UIImageView *roundView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 89, 89)];
    roundView.layer.masksToBounds = YES;
    roundView.layer.cornerRadius = 45;
    [roundView setImage:nil];
    [headerImgView addSubview:roundView];
    [self.view addSubview:headerImgView];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
