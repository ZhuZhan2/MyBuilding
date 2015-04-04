//
//  DemanDetailViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import "ChatBaseViewController.h"
#import "RKDemandDetailController.h"
#import "RKDemandChatController.h"
#import "AskPriceModel.h"
#import "AskPriceApi.h"
#import "QuotesModel.h"
@interface DemanDetailViewController : ChatBaseViewController<RKDemandDetailControllerDelegate>{
@protected
    RKDemandDetailController* _detailController;
    RKDemandChatController* _chatController;
}
@property(nonatomic,strong)AskPriceModel *askPriceModel;
@property(nonatomic,strong)QuotesModel *quotesModel;
@property(nonatomic,strong)NSString *titleStr;
@end
