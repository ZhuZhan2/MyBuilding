//
//  ProviderContractsController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/20.
//
//

#import "OtherContractsBaseController.h"
#import "ContractsMainClauseModel.h"

@interface ProviderContractsController : OtherContractsBaseController
@property (nonatomic, strong)ContractsMainClauseModel* mainClauseModel;
@end