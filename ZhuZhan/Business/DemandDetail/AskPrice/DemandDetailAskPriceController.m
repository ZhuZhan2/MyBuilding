//
//  DemandDetailAskPriceController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/24.
//
//

#import "DemandDetailAskPriceController.h"
#import "DemandAskPriceDetailController.h"
#import "DemandAskPriceChatController.h"
@interface DemandDetailAskPriceController ()
@property(nonatomic,strong)NSMutableArray *showArr;
@end

@implementation DemandDetailAskPriceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadList];
}

-(void)loadList{
    [AskPriceApi GetQuotesListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            _detailController.detailModels = posts;
        }
    } providerId:self.quotesModel.a_loginId tradeCode:self.askPriceModel.a_tradeCode startIndex:0 noNetWork:nil];
}

-(RKDemandDetailController *)detailController{
    if (!_detailController) {
        _detailController=[[DemandAskPriceDetailController alloc]init];
        _detailController.superViewController=self;
    }
    return _detailController;
}

-(RKDemandChatController *)chatController{
    if (!_chatController) {
        _chatController=[[DemandAskPriceChatController alloc]init];
    }
    return _chatController;
}
@end
