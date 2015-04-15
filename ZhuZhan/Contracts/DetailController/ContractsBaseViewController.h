//
//  ContractsBaseViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/30.
//
//

#import "ChatBaseViewController.h"
@class RKContractsStagesView;
@class ContractsTradeCodeView;
@interface ContractsBaseViewController : ChatBaseViewController
@property (nonatomic, strong)RKContractsStagesView* stagesView;
@property (nonatomic, strong)ContractsTradeCodeView* tradeCodeView;
@end
