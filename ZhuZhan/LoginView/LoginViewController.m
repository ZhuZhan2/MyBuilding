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
    self.view.backgroundColor = RGBCOLOR(85, 103, 166);
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundImage:[GetImagePath getImagePath:@"登录_03"] forState:UIControlStateNormal];
    [cancelBtn setFrame:CGRectMake(20, 30, 26, 26)];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 110, 74, 77)];
    [bgImage setImage:[GetImagePath getImagePath:@"登录_07"]];
    [self.view addSubview:bgImage];
    
    UIImageView *bgImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(21.5, 230, 277, 200)];
    [bgImage2 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:bgImage2];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 277, 41)];
    [imageView setImage:[GetImagePath getImagePath:@"登录_19"]];
    [bgImage2 addSubview:imageView];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42, 277, 41)];
    [imageView2 setImage:[GetImagePath getImagePath:@"登录_19"]];
    [bgImage2 addSubview:imageView2];
    
    //UIImageView *imageView3
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
