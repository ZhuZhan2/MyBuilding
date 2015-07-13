//
//  MyPointDetailViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/13.
//
//

#import "MyPointDetailViewController.h"

@interface MyPointDetailViewController ()

@end

@implementation MyPointDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    // Do any additional setup after loading the view.
}

/**
 *  导航栏设置
 */
- (void)initNavi{
    self.title = @"积分明细";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}
@end
