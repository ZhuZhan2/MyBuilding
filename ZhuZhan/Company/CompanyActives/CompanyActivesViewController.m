//
//  CompanyActivesViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/26.
//
//

#import "CompanyActivesViewController.h"
#import "CompanyProjectController.h"
#import "CompanyProductController.h"

@interface CompanyActivesViewController ()
@property(nonatomic,strong)CompanyProjectController* companyProjectController;
@property(nonatomic,strong)CompanyProductController* companyProductController;
@property(nonatomic,strong)NSArray* controllers;
@end

@implementation CompanyActivesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavi];
    self.tableView.backgroundColor = AllBackLightGratColor;
    [self initStageChooseViewWithStages:@[@"发布的项目",@"发布的产品"] numbers:nil underLineIsWhole:YES normalColor:AllLightGrayColor highlightColor:BlueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavi{
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    self.title = @"企业动态";
}

- (void)stageBtnClickedWithNumber:(NSInteger)stageNumber{
    [self.controllers enumerateObjectsUsingBlock:^(RKController* controller, NSUInteger idx, BOOL *stop) {
        BOOL isSelected = idx == stageNumber;
        CGFloat y = 64+46;
        [controller setViewFrame:CGRectMake(0, y, kScreenWidth, kScreenHeight-y)];
        
        UIView* view = controller.view;
        if (isSelected) {
            [self.view insertSubview:view atIndex:0];
        }else{
            [view removeFromSuperview];
        }
    }];
}

- (NSArray *)controllers{
    if (!_controllers) {
        _controllers = @[self.companyProjectController,self.companyProductController];
    }
    return _controllers;
}

- (CompanyProjectController *)companyProjectController{
    if (!_companyProjectController) {
        _companyProjectController = [[CompanyProjectController alloc] initWithNavi:self.navigationController targetId:self.targetId];
    }
    return _companyProjectController;
}

- (CompanyProductController *)companyProductController{
    if (!_companyProductController) {
        _companyProductController = [[CompanyProductController alloc] initWithNavi:self.navigationController targetId:self.targetId];
    }
    return _companyProductController;
}
@end
