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

@end

@implementation DemandDetailAskPriceController

- (void)viewDidLoad {
    [super viewDidLoad];
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
