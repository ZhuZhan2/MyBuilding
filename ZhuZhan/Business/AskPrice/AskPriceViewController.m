//
//  AskPriceViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/16.
//
//

#import "AskPriceViewController.h"
#import "RKStageChooseView.h"
@interface AskPriceViewController ()

@end

@implementation AskPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    //[self initTableView];
    [self initStageChooseView];
}

-(void)initStageChooseView{
    UIView* view=[RKStageChooseView stageChooseViewWithStages:
                  @[@"全部",@"进行中",@"已采纳",@"已关闭"]];
    CGRect frame=view.frame;
    frame.origin=CGPointMake(0, 64);
    view.frame=frame;
    
    [self.view addSubview:view];
}

-(void)initNavi{
    self.title=@"询价需求表";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}
@end
