//
//  ProductViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-2.
//
//

#import "ProductViewController.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"产品";
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
    // Do any additional setup after loading the view.
}

//**********************************************************************
//**********************************************************************
//**********************************************************************

//**********************************************************************
//**********************************************************************
//**********************************************************************

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
