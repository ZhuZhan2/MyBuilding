//
//  MyFocusViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/22.
//
//

#import "MyFocusViewController.h"
#import "MyFocusProjectController.h"
#import "MyFocusUserController.h"
#import "MyFocusProductController.h"
#import "MyFocusCompanyController.h"
@interface MyFocusViewController ()
@property(nonatomic,strong)MyFocusProjectController* myFocusProjectController;
@property(nonatomic,strong)MyFocusUserController* myFocusUserController;
@property(nonatomic,strong)MyFocusProductController* myFocusProductController;
@property(nonatomic,strong)MyFocusCompanyController* myFocusCompanyController;
@property(nonatomic,strong)NSArray* controllers;
@end

@implementation MyFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initStageChooseViewWithStages:@[@"项目",@"人脉",@"产品",@"企业"] numbers:nil underLineIsWhole:YES normalColor:AllLightGrayColor highlightColor:BlueColor];
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
        _controllers = @[self.myFocusProjectController,self.myFocusUserController,self.myFocusProductController,self.myFocusCompanyController];
    }
    return _controllers;
}

- (MyFocusProjectController *)myFocusProjectController{
    if (!_myFocusProjectController) {
        _myFocusProjectController = [[MyFocusProjectController alloc] initWithNavi:self.navigationController];
    }
    return _myFocusProjectController;
}

- (MyFocusUserController *)myFocusUserController{
    if (!_myFocusUserController) {
        _myFocusUserController = [[MyFocusUserController alloc] initWithNavi:self.navigationController];
    }
    return _myFocusUserController;
}
- (MyFocusProductController *)myFocusProductController{
    if (!_myFocusProductController) {
        _myFocusProductController = [[MyFocusProductController alloc] initWithNavi:self.navigationController];
    }
    return _myFocusProductController;
}

- (MyFocusCompanyController *)myFocusCompanyController{
    if (!_myFocusCompanyController) {
        _myFocusCompanyController = [[MyFocusCompanyController alloc] initWithNavi:self.navigationController];
    }
    return _myFocusCompanyController;
}
@end
