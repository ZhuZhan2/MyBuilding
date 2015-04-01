//
//  RKDemandDetailController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/19.
//
//

#import "ChatBaseViewController.h"
#import "DemandDetailViewCell.h"
#import "ProvidePriceInfoController.h"
#import "QuotesModel.h"

@protocol RKDemandDetailControllerDelegate <NSObject>
-(void)demandDetailControllerLeftBtnClicked;
@end

@interface RKDemandDetailController : ChatBaseViewController<DemandDetailViewCellDelegate>{
@protected
    NSMutableArray* _detailModels;
}
@property(nonatomic,strong)NSMutableArray* detailModels;
@property(nonatomic,weak)UIViewController* superViewController;
@property(nonatomic,strong)AskPriceModel *askPriceModel;
@property(nonatomic,strong)QuotesModel *quotesModel;
@property(nonatomic,weak)id<RKDemandDetailControllerDelegate>delegate;
@property(nonatomic)BOOL isFinish;
@end
