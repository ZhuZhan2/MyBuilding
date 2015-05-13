//
//  ContractsBaseViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/30.
//
//

#import "ChatBaseViewController.h"
#import "ContractsListSingleModel.h"
@class RKContractsStagesView;
@class ContractsTradeCodeView;
@interface ContractsBaseViewController : ChatBaseViewController<UIActionSheetDelegate,UIAlertViewDelegate>{
    @protected
    UIView* _stagesView;
    ContractsTradeCodeView* _tradeCodeView;
    NSMutableArray* _cellViews;
}
@property (nonatomic, strong)UIView* stagesView;
@property (nonatomic, strong)ContractsTradeCodeView* tradeCodeView;
@property (nonatomic, strong)ContractsListSingleModel* listSingleModel;
@property (nonatomic, strong)NSMutableArray* cellViews;

-(void)initStagesView;
-(void)initTradeCodeView;
-(void)sucessPost;
-(NSArray*)stylesWithNumber:(NSInteger)number count:(NSInteger)count;
@end
