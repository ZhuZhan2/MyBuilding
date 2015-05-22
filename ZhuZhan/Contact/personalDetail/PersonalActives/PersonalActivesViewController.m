//
//  PersonalActivesViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/22.
//
//

#import "PersonalActivesViewController.h"
#import "PersonalProjectController.h"
#import "PersonalProductController.h"
#import "PersonalInfoController.h"
@interface PersonalActivesViewController ()
@property(nonatomic,strong)PersonalProjectController* personalProjectController;
@property(nonatomic,strong)PersonalProductController* personalProductController;
@property(nonatomic,strong)PersonalInfoController* personalInfoController;
@property(nonatomic,strong)NSArray* controllers;
@end

@implementation PersonalActivesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initStageChooseViewWithStages:@[@"发布的项目",@"发布的产品",@"个人背景"] numbers:nil underLineIsWhole:YES normalColor:AllLightGrayColor highlightColor:BlueColor];
}

-(void)initNavi{
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    self.title = @"我的关注";
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
        _controllers = @[self.personalProjectController,self.personalProductController,self.personalInfoController];
    }
    return _controllers;
}

- (PersonalProjectController *)personalProjectController{
    if (!_personalProjectController) {
        _personalProjectController = [[PersonalProjectController alloc] initWithNavi:self.navigationController targetId:self.targetId];
    }
    return _personalProjectController;
}

- (PersonalProductController *)personalProductController{
    if (!_personalProductController) {
        _personalProductController = [[PersonalProductController alloc] initWithNavi:self.navigationController targetId:self.targetId];
    }
    return _personalProductController;
}
- (PersonalInfoController *)personalInfoController{
    if (!_personalInfoController) {
        _personalInfoController = [[PersonalInfoController alloc] initWithNavi:self.navigationController targetId:self.targetId];
    }
    return _personalInfoController;
}
@end
