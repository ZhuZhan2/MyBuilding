//
//  DemandDetailProvidePriceController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/24.
//
//

#import "DemandDetailProvidePriceController.h"
#import "DemandProvidePriceDetailController.h"
#import "DemandProvidePriceChatController.h"
@interface DemandDetailProvidePriceController ()

@end

@implementation DemandDetailProvidePriceController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(RKDemandDetailController *)detailController{
    if (!_detailController) {
        _detailController=[[DemandProvidePriceDetailController alloc]init];
        _detailController.superViewController=self;
    }
    return _detailController;
}

-(RKDemandChatController *)chatController{
    if (!_chatController) {
        _chatController=[[DemandProvidePriceChatController alloc]init];
    }
    return _chatController;
}
@end
