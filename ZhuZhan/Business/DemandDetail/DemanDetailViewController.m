//
//  DemanDetailViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import "DemanDetailViewController.h"

@interface DemanDetailViewController ()

@end

@implementation DemanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initStageChooseViewWithStages:@[@"报价",@"对话"]];
}

-(void)initNavi{
    self.title=@"买家的用户名，懂？";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithText:@"发起"];
}
@end
