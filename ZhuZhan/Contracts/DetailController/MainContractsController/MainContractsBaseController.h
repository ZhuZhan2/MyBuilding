//
//  MainContractsBaseController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/15.
//
//

#import "ContractsBaseViewController.h"
#import "ContractsMainClauseModel.h"
@interface MainContractsBaseController : ContractsBaseViewController
@property (nonatomic, strong)ContractsMainClauseModel* mainClauseModel;

//主条款id
@property (nonatomic, copy)NSString* contractId;
//详细阶段的数据
@property (nonatomic, strong)NSMutableArray* contractsStagesViewData;
@end
