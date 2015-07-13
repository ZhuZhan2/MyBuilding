//
//  MyPointViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/13.
//
//

#import "MyPointViewController.h"

@interface MyPointViewController ()

@end

@implementation MyPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

/**
 *  导航栏设置
 */
- (void)initNavi{
    self.title = @"我的积分";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithText:@"积分明细"];
}

/**
 *  右按钮被点击
 */
- (void)rightBtnClicked{
    
}
@end
