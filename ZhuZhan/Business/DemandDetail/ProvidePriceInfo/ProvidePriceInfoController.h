//
//  ProvidePriceInfoController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/20.
//
//

#import "ChatBaseViewController.h"
#import "AskPriceModel.h"
#import "QuotesModel.h"
@protocol ProvidePriceInfoControllerDelegate <NSObject>
-(void)backAndLoad;
@end

@interface ProvidePriceInfoController : ChatBaseViewController
@property(nonatomic,strong)AskPriceModel *askPriceModel;

@property(nonatomic,strong)QuotesModel *quotesModel;
@property(nonatomic)BOOL isFirstQuote;
@property(nonatomic,weak)id<ProvidePriceInfoControllerDelegate>delegate;
@end
