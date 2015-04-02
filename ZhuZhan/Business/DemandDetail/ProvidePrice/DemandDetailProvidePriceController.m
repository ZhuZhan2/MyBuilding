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

-(void)demandDetailControllerLeftBtnClicked{
    [self.stageChooseView stageLabelClickedWithSequence:1];
}

-(void)leftBtnClicked{
    if([self.delegate respondsToSelector:@selector(backAndLoad)]){
        [self.delegate backAndLoad];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backView{
    if([self.delegate respondsToSelector:@selector(backAndLoad)]){
        [self.delegate backAndLoad];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(RKDemandDetailController *)detailController{
    if (!_detailController) {
        _detailController=[[DemandProvidePriceDetailController alloc]init];
        _detailController.askPriceModel = self.askPriceModel;
        _detailController.quotesModel = self.quotesModel;
        _detailController.superViewController=self;
        _detailController.delegate=self;
    }
    return _detailController;
}

-(RKDemandChatController *)chatController{
    if (!_chatController) {
        _chatController=[[DemandProvidePriceChatController alloc]init];
        _chatController.askPriceModel = self.askPriceModel;
        _chatController.quotesModel = self.quotesModel;
    }
    return _chatController;
}
@end
