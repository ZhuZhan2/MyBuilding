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
//只允许全部佣金列表页
@property (nonatomic, strong)ContractsMainClauseModel* mainClauseModel;

//只允许在消息列表传,主条款id
@property (nonatomic, copy)NSString* contractId;

//详细阶段的数据,只有在非主条款页面进入主条款页面才允许传
@property (nonatomic, strong)NSMutableArray* contractsStagesViewData;
@end
